class EventListener
  def self.on event_name, &block
    klass = event_name.to_s.camelize.constantize
    EventBus.instance.register_handler klass, block
  end
end
