module user

export UserInput
export get_user_input

using JSON3
using StructTypes

struct UserInput
   a::Float64 
end

StructTypes.StructType(::Type{UserInput}) = StructTypes.Struct()

function get_user_input(payload::String)
    JSON3.read(payload, UserInput)
end

end  