# Detects overwritten methods that are not calling super

module InspectorJuve
  class NoSuperCallInOverwrittenMethods < WeakpointLocalizer
    class << self
      def title
        "Overwritten methods not calling super of base class"
      end
    end

    def search
      search_missing_super_call_in_overwritten_methods
    end

    def search_missing_super_call_in_overwritten_methods
      object_repository.all_subclasses.each do |sub_class|
        if has_overwritten_methods?(sub_class)
          overwritten_methods(sub_class).each do |method|
            reporter << Weakpoint.new(method, 'has no super call') unless includes_super_call?(method)
          end
        end
      end
    end

    private

    def has_overwritten_methods?(klass)
      not overwritten_methods(klass).empty?
    end

    def overwritten_methods(klass)
      return [] unless superklass(klass)
      names = not_inherited_methods(klass).map(&:name) & methods_of_superclass(klass).map(&:name)
      klass.meths.select{|method| names.include? method.name}
    end

    def not_inherited_methods(klass)
      klass.meths - klass.inherited_meths
    end

    def methods_of_superclass(klass)
      klass.superclass.meths
    end

    def superklass(klass)
      klass.inheritance_tree.size > 1
      # klass.superclass
    end

    def includes_super_call?(method)
      without_comments(method.source).include?('super')
    end

    def without_comments(source)
      source.gsub(/#.*$/,'')
    end

  end
end
