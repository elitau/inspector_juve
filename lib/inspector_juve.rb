require 'yard'

require_relative 'inspector_juve/localizer/weakpoint_localizer'
require_relative 'inspector_juve/localizer/dependency_on_foreign_variables'
require_relative 'inspector_juve/localizer/missing_super_in_meethod_missing_method'
require_relative 'inspector_juve/localizer/no_super_call_in_overwritten_methods'

require_relative 'inspector_juve/object_repository'
require_relative 'inspector_juve/output'
require_relative 'inspector_juve/reporter'
require_relative 'inspector_juve/weakpoint'
require_relative 'inspector_juve/version'

module InspectorJuve
  class LocalizerFactory
    class << self
      def all_localizers(object_repository, reporters)
        [
          MissingSuperInMethodMissing,
          DependencyOnForeignVariables,
          NoSuperCallInOverwrittenMethods,
        ].map do |localizer_class|
          reporters << reporter = Reporter.new(localizer_class)
          localizer_class.new(
            object_repository: object_repository,
            reporter: reporter
          )
        end
      end
    end
  end

  class Reporters
    def initialize
      @output = Output.instance
      @reporters = []
    end

    def << reporter
      @reporters << reporter
    end

    def report
      @reporters.each do |reporter|
        @output.decorated_header("#{reporter.title}")
        reporter.report
      end
    end
  end

  module_function
  def run(yardoc_folder, reporters = Reporters.new)
    object_repository = ObjectRepository.new(yardoc_folder)
    LocalizerFactory.all_localizers(object_repository, reporters).each(&:search)
    reporters.report
  end

end
