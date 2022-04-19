using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json

Genie.config.cors_headers["Access-Control-Allow-Origin"] = "http://localhost:3001"
Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"
Genie.config.cors_headers["Access-Control-Allow-Methods"] ="GET,POST,PUT,DELETE,OPTIONS" 
Genie.config.cors_allowed_origins = ["*"]

struct myData
    x
end

route("/jsonpayload", method = POST) do
  @show jsonpayload()
  @show rawpayload()

  println(typeof(jsonpayload()["a"]))

  json(myData(5))
end

print("empezamos")

up(8000, "0.0.0.0", async = false)