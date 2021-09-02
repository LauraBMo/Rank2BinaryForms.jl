module Rank2BinaryForms

using Combinatorics:combinations
using DocStringExtensions:SIGNATURES

# Use at least Nemo 0.24.0
# Install with
# ] add https://github.com/Nemocas/Nemo.jl.git
using Nemo

export crossratio, affineGamma, Image_affineGamma, set_getting_rootsofunity, buildpolynomial

#################################
#################################
# Roots of unity
#################################
#################################

rootsofunity(d) = k -> Nemo.root_of_unity(QQBar, d, k)

const ROOTS_OF_UNITY = Ref{Function}(rootsofunity)

"""
$(SIGNATURES)

Sets the method used to compute the `d`-th roots of unity. The input is a function `f` computing the roots of unity accepting calls as `f(d)(k)` and returning the `k`-th root of the `d`-th roots of unity. The order of the `d`-th roots of unity can be clockwise or anti-clockwise, but they must be ordered.
Examples of valid inputs are the following functions `f` and `g`:

```julia
    g(d) = k -> exp(2*pi*im*k/d)
    using Nemo
    CC = ComplexField(64);
    f(d) = k -> Nemo.root_of_unity(CC, d)^k;
```
"""
function set_getting_rootsofunity(f)
    ROOTS_OF_UNITY[] = f
end

## Other ways to get the roots of unity
# CC = ComplexField(64)
# g(d) = k -> Nemo.root_of_unity(CC, d)^k
# set_getting_rootsofunity(g)
#
# f(d) = k -> exp(2*pi*im*k/d)
# set_getting_rootsofunity(f)


#################################
#################################
# Cross ratio
#################################
#################################
"""
$(SIGNATURES)

Returns the cross ratio of four numbers.
There is also the method:

    crossratio(v) = crossratio(v...)
"""
crossratio(A, B, C, D) = (A - B) * (C - D) * inv((A - D) * (C - B))
crossratio(v) = crossratio(v...)

#################################
#################################
# Triplets and 4-tuples
#################################
#################################

"""
$(SIGNATURES)

Returns a vector of triplets `[i,j,k]` of integers `1 <= i < j < k <= d`, up to the action of the `d`-th dihedral group.
"""
triplets(d) = map(pair -> pushfirst!(pair, 1), combinations(2:d, 2))

"""
$(SIGNATURES)

Returns a vector of vectors resulting to `pushfirst` each integer `1:d` in `triplet`.
"""
tuples(d) = triplet -> [[i, triplet...] for i in 1:d if !(i in triplet)]
# tuples(d) = triplet -> [[i, triplet...] for i in 1:d if !(i == last(triplet))]
# tuples(d) = triplet -> [[i, triplet...] for i in 1:d]

#################################
#################################
# Define Gamma
#################################
#################################
# Computing the i-th root of the polynomial image of Gamma
# @noinlne not needed
ithroot(d) = tuple -> crossratio(ROOTS_OF_UNITY[](d).(tuple))

# function affineGamma(d, triplet)
#     out = -1 .* ithroot(d).(tuples(d)(triplet))
#     return  [zero(first(out)), one(first(out)), out...]
# end
# affineGamma(d) = triplet -> affineGamma(d, triplet)

"""
$(SIGNATURES)

Returns a function that computes the unknown roots of the polynomial `Γ(triplet)`.
"""
affineGamma(d) = triplet -> -1 .* ithroot(d).(tuples(d)(triplet))

"""
$(SIGNATURES)

Returns the roots of all the polynomials in the image of `Γ`.
"""
Image_affineGamma(d) = affineGamma(d).(triplets(d))


#################################
#################################
# Building the polynomials
#################################
#################################
"""
$(SIGNATURES)

Generic function to build the polynomials in the image of `Γ` from the list of roots.
"""
function buildpolynomial(roots, vars)
    x = first(vars)
    y = last(vars)
    out = x * y * (x + y)
    for r in roots
        out *= x - r * y
    end
    return out
end

function buildpolynomial(roots, vars::Vector{Symbol})
    x = first(vars)
    y = last(vars)
    out = Expr(:call, :*, x, y, Expr(:call, :+, x, y))
    for r in roots
        out = Expr(:call, :*, out, Expr(:call, :-, x, Expr(:call, :*, r, y)))
    end
    return out
end

buildpolynomial(vars) = roots -> buildpolynomial(roots, vars)

end
