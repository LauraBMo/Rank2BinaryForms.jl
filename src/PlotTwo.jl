
@userplot PlotTwo

"""
    $(SIGNATURES)

Add documentation.
"""
function plottwo end

@recipe function f(pg::PlotTwo;
                   bp_color = :blue,
                   delta = 0.3,
                   dt = 0.001,
                   # i = 1,
                   linewidth = 2,
                   linecolor = :dodgerblue,
                   ms = 7,
                   )
    L, i, = pg.args
    I = standard_triplets()[i]

    # xl1, yl1 = set_bounds(ucircle, delta = delta)
    # xl2, yl2 = set_bounds(newcircle, delta = delta)
    # xl = merge_bounds(xl1, xl2)
    # yl = merge_bounds(yl1, yl2)
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

    poly = gamma(L)(I)
    layout := (1,2)
    @series begin
        subplot := 1
        title := "$(DEGREE[])th uroots"
        annotations := _set_annotation.(I, ((0.9, 0.2),))
        PlotURoots(i)
    end
    @series begin
        subplot := 2
        title := "Triplet"
        annotations := _set_annotation.(zip(I, poly[I]), ((1.3, 1.0),))
        PlotGamma((L,i))
    end
end
