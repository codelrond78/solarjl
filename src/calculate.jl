using .user
using .radiation
struct Result
    a::Float64
end

function calculate(w, user_input::UserInput)
    println(w, user_input)
    get_radiation(0.0, 0.0)
    Result(user_input.a)
end