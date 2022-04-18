include("./myf.jl")
using Test

@testset "first tests ;)" begin    
    a::Int64 = 1
    b::Int64 = 1
    c::Float64 = 0.0
    @test get_perfil_personalizado(a, b, c)[1, 1] == 0.0
end;