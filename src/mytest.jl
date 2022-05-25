include("./user_input.jl")
include("./radiation.jl")
include("./currency.jl")

using Test
using JSON3
using Unitful

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
    end;

    @testset "validate user input radiation fail parsing" begin
        errors = []    
        radiation = JSON3.read("[[1, 2, 3], [4, 5, \"6\"]]")
        validate_radiation!(radiation, errors, (2, 3))
        @test errors == ["parsing error on radiation"]
    end;

    @testset "validate user input radiation fail parsing different row size" begin
        errors = []    
        radiation = JSON3.read("[[1, 2, 3], [4, 5]]")
        validate_radiation!(radiation, errors, (2, 3))
        @test errors == ["parsing error on radiation"]
    end;

    @testset "validate user input radiation fail size" begin
        errors = []    
        radiation = JSON3.read("[[1, 2, 3]]")
        validate_radiation!(radiation, errors, (2, 3))
        @test errors == ["radiation size error, expected (2, 3), received (1, 3)"]
    end;

    @testset "validate user input radiation received other different an array" begin
        errors = []    
        radiation = JSON3.read("1")
        validate_radiation!(radiation, errors, (2, 3))
        @test errors == ["parsing error on radiation"]
    end;

    @testset "test units" begin
        @test 1u"kg" == 1000u"g" 
    end;

    @testset "test units currency" begin
        @test 2u"€" == 2*1u"€"
    end;

end

run()