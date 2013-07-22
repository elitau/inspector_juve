# Not calling implementation of superclass
class BasisKlass
  def initialize
    @count = 0
  end

  def do_something
    this_should_always_be_done
  end

  # Calculate initial value
  def this_should_always_be_done
    @count = 42
  end
end

class SomeClass < BasisKlass

  def do_something
    super
    @count += 23
    report
  end

  def report
    puts @count == 65 ? 'success' : 'failure'
  end

end

