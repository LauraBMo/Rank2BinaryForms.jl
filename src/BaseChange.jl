

# Given i.l. vectors v_1,...,v_k and v_{k+1}=a_1v_1+...+a_kv_k
# First, find coefficients a_1,...,a_k.
# Second, return matrix whose columns a_1v_1,...,a_kv_k, v_{k+1}
#

bc_compose(M, N) = N*inv(M)

"""
$(SIGNATURES)

Returns PGL matrix sending `e_i=[0,..,1,..,0]` to `v[i]` and `[1,...,1]` to `u`.

```julia
n = 100
v1 = matrix(QQ, rand(-n:n, 4, 1))
v2 = matrix(QQ, rand(-n:n, 4, 1))

u = 2*v1-4*v2
normalize_mat(u, v1, v2) == reduce(hcat, (2.*v1, -4.*v2))
true
```
"""
function bc_canonical_to_any(L, R = _parent(L))
    u, B = _splitquaduple(L)
    M = vecs_to_mat(B, R)
    return fix_homo_base!(M, R.(u))
end
_splitquaduple(L) = (last(L), L[begin:(end -1)])

function bc_uroots_to_uroots(I, J)
    M = bc_canonical_to_any(homo_uroots(I))
    N = bc_canonical_to_any(homo_uroots(J))
    return bc_compose(M, N) # N*inv(M)
end

function bc_uroots_to_any(I, L)
    M = bc_canonical_to_any(homo_uroots(I))
    N = bc_canonical_to_any(L, _parent(M))
    return bc_compose(M, N) # N*inv(M)
end

function bc_any_to_uroots(L, I)
    M = bc_canonical_to_any(homo_uroots(I))
    N = bc_canonical_to_any(L, _parent(M))
    return bc_compose(N, M) # M*inv(N)
end

function bc_fundamental()
    pair_tt = Iterators.product(1:length_stdtt(), 1:length_stdtt())
    M = Matrix{Nemo.MatElem{typeof(Nemo.one(BASE_FIELD[]))}}(undef, size(pair_tt)...)
    for (i,j) in pair_tt
        M[i,j] = bc_uroots_to_uroots(standard_triplets()[i], standard_triplets()[j])
    end
    return M
end
