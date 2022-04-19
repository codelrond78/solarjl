module radiation

export get_radiation

using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json
using HTTP
using JSON3
using StructTypes

struct Radiation
    a::Float64 
end

StructTypes.StructType(::Type{Radiation}) = StructTypes.Struct()

function get_radiation(latitude::Float64, longitude::Float64)
    x = HTTP.request("GET", "http://localhost:3000/posts")
    body = String(x.body)
    #JSON.parse(body)
    JSON3.read(body, Radiation)
end

end