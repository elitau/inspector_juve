module InspectorJuve
  class MissingSuperInMethodMissing < WeakpointLocalizer
    class << self
      def title
        "MethodMissing methods not calling super or raising NoMethodError"
      end
    end

    def search
      all_method_missing_methods.select do |mm_method|
        unless mm_method.source =~ /super|NoMethodError/
          reporter << Weakpoint.new(mm_method, 'has no super call')
        end
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
