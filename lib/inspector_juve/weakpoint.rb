module InspectorJuve
  class Weakpoint
    attr_reader :code_object

    def initialize(code_object, error_message)
      @error_message = error_message
      @code_object = code_object
    end

    def message
      "#{code_object.to_s} #{@error_message} in #{path(code_object)}"
    end

    def to_s
      message
    end

    private
    def path(code_object)
      code_object.files.first.join(":")
    end
  end
end
