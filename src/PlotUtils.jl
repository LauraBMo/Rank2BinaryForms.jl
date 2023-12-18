

## Aux functions
function conic_param(I, L)
    # A = _float.(bc_any_to_uroots(L, I))
    A = _float.(bc_uroots_to_any(I, L))
    return (t::Real) -> begin
        P = A*[1.0, exp(t*im)]
        P[2]/P[1]
    end
end

# uroots_arg() = [2*pi*k/DEGREE[] for k in 0:(DEGREE[]-1)]
# gamma_image(C) = C.(uroots_arg())

function set_forplot(poly)
    zs = unfold_Calcium.(last.(poly))
    return first.(zs), last.(zs)
end

function _set_annotation((i, z), off)
    theta, r = off
    z_off = r*exp(theta*Base.im)
    # z is dehomo.
    _z = _float(last(z)//first(z))
    _z += z_off
    x, y = real(_z), imag(_z)
    (x, y, PP.text("$i", :black, :right, 10))
end

function _set_annotation(i::Int, off)
    z = exp(2*Base.pi*Base.im*(i-1)/DEGREE[])
    theta, r = off
    z_off = r*exp(theta*Base.im)
    z += z_off
    x, y = real(z), imag(z)
    (x, y, PP.text("$i", :black, :right, 10))
end

function _colors(color)
    return Colors.distinguishable_colors(length_stdtt() +1,
                                         Colors.parse.(Colorant, color))
end

# _norm(z) = real(z)^2 + imag(z)^2

# ## Find bound when 'zs' parameterize a circle.
# function set_bounds(zs; delta = 0.1)
#     ## Looking for the antipodal point to zs[1].
#     d = _norm.(zs[1] .- zs)
#     i0 = findfirst(((d0, d1),) -> (d0 > d1), collect(zip(d, d[begin+1:end])))
#     if isnothing(i0)
#         @error "No antipodal found"
#     end
#     p0, q0 = zs[1], zs[i0]
#     c = (p0 + q0)/2
#     r = sqrt(_norm(q0-p0))/2
#     r += r*delta
#     xlims = real(c) .+ (-r, r)
#     # println("xs: left ", xlims[1], " rigth ", xlims[2])
#     ylims = imag(c) .+ (-r, r)
#     # println("ys: left ", ylims[1], " rigth ", ylims[2])
#     return xlims, ylims
# end

# function merge_bounds(lims1, lims2)
#     L = [lims1, lims2]
#     lb1, lb2 = first.(L)
#     ub1, ub2 = last.(L)
#     return min(lb1, lb2), max(ub1, ub2)
# end

# function set_bounds(xs, ys; lambda = 0.1)
#     mi = min(minimum(xs), minimum(ys))
#     mx = max(maximum(xs), maximum(ys))
#     l = max(1, (mx - mi))*lambda
#     mi -= l
#     mx += l
#     return [mi, mx]
# end

# set_bounds(poly; lambda = 0.1) = set_bounds(set_forplot(poly)...; lambda = lambda)

# function set_bounds_all(images; lambda = 0.1)
#     bnds = set_bounds.(images; lambda = lambda)
#     mi = minimum(first.(bnds))
#     mx = minimum(last.(bnds))
#     return [mi, mx]
# end
