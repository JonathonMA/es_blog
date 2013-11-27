class Bus
  def initialize
    @routes = Hash.new { |h, k| h[k] = [] }
  end

  attr_reader :routes

  def register_handler(type, handler)
    @routes[type.name] << handler
  end

  def send_command(command)
    Rails.logger.info "BUS/CMD: #{command}"
    handler = @routes[command.class.name].first

    handler.call command if handler
  end

  def publish(event)
    Rails.logger.info "BUS/EVT: #{event}"
    # find all listeners and publish the event to them
    @routes[event.class.name].each(&its.call(event))
  end
end
