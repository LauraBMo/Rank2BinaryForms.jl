@userplot PlotGamma

"""
    $(SIGNATURES)

Add documentation.
"""
function plotgamma end

@recipe function f(pg::PlotGamma;
                   bp_color = :blue,
                   delta = 0.2,
                   dt = 0.001,
                   ms = 7,
                   )
    L, i, = pg.args
    I = standard_triplets()[i]

    # legend --> :outerright
    legend --> :outerbottom
    legendfontsize --> 10

    title --> "Degree $(DEGREE[])"

    grid --> true
    aspect_ratio --> :equal
    @series begin
        label := "Image circle"
        linewidth --> 2
        linecolor --> :dodgerblue
        delta := delta
        dt := dt
        # PlotCircle((L,i); delta = delta, dt = dt, kwargs...)
        PlotCircle(L)
    end
    I = standard_triplets()[i]
    @series begin
        bp_label := "Base points"
        other_label := "Images for $I"
        PlotPoints((L, i))
    end
end

# # So, real fps will be: n/fps
# TODO: require Plots
# function gifgamma(L, n = 3, m = 2;
#                   filename = nothing,
#                   dt = 0.001,
#                   delta = 0.2,
#                   kwargs...
#                   )
#     a = Animation()
#     for i in 1:RR.length_stdtt()
#         for _ in 1:n
#             plt = plotgamma(L, i; dt = 1e-3, delta = 0.5)
#             frame(a, plt)
#         end
#     end
#     if isnothing(filename)
#         return gif(a; fps = m, kwargs...)
#     end
#     return gif(a, filename; fps = m, kwargs...)
# end
