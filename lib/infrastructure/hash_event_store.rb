class HashEventStore
  class ConcurrencyViolation < StandardError; end
  EventDescriptor = Struct.new :id, :event_data, :version

  def initialize(publisher)
    @current = Hash.new { |h, k| h[k] = [] }
    @publisher = publisher
  end

  def save_events(aggregate_id, events, expected_version)
    if concurrency_violation?(aggregate_id, expected_version)
      fail ConcurrencyViolation
    end

    i = expected_version

    events.each do |event|
      i += 1
      event.version = i
      @current[aggregate_id] << EventDescriptor.new(aggregate_id, event, i)
      @publisher.publish event
    end
  end

  def get_events_for_aggregate(id)
    raise "aggregate not found: #{id}" unless @current.key? id

    @current[id].map { |ed| ed.event_data }
  end

  private

  def concurrency_violation?(aggregate_id, expected_version)
    expected_version != -1 &&
    @current[aggregate_id].last &&
    @current[aggregate_id].last.version != expected_version
  end
end
