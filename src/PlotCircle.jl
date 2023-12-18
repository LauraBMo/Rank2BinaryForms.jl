
@userplot PlotCircle

"""
    $(SIGNATURES)

Add documentation.
"""
function plotcircle end

@recipe function f(pg::PlotCircle;
                   delta = 0.1,
                   dt = 0.002,
                   )
    L = pg.args
    ## Any Std. tt. will give the same circle!
    I = standard_triplets()[1]

    C = conic_param(I, L)
    zs = C.(dt:dt:(2*pi))

    # xl, yl = set_bounds(zs, delta = delta)
    # # xlims := xl
    # # ylims := yl
    # # ylims = plotattributes[:ylims]
    # # xlims = plotattributes[:xlims]
    # plotattributes[:xlims] = xl
    # plotattributes[:ylims] = yl
    # println(xl)
    # println(yl)

    # legend --> :outerright
    legend --> :outerbottom
    legendfontsize --> 10

    title --> "Degree $(DEGREE[])"

    grid --> true
    aspect_ratio --> :equal

    seriestype := :path
    label --> "Circle"
    linewidth --> 2
    linecolor --> :dodgerblue
    real.(zs), imag.(zs)
end
