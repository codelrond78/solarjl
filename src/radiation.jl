using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json
using HTTP
using JSON

function radiation(latitude::Float64, longitude::Float64)
    println("previo request")
    x = HTTP.request("GET", "http://localhost:3000/posts")
    println("x")
    body = String(x.body)
    println("body")
    JSON.parse(body)
end

println("empezamos")
response = radiation(0.0, 0.0)
println("response")
x = get(response[1], "a", missing)
println(x, typeof(x))