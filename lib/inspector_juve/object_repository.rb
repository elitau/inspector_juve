module InspectorJuve
  class ObjectRepository

    def initialize(yardoc_folder)
      @yardoc_folder = yardoc_folder
    end

    def all_methods
      registry.all(:method)
    end

    def all_modules
      registry.all(:module)
    end

    def all_subclasses
      root.children.select{|namespace| namespace.class == YARD::CodeObjects::ClassObject && namespace.superclass.class == YARD::CodeObjects::ClassObject}
    end

    def root
      registry.root
    end

    private
      def registry
        load_registry unless registry_loaded?
        @registry
      end

      def load_registry
        YARD::Registry.load! @yardoc_folder
        @registry = YARD::Registry
      end

      def registry_loaded?
        @registry
      end
  end
end
