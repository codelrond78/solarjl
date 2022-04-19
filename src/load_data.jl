using DelimitedFiles

function load_data()
    x = readdlm("src/data.csv", ',', Float64)
    Dict("x"=>x)
end