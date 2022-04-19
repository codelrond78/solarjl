using .user

struct Result
    a::Float64
end

function calculate(w, user_input::UserInput)
    println(w, user_input)
    Result(user_input.a)
end