class EventListener
  class << self
    def my_handlers
      @my_handlers ||= Hash.new { |h, k| h[k] = [] }
    end
  end

  def self.on event_name, &block
    klass = event_name.to_s.camelize.constantize
    EventBus.register_handler klass, block
    my_handlers[klass.name] << block
  end

  def self.private_replay repository
    repository.all_events.each do |id, events|
      events.each do |event|
        event = event.event_data
        my_handlers[event.class.name].each do |handler|
          handler.(event) if handler
        end
      end
    end
  end
end
