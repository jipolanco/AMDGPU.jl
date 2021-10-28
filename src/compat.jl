# Hacks that can be ripped out once we support device overrides

function LinearAlgebra.norm(v::ROCArray{T}, p::Real=2) where {T}
    if p == Inf
        maximum(abs.(v))
    elseif p == -Inf
        minimum(abs.(v))
    else
        mapreduce(x->AMDGPU.pow(AMDGPU.abs(x), p), +, v; init=zero(T))^(1/p)
    end
end