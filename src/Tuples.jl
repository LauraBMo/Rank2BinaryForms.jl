#################################
#################################
# Triplets and 4-tuples
#################################
#################################
"""
$(SIGNATURES)

Returns a vector with all the standard triplets of integers `[1,j,k]` with `1 < j < k <= d`.
"""
standard_triplets() = pushfirst!.(CC.combinations(2:DEGREE[], 2), 1)

length_stdtt() = binomial(DEGREE[]-1, 2)
# length(standard_triplets())

"""
$(SIGNATURES)

Returns a function on the standard triplets of integers `I`, which returns tuples `[[i, I...]` for `i` in `1:d` but not in `I`.
"""
function four_tuples()
    return I -> Iterators.map(i -> pushfirst!(I, i), notin(I, 1:DEGREE[]))
end

# rotation(a) = [cos(a) sin(a);  -sin(a) cos(a)]
_notsurprised(a) = BASE_FIELD[](numerator(a))//BASE_FIELD[](denominator(a))
rotated(a) = exp(_notsurprised(2*a)*Nemo.onei(BASE_FIELD[])*Nemo.const_pi(BASE_FIELD[]))

TT_on_S1(A) = map(rotated, A)

intones(v) = ones(Int, length(v))
TT_rad(angles, lengths = intones(angles)) =
    homofy.(_notsurprised.(lengths) .* TT_on_S1(angles))
