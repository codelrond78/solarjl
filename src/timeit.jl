using Dates

I = 10000000

function f1()

    m = zeros(I)
    z = zeros(I)
    t0 = now()
    x = map(zip(m, z)) do (a, b)
        a + b + 1
    end
    t1 = now()
    println("f1 tiempo:", t0 - t1)
    x
end

function f2()
    m = zeros(I)
    x = zeros(I)
    z = zeros(I)
    t0 = now()
    for i in 1:I
        x[i] = m[i] + z[i] + 1
    end
    t1 = now()
    println("f2 tiempo:", t0 - t1)
    x
end

