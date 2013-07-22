# This module accesses the instance variables of the class it was mixed in
# without using a getter method
module WeakModule
  def some_module_method
    @instance_variable = "set by module WeakModule"
  end
end

class MainKlass
  include WeakModule
  def initialize
    @instance_variable = 'value set by constructor'
  end
end
