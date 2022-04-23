FROM julia:1.7.2-bullseye

COPY . .

RUN julia --project=env -e 'using Pkg; Pkg.instantiate()'
CMD julia --project=env src/app.jl
