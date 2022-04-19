include("./radiation.jl")
using Test
using .radiation

@testset "first tests ;)" begin    
    @test time_pos("01:00") == 1
end;