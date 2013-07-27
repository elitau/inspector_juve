class DependencyOnForeignVariables
  include YARD
  class MethodBody
    InstanceVariable = Struct.new(:name, :method) do
      def == other
        name == other.name
      end
      alias_method :eql?, :==

      def hash
        name.hash
      end

      def inspect
        "#<#{name} in #{method.name}>"
      end
    end
    def initialize meth
      @method = meth
    end

    def instance_variables
      source_without_comments.scan(/@\w+/).map { |name| InstanceVariable.new(name, @method) }
    end

    def source_without_comments
      @method.source.gsub(/#.*$/, '')
    end
  end

  def initialize(yard_objects_folder)
    Registry.load! yard_objects_folder
    puts "Searching for weak points in #{yard_objects_folder}"
  end

  def search
    search_access_instance_variable_in_module
  end

  private

  # TODO: Handle meths mixed in from other modules
  def search_access_instance_variable_in_module
    modules_with_use_of_instance_variables(all_modules).each do |modul|
      instance_variables_defined_outside_of(
        modul,
        instance_variables_accessed_by_module(modul)
      ).each do |instance_variable|
        puts "Method #{instance_variable.method} accesses instance variable #{instance_variable.name}"
      end
    end
  end

  def all_modules
    log "Searching for all modules..."
    @all_modules ||= Registry.root.children.select do |class_or_module|
      class_or_module.class == YARD::CodeObjects::ModuleObject
    end
    log "Found #{@all_modules}"
    @all_modules
  end

  def log(message)
    # puts message
  end

  def modules_with_use_of_instance_variables(modules)
    log 'Checking of modules uses instance variables...'
    @modules_using_instance_variables ||= modules.select do |modul|
      modul.meths.any? { |meth| includes_instance_variables(meth.source)}
    end
    log "Modules using instance variables: #{@modules_using_instance_variables}"
    @modules_using_instance_variables
  end

  # @return [Array] instance variable names
  def instance_variables_accessed_by_module(modul)
    log "Searching for instance variables accessed by modul(#{modul})..."
    instance_variables = modul.meths.select{ |meth| includes_instance_variables(meth.source)}.map do |meth|
      MethodBody.new(meth).instance_variables
    end.flatten
    log "modul used #{instance_variables}"
    instance_variables
  end

  # Returns instance variables that are used in other than the given module
  # and is one of the given instance variables
  #
  # @param [YARD::CodeObjects::ModuleObject] a module object
  # @param [Array, #each] instance variables to search for
  # @param [YARD::CodeObjects::Base] instance variables to search for
  # @return [Array] the matched instance variable names
  def instance_variables_defined_outside_of(modul, instance_variables, root = Registry.root)
    log("instance_variables_defined_outside_of: #{modul}")
    return [] if modul == root
    variables = []
    root.children.each do |child|
      variables.concat instance_variables_defined_outside_of(modul, instance_variables, child)
    end if root.respond_to?(:children)
    variables.concat class_or_module_uses_variables(root, instance_variables)
  end

  # @return [Array] matched variable names
  def class_or_module_uses_variables(class_or_module, variables)
    return [] unless class_or_module.is_a? YARD::CodeObjects::NamespaceObject
    log "Checking use of variables in #{class_or_module} for #{variables}"
    only_self_defined_meths(class_or_module).map do |meth|
      MethodBody.new(meth).instance_variables & variables
    end.flatten
  end

  def only_self_defined_meths(class_or_module)
    class_or_module.meths - class_or_module.included_meths
  end

  def includes_instance_variables(source)
    without_comments(source) =~ / @\w+/
  end

  def without_comments(source)
    source.gsub(/#.*$/,'')
  end
end
