using Unitful
using PlasmaFormulary
using Unitful: mp, me
using Test
using LinearAlgebra

@test rc_(0.2u"T", 1e6u"K") == rc_(1e6u"K", 0.2u"T") ≈ 0.0066825281u"m"

B = [-0.014u"T", 0.0u"T", 0.0u"T"]
Bmag = norm(B)
n = 5e19 * u"m^-3"
rho = n * (mp + me)
@test Alfven_speed(B, rho) ==
      Alfven_speed(Bmag, rho) ==
      Alfven_speed(Bmag, n) ≈
      43173.870u"m/s"

@test Alfven_velocity(B, rho) ≈ [-43173.870u"m/s", 0.0u"m/s", 0.0u"m/s"]
