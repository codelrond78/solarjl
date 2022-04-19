using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json
include("load_data.jl")
include("user_input.jl")
using .user
include("radiation.jl")
include("calculate.jl")

Genie.config.cors_headers["Access-Control-Allow-Origin"] = "http://localhost:3001"
Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"
Genie.config.cors_headers["Access-Control-Allow-Methods"] ="GET,POST,PUT,DELETE,OPTIONS" 
Genie.config.cors_allowed_origins = ["*"]

function main()
    w = load_data()

    route("/jsonpayload", method = POST) do
        #@show jsonpayload()
        #@show rawpayload()

        try
            user_input = get_user_input(String(rawpayload()))
            result = calculate(w, user_input)        
            json(result)
        catch e
            json(Dict("error" => String(e)))
        end        
    end

    print("listening at 0.0.0.0:8000")
    up(8000, "0.0.0.0", async = false)
end

main()

