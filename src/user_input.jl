module user

export get_user_input, UserInput, MissingInput, DomainErrorInput

using JSON3
using StructTypes
using Exceptions

mutable struct InputErrors <: Exception
    msg: [String]
end

struct UserInput
   deep
   width
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

    if isnothing(input.deep)
        push!(response, "deep: missing")
    elseif input.deep < 0.0 
        push!(response, "deep: must be 0.0 < deep")
    end

    if isnothing(input.width)
        push!(response, "width: missing")
    elseif input.width < 0.0
        push!(response, "width: must be 0.0 < width")
    end

    if isnothing(input.yearconsume)
        push!(response, "yearconsume: missing")
    elseif input.yearconsume < 0
        push!(response, "yearconsume: must be yearconsume >= 0")
    end

    if isnothing(input.typedayconsume)
        push!(response, "typedayconsume: missing")
    elseif !(1 <= input.typedayconsume <= 3)
        push!(response, "typedayconsume: must be typedayconsume in [1, 2, 3]")
    end

    if isnothing(input.typeyearconsume)
        push!(response, "typeyearconsume: missing")
    elseif !(1 <= input.typeyearconsume <= 3)
        push!(response, "typeyearconsume: must be typeyearconsume in [1, 2, 3]")
    end

    if isnothing(input.numpanels)
        push!(response, "numpanels: missing")
    elseif input.numpanels < 0
        push!(response, "numpanels: must be numpanels >= 0")
    end

    if isnothing(input.bonopercentage)
        push!(response, "bonopercentage: missing")
    elseif !(0 <= input.bonopercentage <= 1)
        push!(response, "bonopercentage: must be bonopercentage in [0, 1]")
    end

    if length(response) != 0 
        #throw(InputErrors(join(response, "\n")))
        throw(InputErrors(response))
    end
end

end  