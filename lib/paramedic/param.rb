module Paramedic
  class Param
    attr_reader :path, :value, :options

    def initialize(path, value, options = {})
      @path = path
      @value = value
      @options = options
    end

    def required?
      !!options[:required]
    end

    def optional?
      !required?
    end

    def expected_type
      options[:type] || default_type
    end

    def default_value
      options[:default]
    end

    def has_default_value?
      !!default_value
    end

    private

    def default_type
      :string
    end
  end
end
