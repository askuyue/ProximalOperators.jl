# ProximalOperators.jl - library of nonsmooth functions and associated proximal mappings

__precompile__()

module ProximalOperators

typealias RealOrComplex Union{Real, Complex}
typealias HermOrSym{T, S} Union{Hermitian{T, S}, Symmetric{T, S}}

export prox, prox!

export ProximableFunction

export IndAffine, IndHalfspace,
       IndBallLinf, IndBallL0, IndBallL1, IndBallL2, IndBallRank,
       IndBox, IndNonnegative, IndNonpositive,
       IndExpPrimal, IndExpDual, IndPSD, IndSOC, IndRotatedSOC,
       IndFree,
       IndPoint, IndZero,
       IndSimplex,
       IndSphereL2, IndBinary,
       SumPositive, HingeLoss, HuberLoss,
       LogBarrier,
       LeastSquares,
       Maximum,
       NormL0, NormL1, NormL2, NormL21, NormLinf, NuclearNorm, SqrNormL2, ElasticNet,
       FirmThreshold,
       DistL2, SqrDistL2,
       Zero

export Conjugate,
       Postcompose,
       PrecomposeDiagonal,
#        PrecomposeGramDiagonal,
       SlicedSeparableSum,
       SeparableSum,
       Tilt,
       Regularize

abstract ProximableFunction

include("utilities/deepArrays.jl")
include("utilities/symmetricpacked.jl")

include("calculus/conjugate.jl")
include("calculus/postcompose.jl")
include("calculus/precomposeDiagonal.jl")
# include("calculus/precomposeGramDiagonal.jl")
include("calculus/separableSum.jl")
include("calculus/slicedSeparableSum.jl")
include("calculus/tilt.jl")
include("calculus/regularize.jl")

include("functions/distL2.jl")
include("functions/elasticNet.jl")
include("functions/firmThreshold.jl")
include("functions/logBarrier.jl")
include("functions/normL2.jl")
include("functions/normL1.jl")
include("functions/normL21.jl")
include("functions/normL0.jl")
include("functions/nuclearNorm.jl")
include("functions/hingeLoss.jl")
include("functions/huberLoss.jl")
include("functions/indAffine.jl")
include("functions/indBallL0.jl")
include("functions/indBallL1.jl")
include("functions/indBallL2.jl")
include("functions/indBallRank.jl")
include("functions/indBinary.jl")
include("functions/indBox.jl")
include("functions/indNonnegative.jl")
include("functions/indNonpositive.jl")
include("functions/indZero.jl")
include("functions/indExp.jl")
include("functions/indFree.jl")
include("functions/indPoint.jl")
include("functions/indPSD.jl")
include("functions/indSimplex.jl")
include("functions/indSOC.jl")
include("functions/indSphereL2.jl")
include("functions/indHalfspace.jl")
include("functions/sqrDistL2.jl")
include("functions/sqrNormL2.jl")
include("functions/sumLargest.jl")
include("functions/sumPositive.jl")
include("functions/maximum.jl")
include("functions/normLinf.jl")
include("functions/leastSquares.jl")

function Base.show(io::IO, f::ProximableFunction)
  println(io, "description : ", fun_name(f))
  println(io, "domain      : ", fun_dom(f))
  println(io, "expression  : ", fun_expr(f))
  print(  io, "parameters  : ", fun_params(f))
end

fun_name(  f) = "n/a"
fun_dom(   f) = "n/a"
fun_expr(  f) = "n/a"
fun_params(f) = "n/a"

is_prox_accurate(f::ProximableFunction) = true
is_separable(f::ProximableFunction) = false
is_convex(f::ProximableFunction) = false
is_set(f::ProximableFunction) = is_cone(f)
is_cone(f::ProximableFunction) = false

"""
  prox(f::ProximableFunction, x::AbstractArray, γ::Real=1.0)

Computes the proximal point of `x` with respect to function `f`
and parameter `γ > 0`, that is

  y = argmin_z { f(z) + 1/(2γ)||z-x||² }

and returns `y` and `f(y)`.
"""

function prox(f::ProximableFunction, x::AbstractArray, gamma::Union{Real, AbstractArray}=1.0)
  y = similar(x)
  fy = prox!(y, f, x, gamma)
  return y, fy
end

"""
  prox!(y::AbstractArray, f::ProximableFunction, x::AbstractArray, γ::Real=1.0)

Computes the proximal point of `x` with respect to function `f`
and parameter `γ > 0`, and writes the result in `y`. Returns `f(y)`.
"""

function prox!(y::AbstractArray, f::ProximableFunction, x::AbstractArray, gamma::Union{Real, AbstractArray}=1.0)
  throw(MethodException(
    "prox! is not implemented for y::", typeof(y), ", f::", typeof(f),
    ", x::", typeof(x), ", gamma::", typeof(gamma)
  ))
end

end
