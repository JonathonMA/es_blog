class AggregateRoot
  attr_reader :id
  attr_reader :version

  def initialize
    @uncommitted_changes = []
  end

  attr_reader :uncommitted_changes

  def mark_changes_as_committed
    @uncommitted_changes.clear
  end

  def load_from_history(events)
    events.each(&its.apply_change(event, false))
  end

  def apply_change(event, new = true)
    apply event
    @uncommitted_changes << event if new
  end

  def apply(event)
    handler_method = "on_#{event.class.name.underscore}"
    send handler_method, event
  end
end
