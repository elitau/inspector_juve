require 'yard'

require_relative 'inspector_juve/localizer/weakpoint_localizer'
require_relative 'inspector_juve/localizer/dependency_on_foreign_variables'
require_relative 'inspector_juve/localizer/missing_super_in_meethod_missing_method'

require_relative 'inspector_juve/object_repository'
require_relative 'inspector_juve/reporter'
require_relative 'inspector_juve/weakpoint'
require_relative 'inspector_juve/version'

module InspectorJuve
  class LocalizerFactory
    class << self
      def all_localizers(object_repository, reporter)
        [MissingSuperInMethodMissing.new(
          object_repository: object_repository,
          reporter: reporter
          )
        ]
      end
    end
  end

  module_function
  def run(yardoc_folder, reporter = Reporter.new)
    object_repository = ObjectRepository.new(yardoc_folder)
    LocalizerFactory.all_localizers(object_repository, reporter).each(&:search)
    reporter.report
  end

end
