#################################
#################################
# Cross ratio
#################################
#################################
"""
$(SIGNATURES)

Returns the cross ratio of four numbers.
"""
function crossratio(A, B, C, D)
    x = (A - B) * (C - D)
    y = (A - D) * (C - B)
    return x*inv(y)
end

#################################
#################################
# Standard vectors
#################################
#################################


## TODO dim = 1 hardcoded!
## Problem: Nemo's matrix interface.
homofy!(v) = pushfirst!(v, one(first(v)))

homofy(ξ) = homofy!([ξ])

uroot(k::Int) = ROOTS_OF_UNITY[](DEGREE[], k)

"""
$(SIGNATURES)

Returns the vector `[ξ_i...]` where `ξ_i` is the `i`-th `d`-th-root of unity for `i` in `I` (default `I = 1:d`).
"""
uroots(I = 1:DEGREE[]) = map(uroot, I)

"""
$(SIGNATURES)

Returns vectors `[1,-ξ_i]` for the `i`-th (`i` in `I = 1:d`) `d`-th-root of unity.
"""
function homo_uroots(I = 1:DEGREE[])
    ys = BASE_FIELD[](-1).*uroots(I)
    homofy.(ys)
end

function affinefy!(v, i = 1)
    λ = v[i]
    # j = i
    if iszero(λ)
        # j = findfirst(!=(λ), v)
        # λ = v[j]
        λ = getfirst(!=(λ), v)
    end
    v .*= inv(λ)
    return v
end

function dehomo!(v, i = 1)
    # If i-th component is zero, returns the Inf vector.
    affinefy!(v, i)
    return deleteat!(v, i)
end

"""
$(SIGNATURES)

Returns
"""
fix_homo_base!(M, u) = _mul_matcols!(M, get_ratios(u, M, zero = zero(_parent(u))))

"""
$(SIGNATURES)

Given a vector `u` being a linear combination of the columns of `M`,
returns the coefficients of such a linear combination.
That is, returns `v=[a_1,..,a_n]` such that `Mv = u`.

``julia
n = 100
v1 = matrix(QQ, rand(-n:n, 4, 1))
v2 = matrix(QQ, rand(-n:n, 4, 1))

u = 2*v1-4*v2
get_ratios([v1,v2], u)
[ 2]
[-4]
```
"""
function get_ratios(u, M; zero = zero(first(M)))
    # indicies = getfirst(((I, m),) -> m != zero, maxminors(M))
    indicies = getfirst(!=(zero)∘last, maxminors(M))
    # println(indicies)
    if isnothing(indicies)
        return error("Matrix must have maximal rank")
    end
    (ri, ci) = first(indicies)
    return inv(M[ri, ci]) * u[ri, 1]
end
