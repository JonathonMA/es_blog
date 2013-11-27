def ActiveModel *args, &block
  Class.new do
    include ActiveModel::Model

    attr_accessor *args

    instance_eval &block if block_given?

    alias_method :to_param, :id
  end
end

def Event(*args)
  Struct.new(*args) do
    attr_accessor :version
  end
end
