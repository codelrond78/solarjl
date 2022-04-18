function get_auxM(perfil_consumo_anual::Int64, perfil_consumo_diario::Int64, consumo_anual::Float64)
    zeros(12)
end

function getauxH(perfil_consumo_diario::Int64)
    zeros(24)
end

#function MH
#    Array{Union{Missing, Float32}, 2}(missing, M, H)
#end

function get_perfil_personalizado(perfil_consumo_anual::Int64, perfil_consumo_diario::Int64, consumo_anual::Float64)
    auxH = getauxH(perfil_consumo_diario)
    auxM = get_auxM(perfil_consumo_anual, perfil_consumo_diario, consumo_anual)

    auxH = repeat(auxH, 12)
    auxM = repeat(auxM', 1, 24)
    
    map(zip(auxH, auxM)) do (h, m)
        1000.0h*m
    end
end
