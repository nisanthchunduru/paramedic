module Paramedic
  module ActionControllerAdditions
    extend ActiveSupport::Concern

    included do
      rescue_from Paramedic::ParamMissing do |e|
        respond_with_error("Param '#{e.param.path}' is missing in request JSON")
      end

      rescue_from Paramedic::ParamHasIncorrectType do |e|
        param = e.param

        error_message = case param.expected_type
        when :integer
          "Param '#{param.path}' must be an integer"
        when :email
          "Param '#{param.path}' must be an email address"
        when :hash
          "Param '#{param.path}' must be a hash"
        when :array
          "Param '#{param.path}' must be an array"
        end

        respond_with_error(error_message)
      end

      rescue_from Paramedic::IntegerParamIsNotWithinLimits do |e|
        param = e.param
        min, max = param.options[:min], param.options[:max]

        respond_with_error("Param '#{param.path}' must be an integer between #{min} and #{max}")
      end

      rescue_from Paramedic::ArrayParamIsEmpty do |e|
        respond_with_error("Param '#{e.param.path}' must not be empty")
      end

      rescue_from Paramedic::ArrayParamHasTooManyElements do |e|
        param = e.param
        max_length = param.options[:max]
        respond_with_error("Param '#{param.path}' must be less than or equal to #{max_length} in size")
      end

      # rescue_from Paramedic::AtleastOneOfRequiredParamsNotProvided do |e|
      #   surrounded_param_paths = e.param_paths.map { |param_path| param_path.surround("'") }
      #   respond_with_error("Please provide key #{surrounded_param_paths.join(' or ')}")
      # end
    end

    # @todo Add examples
    def respond_with_error(error_message, options = {})
      error_hash = {
        message: error_message
      }
      errors = [error_hash]

      status = options[:status] || 422
      render json: { errors: errors }, status: status
    end
  end
end