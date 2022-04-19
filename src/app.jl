using Genie, Genie.Router, Genie.Requests, Genie.Renderer.Json

struct myData
    x
end

route("/jsonpayload", method = POST) do
  @show jsonpayload()
  @show rawpayload()

  json(myData(5))
end

print("empezamos")

up(8000, "0.0.0.0", async = false)