module InspectorJuve
  class WeakpointLocalizer
    attr_reader :object_repository, :reporter

    def initialize(object_repository: [], reporter: "")
      @object_repository = object_repository
      @reporter = reporter
    end

    class << self
      def title
        name
      end
    end
  end
end
