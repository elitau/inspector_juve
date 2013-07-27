# This module accesses the instance variables of the class it was mixed in
# without using a getter method
module BadModule
  def bad_module_method
    @accessed_instance_variable = "set by module WeakModule"
    @modules_instance_variable = "That's mine"
  end

  def self.class_method_defined_in_module
    @class_variable_defined_in_module = 'Hello World'
  end

  module ModuleDefinedInOtherModule
    def method_in_module_defined_in_other_module
      # no op
    end
  end
end

class KlassIncludingBadModule
  include BadModule
  def initialize
    @accessed_instance_variable = 'value set by constructor'
  end
end

class AnotherKlass
  include BadModule
  def initialize
    @accessed_instance_variable = 'value set by AnotherKlass'
  end
end
