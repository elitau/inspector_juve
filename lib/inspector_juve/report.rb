module InspectorJuve
  class Report
    def initialize
      @entries = []
    end
    def <<(entry)
      @entries << entry
    end

    def entries
      @entries
    end
  end
end
