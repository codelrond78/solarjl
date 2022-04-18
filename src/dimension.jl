import Dates

module dimension

const M = 12;
const D = 31;
const H = 24;

struct MDH
    c::Array{Union{Missing, Float32}, 3} 
    MDH() = new(Array{Union{Missing, Float32}, 3}(missing, M, D, H))
end

function Base.getindex(self::MDH, m, d, h)
    self.c[m, d, h]
end

function Base.setindex!(self::MDH, v, m, d, h)
    self.c[m, d, h] = v
end

function Base.sum(self::MDH)
    sum(skipmissing(self.c))
end

struct MH
    c::Array{Union{Missing, Float32}, 2} 
    MH() = new(Array{Union{Missing, Float32}, 2}(missing, M, H))
end

function Base.getindex(self::MH, m, _, h)
    self.c[m, h]
end

function Base.setindex!(self::MH, v, m, _, h)
    self.c[m, h] = v
end

end

println("emepezamos")
m = dimension.MDH()
println(m[1,1,1])
m[1,1,1] = 1.3;
println(m[1,1,1])

for p in Iterators.product(1:3,1:2)
    @show p
end

#Dates.DateTime(2013,2,30)