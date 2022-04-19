using HTTP

function radiation(latitude::Float64, longitude::Float64)
    HTTP.request("GET", "http://httpbin.org/ip")
end
#r = HTTP.request("GET", "http://httpbin.org/ip"; verbose=3)
#println(r.status)
#println(String(r.body))