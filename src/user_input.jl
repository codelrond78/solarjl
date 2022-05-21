module user

export get_user_input, UserInput, MissingInput, DomainErrorInput, validate_input, 
       required, positive, anyof,integer

using JSON3
using StructTypes
using Exceptions

mutable struct InputErrors <: Exception
    msg
end

const CSVL = 8040

mutable struct UserInput
   radiation
   deep
   width
   yearconsume
   typedayconsume
   typeyearconsume
   numpanels
   bonopercentage
   usecsv
   ree
   rented
   socialb
   power
   powerrentedvalle
   fixedrate
   fixedvalle
   vallerate
   vallellano
   picorate
   otherconcepts
   panelpower
   batterycapacity
   inversorpower
   carannualkm
   electriccarpower
   carefficiency
end

StructTypes.StructType(::Type{UserInput}) = StructTypes.Struct()

function get_user_input(payload::String)
    ui = JSON3.read(payload, UserInput)
    validate!_all(ui)  
    ui
end

function validate_input(obj, errors)
    function validate!(attr, pipe, type)
        attr_s = Symbol(attr)
        x = getfield(obj, attr_s)
        for f in pipe
            f(x, attr, errors)
        end
        if length(errors) == 0
            setfield!(obj, attr_s, type(x))
        end
    end
end

function required(x, attr, errors)
    if isnothing(x)
        push!(errors, "$(attr): missing")    
    end
end

function integer(x, attr, errors)
    if !isinteger(x)
        push!(errors, "$(attr): must be integer")
    end
end

function positive(x, attr, errors)
    if !(isa(x, Number) && x >= 0)
        push!(errors, "$(attr): must be >= 0")
    end
end

function any_of(range...)
    function (x, attr, errors)
        if !(isinteger(x) && x in range)
            push!(errors, "$(attr): must be in $(range)")
        end
    end
end

function boolean(x, attr, errors)
    if isa(x, Bool)
        push!(errors, "$(attr): must be boolean")
    end
end

function validate_all(input::UserInput)
    
    errors = []
    validate! = validate_input(input, errors)
    
    validate!("radiation", [required])

    try
        radiation = reduce(vcat,transpose.(input.radiation))
        t = size(radiation)
        if t != (24, 12)
            push!(response, "csv length expected, (24, 12), received $(t)")    
        end
    catch
        push!(response, "parsing error on radiation")    
    end
    
    validate!("deep", [required, positive], Float64)
    validate!("width", [required, positive], Float64)
    validate!("yearconsume", [required, positive], Float64)
    validate!("typedayconsume", [required, any_of(1, 2, 3)], Int64)
    validate!("typeyearconsume", [required, any_of(1, 2, 3)], Int64)
    validate!("typeyearconsume", [required, integer, positive], Int64)
    validate!("bonopercentage", [required, any_of(0, 1)], Int64)
    validate!("usecsv", [required, boolean], Bool)

    if input.usecsv
        if isnothing(input.csv)
            push!(response, "usecsv and csv: missing")
        else
            try
                csv = reduce(vcat,transpose.(input.csv))
                t = size(csv)
                if t != (CSVL, 2)
                    push!(response, "csv length expected, ($(CSVL), 2), received $(t)")    
                else
                    input.csv = csv    
                end
            catch
                push!(response, "parsing error on csv")    
            end
        end
    end

    validate!("ree", [required, boolean], Bool)
    validate!("rented", [required, boolean], Bool)
    validate!("socialb", [required, boolean], Bool)
    validate!("power", [required, positive], Float64)
    validate!("powerrentedvalle", [required, positive], Float64)
    validate!("fixedrate", [required, positive], Float64)
    validate!("fixedvalle", [required, positive], Float64)
    validate!("vallerate", [required, positive], Float64)
    validate!("vallellano", [required, positive], Float64)
    validate!("picorate", [required, positive], Float64)
    validate!("otherconcepts", [required, positive], Float64)
    validate!("panelpower", [required, positive], Float64)
    validate!("batterycapacity", [required, positive], Float64)
    validate!("inversorpower", [required, positive], Float64)
    validate!("carannualkm", [required, positive], Float64)
    validate!("electriccarpower", [required, positive], Float64)
    validate!("carefficiency", [required, positive], Float64)

    if length(errors) != 0 
        throw(InputErrors(response))
    end

    return userinput
end

end  