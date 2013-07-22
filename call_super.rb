# Not calling implementation of superclass
class BasisKlass
  def initialize
    @count = 0
  end

  # this method can be overwritten, but should still be called by overwritten
  # method in sublcass
  def do_something
    @count = 42
  end
end

class SomeClass < BasisKlass
  # this mehtod should be calling super
  def do_something
    # super
    @count += 23
  end
end

