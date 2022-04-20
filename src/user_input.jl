module user

export get_user_input, UserInput

using JSON3
using StructTypes

struct UserInput
   angle::Float64 
   azimut::Float64 
   yearconsume::Float64
   typedayconsume::Int64
   typeyearconsume::Int64
   numpanels::Int64
   bonopercentage::Int64
end

StructTypes.StructType(::Type{UserInput}) = StructTypes.Struct()

function get_user_input(payload::String)
    try
        ui = JSON3.read(payload, UserInput)
    catch
        throw(MissingException("Error parsing payload"))
    end
    v = validate(ui)
    if length(v) == 0 
        return ui
    else
        throw(DomainError(ui, join(v, "\n")))
    end
end

function validate(input::UserInput)
    response = []
    if input.angle < 0.0 || input.angle > 90.0 
        push!(response, "angle: must be 0.0 <= angle <= 90.0")
    end
    if input.azimut < -90.0 || input.angle > 90.0
        push!(response, "azimut: must be -90.0 <= azimut <= 90.0")
    end
    if input.yearconsume < 0
        push!(response, "yearconsume: must be yearconsume >= 0")
    end
    if input.typedayconsume < 1 || input.typedayconsume > 3
        push!(response, "typedayconsume: must be typedayconsume in [1, 2, 3]")
    end
    if input.typeyearconsume < 1 || input.typeyearconsume > 3
        push!(response, "typeyearconsume: must be typeyearconsume in [1, 2, 3]")
    end
    if input.numpanels < 0
        push!(response, "numpanels: must be numpanels >= 0")
    end
    if input.bonopercentage < 0 || input.bonopercentage > 1
        push!(response, "bonopercentage: must be bonopercentage in [0, 1]")
    end
    response
end

end  