module InspectorJuve
  class WeakpointLocalizer
    attr_reader :object_repository, :reporter

    def initialize(object_repository: [], reporter: "")
      @object_repository = object_repository
      @reporter = reporter
      # Registry.load! yard_objects_folder
      # puts "Searching for #{self.class.name} weakpoint"
    end
  end
end
