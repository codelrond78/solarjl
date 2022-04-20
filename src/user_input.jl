module user

export get_user_input, UserInput, MissingInput, DomainErrorInput

using JSON3
using StructTypes
using Exceptions

mutable struct InputErrors <: Exception
    msg
end

struct UserInput
   angle
   azimut
   yearconsume
   typedayconsume
   typeyearconsume
   numpanels
   bonopercentage
end

StructTypes.StructType(::Type{UserInput}) = StructTypes.Struct()

function get_user_input(payload::String)
    ui = JSON3.read(payload, UserInput)
    validate(ui)  
    ui
end

function validate(input::UserInput)
    response = []

    if isnothing(input.angle)
        push!(response, "angle: missing")
    elseif input.angle < 0.0 || input.angle > 90.0 
        push!(response, "angle: must be 0.0 <= angle <= 90.0")
    end

    if isnothing(input.azimut)
        push!(response, "azimut: missing")
    elseif input.azimut < -90.0 || input.angle > 90.0
        push!(response, "azimut: must be -90.0 <= azimut <= 90.0")
    end

    if isnothing(input.yearconsume)
        push!(response, "yearconsume: missing")
    elseif input.yearconsume < 0
        push!(response, "yearconsume: must be yearconsume >= 0")
    end

    if isnothing(input.typedayconsume)
        push!(response, "typedayconsume: missing")
    elseif input.typedayconsume < 1 || input.typedayconsume > 3
        push!(response, "typedayconsume: must be typedayconsume in [1, 2, 3]")
    end

    if isnothing(input.typeyearconsume)
        push!(response, "typeyearconsume: missing")
    elseif input.typeyearconsume < 1 || input.typeyearconsume > 3
        push!(response, "typeyearconsume: must be typeyearconsume in [1, 2, 3]")
    end

    if isnothing(input.numpanels)
        push!(response, "numpanels: missing")
    elseif input.numpanels < 0
        push!(response, "numpanels: must be numpanels >= 0")
    end

    if isnothing(input.bonopercentage)
        push!(response, "bonopercentage: missing")
    elseif input.bonopercentage < 0 || input.bonopercentage > 1
        push!(response, "bonopercentage: must be bonopercentage in [0, 1]")
    end

    if length(response) != 0 
        throw(InputErrors(join(response, "\n")))
    end
end

end  