
@userplot PlotURoots

"""
    $(SIGNATURES)

Add documentation.
"""
function ploturoots end

@recipe function f(pg::PlotURoots;
                   bp_color = :blue,
                   delta = 0.3,
                   dt = 0.001,
                   # i = 1,
                   linewidth = 2,
                   linecolor = :dodgerblue,
                   ms = 7,
                   )
    _args = pg.args
    if length(_args) == 1
        i, = _args
    else
        _, i, = _args
    end
    I = standard_triplets()[i]

    # xl, yl = set_bounds(zs, delta = delta)
    # xlims --> xl
    # xlims = plotattributes[:xlims]
    # ylims --> yl
    # ylims = plotattributes[:ylims]

    # legend --> :outerright
    legend --> :outerbottom
    legendfontsize --> 10

    plot_title --> "Degree $(DEGREE[])"

    grid --> true
    aspect_ratio --> :equal

    urootL = TT_rad([(i-1)//DEGREE[] for i in I])
    @series begin
        label := "Unite circle"
        subplot := 1
        linewidth --> 2
        linecolor --> :dodgerblue
        delta := delta
        dt := dt
        PlotCircle(urootL)
    end

    @series begin
        bp_color := bp_color
        bp_label := "Std triplet $I"
        other_label := "Other uroots"
        PlotPoints((urootL, i))
    end
end
