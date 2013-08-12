class MissingSuperInMethodMissingFixture
  SOME_CONFIG = {}
  def method_missing(message, *args)
    SOME_CONFIG[message]
  end
end
