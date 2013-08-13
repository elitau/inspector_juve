module InspectorJuve
  class Reporter
    def initialize
      @entries = []
    end
    def <<(entry)
      @entries << entry
    end

    def entries
      @entries
    end

    def report
      entries.each do |entry|
        puts entry.to_s
      end
    end
  end
end
