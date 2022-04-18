@enum TIPO_CONSUMO TIPO_CONSUMO_IGUAL=1 TIPO_CONSUMO_NOCHE

function extend_from_H_to_M(x::AbstractArray{Float64, 1})
    repeat(x, 12)
end

function extend_from_M_to_H(x::AbstractArray{Float64, 1})
    repeat(x', 1, 24)
end

function get_auxM(perfil_consumo_anual::Int64, perfil_consumo_diario::Int64, consumo_anual::Float64)
    zeros(12)
end

function get_equitativo_H()
    zeros(24)
end

function get_factor_noche()
    zeros(24)
end

function get_factor_tarde()
    zeros(24)
end

function get_aux_H(perfil_consumo_diario::Int64)
    equitativo = get_equitativo_H()
    factor_noche = get_factor_noche()
    factor_tarde = get_factor_tarde()

    map(zip(equitativo, factor_noche, factor_tarde)) do (e, n, t)
        if perfil_consumo_diario == TIPO_CONSUMO_IGUAL
            e
        elseif perfil_consumo_diario == TIPO_CONSUMO_NOCHE
            n*e
        else 
            t*e
        end
    end
end

#function MH
#    Array{Union{Missing, Float32}, 2}(missing, M, H)
#end

function get_perfil_personalizado(perfil_consumo_anual::Int64, perfil_consumo_diario::Int64, consumo_anual::Float64)
    auxH = get_aux_H(perfil_consumo_diario)
    auxM = get_auxM(perfil_consumo_anual, perfil_consumo_diario, consumo_anual)

    auxH = extend_from_H_to_M(auxH)
    auxM = extend_from_M_to_H(auxM)
    
    map(zip(auxH, auxM)) do (h, m)
        1000.0h*m
    end
end
