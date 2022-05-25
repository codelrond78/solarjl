module Currency

using Unitful

d = @dimension my "my" Money
u = @refunit € "€" Euro d false

end

using Unitful

Unitful.register(Currency)