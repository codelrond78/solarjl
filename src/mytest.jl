include("./radiation.jl")
using Test
using .radiation

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
