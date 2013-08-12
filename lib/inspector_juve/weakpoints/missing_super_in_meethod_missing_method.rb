module InspectorJuve
  class MissingSuperInMethodMissing < WeakpointLocalizer
    def search
      all_method_missing_methods.select do |mm_method|
        # mm_method.source !~ /super/
        @reporter << mm_method
      end
    end

    private
      def all_method_missing_methods
        object_repository.all_methods.select do |method|
          method.name == :method_missing
        end
      end
  end
end
