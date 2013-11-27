class Bus
  def initialize
    @routes = Hash.new { |h, k| h[k] = [] }
  end

  attr_reader :routes

  def register_handler(type, handler)
    @routes[type] << handler
  end

  def send(command)
    handler = @routes[command.class].first

    handler.call command if handler
  end

  def publish(event)
    # find all listeners and publish the event to them
    @routes[event.class].each(&its.call(event))
  end
end
