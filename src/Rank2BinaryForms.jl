module Rank2BinaryForms

using DocStringExtensions:SIGNATURES

# Use at least Nemo 0.24.0
# Install with
# ] add https://github.com/Nemocas/Nemo.jl.git
import Nemo
using Nemo:det


import Combinatorics as CC
# using Combinatorics:combinations

include("Utils.jl")

include("Geometry.jl")
include("Tuples.jl")
include("BaseChange.jl")
include("Gammas.jl")

using Requires

function __init__()
    @require Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80" begin
        # import .HomotopyContinuation as HC
        import .Plots as PP
        @eval using Colors
        # using Contour
        @eval using RecipesBase
        include("PlotUtils.jl")
        include("PlotCircle.jl")
        include("PlotPoints.jl")
        include("PlotGamma.jl")
        include("PlotURoots.jl")
        include("PlotBoth.jl")
        include("PlotTwo.jl")
    end
end

# include("PlotConic.jl")

# include("PlotRecpies.jl")


# import MultivariatePolynomials as MP
# include("Conic.jl")

#################################
#################################
# Roots of unity
#################################
#################################

# Use Float64
# rootsofunity(d, k) = exp((2*pi*im*k)/d)

# Numbers should accept division by zero (that is, infinity. e.g., Float63, CalciumField).
# Otherwise, do _not_ use functions in Gammas.jl
const BASE_FIELD = Ref{Nemo.Field}()

# const BASE_FIELD = Ref{Nemo.Field}(Nemo.CalciumField(extended = true))
# const BASE_FIELD = Nemo.CalciumField(extended = true)

function set_base_field(field)
    BASE_FIELD[] = field
    @eval const FUNDAMENTAL = Ref{Matrix{Nemo.MatElem{typeof(Nemo.one(BASE_FIELD[]))}}}()
    FUNDAMENTAL[] = bc_fundamental()
    return field
end

const DEGREE = Ref{Int}(5)

function set_degree(degree)
    DEGREE[] = degree
end

# To be used w/ CalciumField.
function rootsofunity(d, k)
    num = BASE_FIELD[](2*(k-1))*Nemo.const_pi(BASE_FIELD[])*Nemo.onei(BASE_FIELD[])
    den = BASE_FIELD[](d)
    expo = num // den
    return exp(expo)
end

# const CField = Nemo.QQBar
# rootsofunity(d, k) = Nemo.root_of_unity(CField, d, i)

# const CField = Nemo.ComplexField(64)
# rootsofunity(d, k) = Nemo.root_of_unity(CC, d)^k

const ROOTS_OF_UNITY = Ref{Function}(rootsofunity)

"""
$(SIGNATURES)

Sets the method used to compute the `d`-th roots of unity. The input is a function `f` computing the roots of unity accepting calls as `f(d)(k)` and returning the `k`-th root of the `d`-th roots of unity. The order of the `d`-th roots of unity can be clockwise or anti-clockwise, but they must be ordered.
Examples of valid inputs are the following functions `f` and `g`:

```julia
    g(d, k) = exp(2*pi*im*k/d)
    set_getting_rootsofunity(g)
```

```julia
    using Nemo
    CC = ComplexField(64);
    f(d, k) = Nemo.root_of_unity(CC, d)^k;
    set_getting_rootsofunity(f)
```
"""
function set_getting_rootsofunity(f)
    ROOTS_OF_UNITY[] = f
end

end
