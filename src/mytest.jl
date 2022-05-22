include("./user_input.jl")
include("./radiation.jl")
using Test
using JSON3
using .radiation
using .user

mutable struct Abc
    a
    b
    c
end

function run()
    @testset "time pos" begin    
        @test time_pos("00:00") == 0
        @test time_pos("01:00") == 1
        @test time_pos("10:00") == 10
    end;

    @testset "radiation mx" begin    
        output = Output([])
        @test radiation_mx(output; d=2, h=2) == zeros(2, 2)

        output = Output([Dict("time" => "00:00", "month" => 1, "G(i)" => 5.3)])
        @test radiation_mx(output; d=2, h=2) == [5.3 0.0; 0.0 0.0]
    end;

    #=
    @testset "validate user input" begin    
        datajson = """{"angle": 0.0, "azimut": 0.0}""" 
        @test_throws MissingInput get_user_input(datajson)
        datajson = """{"angle": 0.0, "azimut": 0.0, "yearconsume": 0.0, "typedayconsume": 0, "typeyearconsume": 0, "numpanels": -1, "bonopercentage": 0}""" 
        @test_throws DomainErrorInput get_user_input(datajson)
    end;
    =#

    @testset "validate user input" begin
        input = Abc(nothing, nothing, nothing)
        errors = []    
        validate! = validate_input(input, errors)
        validate!("a", [required, positive], Float64)
        @test errors == ["a: missing", "a: must be >= 0"]
    end;

    @testset "validate user input radiation" begin
        errors = []    
        radiation = JSON3.read("[[1, 2, 3], [4, 5, 6]]")
        r = validate_radiation!(radiation, errors, (2, 3))
        @test r == [1 2 3; 4 5 6]
        #@test errors == ["a: missing", "a: must be >= 0"]
    end;

end

run()