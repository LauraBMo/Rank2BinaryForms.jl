
notin(I, iter) = Iterators.filter(i -> !(i in I), iter)

function getfirst(p, itr)
    for el in itr
        p(el) && return el
    end
    return nothing
end

## v is a Vector of vectors of the same length.
## _parent(v) returns the type element of the vectors of the vector.
## We dispatch on such a type, when it is a Number, we want a "Julia-array" matrix.
function vecs_to_mat(v::AbstractArray, ::Type{T} =_parent(v)) where {T <: Number}
    return Matrix(reduce(hcat, vec(v)))
end

## For any other type, we want Nemo matrices.
function vecs_to_mat(v, R =_parent(v))
    # Here elements of v are of type of Elem type for some Nemo file.
    # But v is a "Julia-vector" of vectors... So, convert to Julia-matrix.
    # Int is always subtype of Number.
    return Nemo.matrix(R, vecs_to_mat(v, Int))
end

function unfold_Calcium(x)
    y = Nemo.AcbField(64)(x)
    return Float64.([Nemo.real(y), Nemo.imag(y)])
end

function _float(x)
    r, i = unfold_Calcium(x)
    return r + i * Base.im
end

function _parent(u::AbstractArray{T}) where T
    x = first(u)
    if T <: AbstractArray
        return _parent(x)
    elseif T <: Number
        return typeof(x)
    end
    return Nemo.parent(x)
end
_parent(M::Nemo.MatElem) = Nemo.parent(first(M))
_parent(x::Number) = typeof(x)
_parent(x) = parent(x)

function _mul_matcols!(M, coeffs)
    nr = 1:size(M, 1)
    # !(length(coeffs) == size(M, 2)) && throw(DimensionMismatch)
    @inbounds for (j, c) in enumerate(coeffs)
        _mul_col!(M, c, j, nr)
    end
    return M
end

function _mul_col!(M, λ, j, rows=1:size(M, 1))
    @inbounds for i in rows
        M[i,j] = λ*M[i,j]
    end
    return M
end


"""
$(SIGNATURES)

Returns the indices (as an iterator) for all the `k`x`k` minors of `M`.
"""
function minors_indices(M, k)
    iters = map(dim -> CC.combinations(1:dim, k), size(M))
    return Iterators.ProductIterator(iters)
end

get_minor(M) = indices -> (indices, det(M[indices...]))
# get_minor(M) = indices -> det(M[indices...])
minors(M, k) = Iterators.map(get_minor(M), minors_indices(M, k))

maxminors(M) = minors(M, minimum(size(M)))

#################################
#################################
# Building the polynomials
#################################
#################################

buildpolynomial(roots, vars) = _buildpolynomial(roots, vars, eltype(vars))

buildpolynomial(vars = (:x, :y)) = roots -> buildpolynomial(roots, vars)

"""
$(SIGNATURES)

Generic function to build the polynomials in the image of `Γ` from the list of roots.
"""
function _buildpolynomial(roots, vars, ::Type{T}) where T
    x, y = vars
    out = x * y * (x + y)
    for r in roots
        out *= x - r * y
    end
    return out
end

function _buildpolynomial(roots, vars, ::Type{Symbol})
    x, y = vars
    out = Expr(:call, :*, x, y, Expr(:call, :+, x, y))
    for r in roots
        out = Expr(:call, :*, out, Expr(:call, :-, x, Expr(:call, :*, r, y)))
    end
    return out
end
