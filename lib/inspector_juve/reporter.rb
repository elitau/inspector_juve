module InspectorJuve
  class Reporter
    attr_reader :entries, :localizer

    def initialize(localizer = :no_specific_localizer)
      @localizer = localizer
      @entries = []
    end

    def <<(entry)
      @entries << entry unless @entries.any? { |e| e.to_s == entry.to_s }
    end

    def entries
      @entries
    end

    def title
      @localizer.title
    end

    def report
      entries.each do |entry|
        puts entry.to_s
      end
    end

  end
end
