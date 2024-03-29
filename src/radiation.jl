module radiation

export get_radiation, time_pos, Output, radiation_mx

using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json
using HTTP
using JSON3
using StructTypes

struct Output
    daily_profile::Vector{Dict}
end
struct Radiation
    inputs::Dict
    outputs::Output
    meta::Dict
end

StructTypes.StructType(::Type{Radiation}) = StructTypes.Struct()

function get_radiation(latitude::Float64, longitude::Float64, angle::Float64, azimut::Float64)
    month = 0
    url = "https://re.jrc.ec.europa.eu/api/DRcalc?lat=$latitude&lon=$longitude&raddatabase=PVGIS-SARAH&angle=$angle&aspect=$azimut&outputformat=json&userhorizon=&usehorizon=1&js=1&select_database_daily=PVGIS-SARAH&month=$month&localtime=1&global=1&clearsky=1&dangle=$angle&daspect=$azimut&glob_2axis=1"
    x = HTTP.request("GET", url)
    body = String(x.body)    
    y = JSON3.read(body, Radiation)
    println(y.outputs.daily_profile)
    y
end

function time_pos(s::String)
    parse(Int64, split(s, ":")[1])
end

function radiation_mx(rr::Output; d::Int64=12, h::Int64=24)
    output = zeros(d, h)
    for r in rr.daily_profile
        pos = time_pos(r["time"])
        output[pos + 1, r["month"]] = r["G(i)"]
    end
    output
end

end