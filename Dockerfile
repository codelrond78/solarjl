FROM julia:1.8.0-beta3-alpine

COPY . .

CMD julia --project=env src/app-docker.jl
