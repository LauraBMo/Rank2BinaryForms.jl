

@userplot PlotBoth

"""
    $(SIGNATURES)

Add documentation.
"""
function plotboth end

@recipe function f(pg::PlotBoth;
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

    legend --> :outerright
    # legend --> :outerbottom
    legendfontsize --> 10

    title --> "Degree $(DEGREE[])"

    grid --> true
    aspect_ratio --> :equal

    poly = gamma(L)(I)
    annotations := [_set_annotation.(I, ((1.0, 0.9),))..., _set_annotation.(zip(I, poly[I]), ((1.3, 1.0),))...]
    @series begin
        PlotURoots(i)
    end
    @series begin
        PlotGamma((L,i))
    end
end
