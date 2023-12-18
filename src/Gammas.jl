

#################################
#################################
# Define (general) Gamma for any triplet of linear forms
#################################
#################################

function gamma(L)
    M = I -> bc_uroots_to_any(I, L)
    all_homo_uroots = homo_uroots()
    return I -> begin
        out = [M(I)] .* all_homo_uroots
        affinefy!.(out)
        return out
    end
end

gamma_image(L) = gamma(L).(standard_triplets())

#################################
#################################
# Define Gamma for L = [[0,1], [1,0], [1,1]]
# Here, we use the cross ratio identification.
#################################
#################################
# Computing the i-th root of the polynomial image of Gamma
# @noinline not needed
function get_gamma_roots(I)
    base_uroots = uroots(I)
    return k -> crossratio(base_uroots..., ROOTS_OF_UNITY[](DEGREE[], k))
end

"""
$(SIGNATURES)

Returns a function on triplets of integers `I` which computes the roots of the polynomial `Γ(I)`.
"""
gamma() = I -> get_gamma_roots(I).(1:DEGREE[])

"""
$(SIGNATURES)

Returns the roots of all the polynomials in the image of `Γ`.
"""
gamma_image() = gamma().(standard_triplets())

get_noncommonroots((poly, I)) = [poly[i] for i in notin(I, eachindex(poly))]
get_notin((I, A)) = [A[i] for i in notin(I, eachindex(A))]

all_noncommonroots(L) =
    get_notin.(zip(standard_triplets(), gamma_image(L)))
all_noncommonroots() =
    get_notin.(zip(standard_triplets(), gamma_image()))
