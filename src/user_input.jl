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
    validate(ui)  
    ui
end

function validate(input::UserInput)
    response = []

    if isnothing(input.deep)
        push!(response, "deep: missing")
    elseif !isa(input.deep, Number) || input.deep < 0.0 
        push!(response, "deep: must be 0.0 < deep")
    end

    if isnothing(input.width)
        push!(response, "width: missing")
    elseif !isa(input.width, Number) || input.width < 0.0
        push!(response, "width: must be 0.0 < width")
    end

    if isnothing(input.yearconsume)
        push!(response, "yearconsume: missing")
    elseif !isa(input.yearconsume, Number) || input.yearconsume < 0
        push!(response, "yearconsume: must be yearconsume >= 0")
    end

    if isnothing(input.typedayconsume)
        push!(response, "typedayconsume: missing")
    elseif !isinteger(input.typedayconsume) || !(1 <= input.typedayconsume <= 3)
        push!(response, "typedayconsume: must be typedayconsume in [1, 2, 3]")
    end

    if isnothing(input.typeyearconsume)
        push!(response, "typeyearconsume: missing")
    elseif !isinteger(input.typeyearconsume) || !(1 <= input.typeyearconsume <= 3)
        push!(response, "typeyearconsume: must be typeyearconsume in [1, 2, 3]")
    end

    if isnothing(input.numpanels)
        push!(response, "numpanels: missing")
    elseif !isinteger(input.numpanels) || input.numpanels < 0
        push!(response, "numpanels: must be numpanels >= 0")
    end

    if isnothing(input.bonopercentage)
        push!(response, "bonopercentage: missing")
    elseif !isinteger(input.bonopercentage) || !(0 <= input.bonopercentage <= 1)
        push!(response, "bonopercentage: must be bonopercentage in [0, 1]")
    end

    if isnothing(input.usecsv)
        push!(response, "usecsv: missing")
    end

    if isnothing(input.ree)
        push!(response, "ree: missing")
    end

    if isnothing(input.rented)
        push!(response, "rented: missing")
    end

    if isnothing(input.socialb)
        push!(response, "socialb: missing")
    end

    if isnothing(input.power )
        push!(response, "power: missing")
    elseif !isa(input.power , Number) || input.power < 0
        push!(response, "power: must be power >= 0")
    end

    if isnothing(input.powerrentedvalle )
        push!(response, "powerrentedvalle: missing")
    elseif !isa(input.powerrentedvalle , Number) || input.powerrentedvalle < 0
        push!(response, "powerrentedvalle: must be powerrentedvalle >= 0")
    end

    if isnothing(input.fixedrate )
        push!(response, "fixedrate: missing")
    elseif !isa(input.fixedrate , Number) || input.fixedrate < 0
        push!(response, "fixedrate: must be fixedrate >= 0")
    end

    if isnothing(input.fixedvalle )
        push!(response, "fixedvalle: missing")
    elseif !isa(input.fixedvalle , Number) || input.fixedvalle < 0
        push!(response, "fixedvalle: must be fixedvalle >= 0")
    end

    if isnothing(input.vallerate )
        push!(response, "vallerate: missing")
    elseif !isa(input.vallerate , Number) || input.vallerate < 0
        push!(response, "vallerate: must be vallerate >= 0")
    end

    if isnothing(input.vallellano )
        push!(response, "vallellano: missing")
    elseif !isa(input.vallellano , Number) || input.vallellano < 0
        push!(response, "vallellano: must be vallellano >= 0")
    end

    if isnothing(input.picorate )
        push!(response, "picorate: missing")
    elseif !isa(input.picorate , Number) || input.picorate < 0
        push!(response, "picorate: must be picorate >= 0")
    end

    if isnothing(input.otherconcepts )
        push!(response, "otherconcepts: missing")
    elseif !isa(input.otherconcepts , Number) || input.otherconcepts < 0
        push!(response, "otherconcepts: must be otherconcepts >= 0")
    end

    if isnothing(input.panelpower )
        push!(response, "panelpower: missing")
    elseif !isa(input.panelpower , Number) || input.panelpower < 0
        push!(response, "panelpower: must be panelpower >= 0")
    end

    if isnothing(input.batterycapacity )
        push!(response, "batterycapacity: missing")
    elseif !isa(input.batterycapacity , Number) || input.batterycapacity < 0
        push!(response, "batterycapacity: must be batterycapacity >= 0")
    end

    if isnothing(input.inversorpower )
        push!(response, "inversorpower: missing")
    elseif !isa(input.inversorpower , Number) || input.inversorpower < 0
        push!(response, "inversorpower: must be inversorpower >= 0")
    end

    if isnothing(input.carannualkm )
        push!(response, "carannualkm: missing")
    elseif !isa(input.carannualkm , Number) || input.carannualkm < 0
        push!(response, "carannualkm: must be carannualkm >= 0")
    end

    if isnothing(input.electriccarpower )
        push!(response, "electriccarpower: missing")
    elseif !isa(input.electriccarpower , Number) || input.electriccarpower < 0
        push!(response, "electriccarpower: must be electriccarpower >= 0")
    end

    if isnothing(input.carefficiency )
        push!(response, "carefficiency: missing")
    elseif !isa(input.carefficiency , Number) || input.carefficiency < 0
        push!(response, "carefficiency: must be carefficiency >= 0")
    end

    if length(response) != 0 
        throw(InputErrors(response))
    end
end

end  