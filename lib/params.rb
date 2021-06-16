# module Paramedic
#   class Params < Hash
#     def value_at_path(param_path)
#       dig(*param_path.split("."))
#     end

#     def insert_at_path(param_path, param_value)
#       bury(*(param_path.split(".") + [param_value]))
#     end
#   end
# end

class Hash
  def value_at_path(param_path)
    dig(*param_path.split("."))
  end

  def insert_at_path(param_path, param_value)
    bury(*(param_path.split(".") + [param_value]))
  end
end
