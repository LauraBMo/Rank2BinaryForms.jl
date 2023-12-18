
# Table of Contents

1.  [Rank2BinaryForms https://img.shields.io/badge/docs-stable-blue.svg https://img.shields.io/badge/docs-dev-blue.svg https://github.com/LauraBMo/Rank2BinaryForms/workflows/CI/badge.svg https://codecov.io/gh/LauraBMo/Rank2BinaryForms/branch/master/graph/badge.svg](#org652f802)
2.  [Dependencies](#org921fef2)
3.  [Install](#orged4c8a0)
4.  [Examples of use](#org9330b50)
    1.  [Basic use](#orgec15059)
    2.  [Using other fields](#org6b89a17)
    3.  [Building the polynomials](#org711907b)


<a id="org652f802"></a>

# Rank2BinaryForms [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://LauraBMo.github.io/Rank2BinaryForms.jl/stable) [![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://LauraBMo.github.io/Rank2BinaryForms.jl/dev) [![Build Status](https://github.com/LauraBMo/Rank2BinaryForms.jl/workflows/CI/badge.svg)](https://github.com/LauraBMo/Rank2BinaryForms.jl/actions) [![Coverage](https://codecov.io/gh/LauraBMo/Rank2BinaryForms.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/LauraBMo/Rank2BinaryForms.jl)

Package to compute the roots of the polynomials in the image of the map &Gamma; defined in [ArXiv 1901.08320](https://arxiv.org/abs/1901.08320).
Computes the list (up to a linear change of coordinates) of binary forms (homogeneous polynomials of two variables) with Waring rank two.


<a id="org921fef2"></a>

# Dependencies

-   Nemo >= 0.24.0 (for Algebraic Numbers `QQBar`)
    
    Install latest Nemo version with

    import Pkg
    Pkg.add(url="https://github.com/Nemocas/Nemo.jl.git")


<a id="orged4c8a0"></a>

# Install

    import Pkg
    Pkg.add("Rank2BinaryForms")


<a id="org9330b50"></a>

# Examples of use


<a id="orgec15059"></a>

## Basic use

    using Rank2BinaryForms

Calculate the roots (by default in Nemo&rsquo;s field `QQBar`) of the ten polynomials of degree six in the image of &Gamma;.

    roots_list = Image_affineGamma(6)
    10-element Vector{Vector{Nemo.qqbar}}:
        [Root 2.00000 of x - 2, Root 1.00000 of x - 1, Root 0.500000 of 2x - 1]
    [Root -3.00000 of x + 3, Root 3.00000 of x - 3, Root 1.00000 of x - 1]
    [Root -2.00000 of x + 2, Root -4.00000 of x + 4, Root 2.00000 of x - 2]
    [Root -1.50000 of 2x + 3, Root -2.00000 of x + 2, Root -3.00000 of x + 3]
    [Root -0.333333 of 3x + 1, Root 1.00000 of x - 1, Root 0.333333 of 3x - 1]
    [Root -0.500000 of 2x + 1, Root -2.00000 of x + 2, Root 1.00000 of x - 1]
    [Root -0.666667 of 3x + 2, Root -1.33333 of 3x + 4, Root -2.00000 of x + 2]
    [Root -0.250000 of 4x + 1, Root -0.500000 of 2x + 1, Root 0.500000 of 2x - 1]
    [Root -0.500000 of 2x + 1, Root -0.750000 of 4x + 3, Root -1.50000 of 2x + 3]
    [Root -0.333333 of 3x + 1, Root -0.500000 of 2x + 1, Root -0.666667 of 3x + 2]


<a id="org6b89a17"></a>

## Using other fields

Other fields can be used with `set_getting_rootsofunity(f)`, a function setting how to compute the `d`-th roots of unity. The function `f` computing the roots of unity must accept calls as `f(d)(k)`, returning the `k`-th root of the `d`-th roots of unity. The order of the `d`-th roots of unity can be clockwise or anti-clockwise, but they must be ordered. This package should be generic enough to accept a wide variety of numbers types as output for `f`, which will be the type of the roots.

See Fields section in [Nemo&rsquo;s docs](https://nemocas.github.io/Nemo.jl/stable/) for examples of fields and how to calculate the roots of unity in them.

For example, to use julia&rsquo;s float arithmetic:

    g(d) = k -> exp(2*pi*im*k/d);
    set_getting_rootsofunity(g);
    Image_affineGamma(6)
    10-element Vector{Vector{ComplexF64}}:
        [2.000000000000001 - 0.0im, 1.0 - 5.551115123125783e-17im, 0.5000000000000002 - 4.6929368142093083e-17im]
        [-3.000000000000001 - 0.0im, 2.999999999999999 - 4.876437970550445e-16im, 1.0000000000000002 - 1.1102230246251565e-16im]
        [-1.9999999999999998 + 1.1102230246251565e-16im, -3.999999999999999 - 0.0im, 2.000000000000001 - 2.220446049250313e-16im]
        [-1.5 + 2.010226348134756e-18im, -2.0000000000000004 - 1.1102230246251565e-16im, -3.0000000000000004 + 2.220446049250313e-16im]
        [-0.33333333333333326 - 0.0im, 0.9999999999999993 - 1.6653345369377348e-16im, 0.3333333333333333 - 2.7755575615628914e-17im]
        [-0.5 - 2.7755575615628914e-17im, -1.9999999999999996 + 1.1102230246251565e-16im, 1.0000000000000004 - 1.9229626863835643e-16im]
        [-0.6666666666666666 - 8.93433932504325e-19im, -1.3333333333333335 - 3.3306690738754696e-16im, -2.0000000000000004 + 2.39196527318635e-16im]
        [-0.25000000000000006 - 0.0im, -0.5000000000000001 - 0.0im, 0.5000000000000003 + 2.7755575615628914e-17im]
        [-0.5 + 2.7755575615628914e-17im, -0.75 + 5.551115123125783e-17im, -1.5000000000000004 - 0.0im]
        [-0.3333333333333332 - 2.7755575615628914e-17im, -0.4999999999999999 - 5.979913182965873e-17im, -0.6666666666666664 - 0.0im]

Or, to use arbitrary complex balls with precision 64 bits `Acb`:

    using Nemo
    CC = ComplexField(64);
    f(d) = k -> Nemo.root_of_unity(CC, d)^k;
    set_getting_rootsofunity(f);
    Image_affineGamma(6)
    10-element Vector{Vector{acb}}:
        [[2.00000000000000000 +/- 6.78e-18] + [+/- 6.50e-18]*im, [1.0000000000000000 +/- 2.32e-18] + [+/- 2.13e-18]*im, [0.50000000000000000 +/- 1.31e-18] + [+/- 1.28e-18]*im]
    [[-3.00000000000000000 +/- 7.71e-18] + [+/- 7.25e-18]*im, [3.00000000000000000 +/- 5.29e-18] + [+/- 3.65e-18]*im, [1.00000000000000000 +/- 3.21e-18] + [+/- 3.19e-18]*im]
    [[-2.00000000000000000 +/- 5.77e-18] + [+/- 5.51e-18]*im, [-4.0000000000000000 +/- 9.81e-18] + [+/- 9.38e-18]*im, [2.0000000000000000 +/- 9.95e-18] + [+/- 1.01e-17]*im]
    [[-1.50000000000000000 +/- 3.27e-18] + [+/- 2.92e-18]*im, [-2.00000000000000000 +/- 7.11e-18] + [+/- 7.06e-18]*im, [-3.0000000000000000 +/- 1.08e-17] + [+/- 1.01e-17]*im]
    [[-0.33333333333333333 +/- 4.05e-18] + [+/- 7.01e-19]*im, [1.0000000000000000 +/- 3.85e-18] + [+/- 3.55e-18]*im, [0.33333333333333333 +/- 5.02e-18] + [+/- 1.69e-18]*im]
    [[-0.50000000000000000 +/- 1.17e-18] + [+/- 1.04e-18]*im, [-2.0000000000000000 +/- 9.30e-18] + [+/- 9.05e-18]*im, [1.00000000000000000 +/- 4.43e-18] + [+/- 4.35e-18]*im]
    [[-0.66666666666666667 +/- 4.58e-18] + [+/- 7.48e-19]*im, [-1.33333333333333333 +/- 7.90e-18] + [+/- 4.42e-18]*im, [-2.00000000000000000 +/- 5.27e-18] + [+/- 4.05e-18]*im]
    [[-0.250000000000000000 +/- 4.48e-19] + [+/- 3.32e-19]*im, [-0.50000000000000000 +/- 1.76e-18] + [+/- 1.69e-18]*im, [0.50000000000000000 +/- 2.82e-18] + [+/- 2.79e-18]*im]
    [[-0.50000000000000000 +/- 1.50e-18] + [+/- 1.37e-18]*im, [-0.75000000000000000 +/- 2.87e-18] + [+/- 2.80e-18]*im, [-1.50000000000000000 +/- 6.98e-18] + [+/- 6.54e-18]*im]
    [[-0.33333333333333333 +/- 4.41e-18] + [+/- 1.10e-18]*im, [-0.50000000000000000 +/- 1.54e-18] + [+/- 1.50e-18]*im, [-0.66666666666666667 +/- 6.68e-18] + [+/- 3.28e-18]*im]


<a id="org711907b"></a>

## Building the polynomials

The list of polynomials can be easily obtain from the list of roots using your favorite implementation of polynomials in julia.

For example, using julia&rsquo;s [Symbols](https://docs.julialang.org/en/v1/manual/metaprogramming/#Symbols) (polynomials obtained with this method should be compatible with [Reduce.jl](https://github.com/chakravala/Reduce.jl))

    vars = [:x, :y];
    polys = buildpolynomial(vars).(roots_list);
    polys[1]
    :((((x * y * (x + y)) * (x - Root 2.00000 of x - 2 * y)) * (x - Root 1.00000 of x - 1 * y))

Now,

    x = 1; y = 2; eval(p1)
    Root 0 of x

    y=5; eval(p1)
    Root -1620.00 of x + 1620

Or using [Symbolics.jl](https://github.com/JuliaSymbolics/Symbolics.jl) (which should be almost identical to [HomotopyContinuation.jl](https://github.com/JuliaHomotopyContinuation/HomotopyContinuation.jl)).
Notice that the operations `+`, `-` and `*` must be defined between the type of the roots and that of the variables.

    using Symbolics
    @variables x,y;
    vars = [x,y];
    set_getting_rootsofunity(g);
    polys = buildpolynomial(vars).(Image_affineGamma(6));
    polys[1]
    im*(5.551115123125783e-17x*(x + y)*(x - (0.5000000000000002y))*(x - (2.000000000000001y))*(y^2) + 4.6929368142093083e-17x*(x + y)*(x - y)*(x - (2.000000000000001y))*(y^2)) + x*y*(x + y)*(x - (0.5000000000000002y))*(x - y)*(x - (2.000000000000001y)) - (2.6051032521231023e-33x*(x + y)*(x - (2.000000000000001y))*(y^3))

    using Nemo
    R, vars =  PolynomialRing(QQBar, ["x", "y"]);
    polys = buildpolynomial(vars).(roots_list);
    polys[1]
    x^5*y + (Root -2.50000 of 2x + 5)*x^4*y^2 + (Root 2.50000 of 2x - 5)*x^2*y^4 + (Root -1.00000 of x + 1)*x*y^5

    using Nemo
    CC = ComplexField(64);
    R, vars =  PolynomialRing(CC, ["x", "y"]);
    set_getting_rootsofunity(f);
    polys = buildpolynomial(vars).(Image_affineGamma(6));
    polys[1]
    x^5*y + ([-2.5000000000000000 +/- 9.37e-18] + [+/- 8.66e-18]*im)*x^4*y^2 + ([+/-
     2.01e-17] + [+/- 1.88e-17]*im)*x^3*y^3 + ([2.5000000000000000 +/- 1.87e-17] + [
    +/- 1.76e-17]*im)*x^2*y^4 + ([-1.0000000000000000 +/- 7.69e-18] + [+/- 6.86e-18]
    *im)*x*y^5

