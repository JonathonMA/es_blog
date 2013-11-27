class BullShitDatabase
  class << self
    def list
      @list ||= []
    end

    def details
      @details ||= {}
    end

    def clear
      @list = []
      @details = {}
    end
  end
end
