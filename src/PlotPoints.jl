@userplot PlotPoints

"""
    $(SIGNATURES)

Add documentation.
"""
function plotpoints end

@recipe function f(pg::PlotPoints;
                   bp_color = :blue,
                   bp_label = "Base Points",
                   other_label = "Images",
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

    poly = gamma(L)(I)
    # poly = gamma_image(C)
    # x, y = real.(L), imag.(L)
    # Set default values
    colors_list = _colors(string(bp_color))
    # Plot base points
    bx, by = set_forplot(poly[I])
    @series begin
        seriestype := :scatter
        label := bp_label
        markershape := :star
        ms := ms # Mark size
        mc := popfirst!(colors_list) # Mark color
        # ma := f_ma(d, dmin, dmax) # Mark alpha/opacity
        # msw := f_msw(d, dmin, dmax) # Border/stroke width
        # # msw := 0 # No border/stroke
        # msc := color # Border color
        # msa := f_ma(d, dmin, dmax) / r # Border alpha
        bx, by
    end

    # new_points = get_notin((I, poly))
    # x, y = real.(new_points), imag.(new_points)
    x, y = set_forplot(get_notin((I, poly)))
    @series begin
        seriestype := :scatter
        label := other_label
        # markershape := :circle
        ms := ms - 2
        mc := colors_list[i] # Mark color
        # ma := f_ma(d, dmin, dmax) # Mark alpha/opacity
        # msw := f_msw(d, dmin, dmax) # Border/stroke width
        # # msw := 0 # No border/stroke
        # msc := color # Border color
        # msa := f_ma(d, dmin, dmax) / r # Border alpha
        x, y
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
