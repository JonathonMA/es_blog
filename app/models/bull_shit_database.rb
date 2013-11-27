class BullShitDatabase
  class << self
    def list
      @list ||= []
    end

    def details
      @details ||= {}
    end
  end
end
