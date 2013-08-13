class MissingSuperInMethodMissingFixture
  SOME_CONFIG = {}
  def method_missing(message, *args)
    SOME_CONFIG[message]
  end
end

class CorrectSuperCallInMethodMissing
  def method_missing(meth, *args, &blk)
    super
  end
end
