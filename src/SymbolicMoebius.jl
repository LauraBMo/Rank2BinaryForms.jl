

# using Oscar

_vec(A, I = eachindex(A)) = [A[i] for i in vec(I)]
function moebius(K,
                 source::Vector,
                 target::Vector
                 )

    # Validate inputs
    # @assert length(pts1) == 3 && length(pts2) == 3 "Need exactly 3 points"
    # K = base_ring(pts1[1])
    # dim(ambient_space(pts1[1])) == 1 || error("Requires P¹ points")

    M = zero_matrix(K, 3, 4)
    # Build system matrix
    for i in 1:3
        x, y = source[i][1], source[i][2]
        u, v = target[i][1], target[i][2]
        M[i, 1] = x * v
        M[i, 2] = y * v
        M[i, 3] = -x * u
        M[i, 4] = -y * u
    end
    # Solve kernel
    k = kernel(M, side=:right)
    # dim(k) == 1 || error("Unique solution not found")
    # sol = k
    # a, b, c, d = sol[1, 1], sol[2, 1], sol[3, 1], sol[4, 1]
    # iszero(a*d - b*c) && error("Singular transformation")

    return matrix(K, 2, 2, _vec(k))
end

# Convenience method for affine inputs (where 'nothing' means infinity).
function moebius_affine(K,
                        source::Vector,
                        target::Vector
                        )

    to_projective(p) = isnothing(p) ? [0, 1] : [1, p]
    proj1 = to_projective.(source)
    proj2 = to_projective.(target)

    return moebius(K, proj1, proj2)
end

# Convenience method for affine inputs with no infinity.
function moebius_affine1(K,
                        source::Vector,
                        target::Vector
                        )

    M = -ones_matrix(K, 3, 4)
    # Build system matrix
    # Assume points are [1:y_i], [1:v_i] (affine chart x̸=0)
    for i in 1:3
        y, v = source[i], target[i]
        M[i, 1] =  v
        M[i, 2] = y * v
        M[i, 4] = -y
    end
    k = kernel(M, side=:right)

    return matrix(K, 2, 2, _vec(k))
    # to_projective(p) = p === nothing ? [0, 1] : [1, p]
    # proj1 = to_projective.(pts1)
    # proj2 = to_projective.(pts2)

    # return moebius(K, proj1, proj2)
end

# # Helper to determine base field
# function _infer_base_field(pts1, pts2)
#     for pt in vcat(pts1, pts2)
#         pt isa FieldElem && return parent(pt)
#     end
#     return QQ  # Default if only infinities
# end
