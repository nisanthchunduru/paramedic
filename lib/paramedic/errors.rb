module Paramedic
  class InvalidParam < StandardError
    attr_reader :param

    def initialize(param)
      @param = param
    end
  end

  class ParamMissing < InvalidParam
  end
  
  class ParamHasIncorrectType < InvalidParam
  end

  class IntegerParamIsNotWithinLimits < InvalidParam
  end

  class ArrayParamIsEmpty < InvalidParam
  end

  class ArrayParamHasTooManyElements < InvalidParam
  end

  class AtleastOneOfRequiredParamsNotProvided < StandardError
    attr_reader :params

    def initialize(params)
      @params = params
    end
  end
end
