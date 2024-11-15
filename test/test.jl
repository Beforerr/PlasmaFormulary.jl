using PlasmaFormulary
using PlasmaFormulary: ion_plasma_frequency
using Unitful
using Unitful: mp, me, q
using Test
using LinearAlgebra

@testset "Lengths" begin
    @test gyroradius(0.2u"T", :p, 1e6u"K") ≈ 0.0067067967u"m"
    @test inertial_length(5u"m^-3", q, me) ≈ 2376534.75u"m"
end

@testset "Speed" begin
    B = [-0.014u"T", 0.0u"T", 0.0u"T"]
    Bmag = norm(B)
    n = 5e19 * u"m^-3"
    rho = n * (mp + me)
    @test Alfven_speed(B, rho) ==
          Alfven_speed(Bmag, rho) ==
          Alfven_speed(Bmag, n) ≈
          43173.870u"m/s"

    @test Alfven_velocity(B, rho) ≈ [-43173.870u"m/s", 0.0u"m/s", 0.0u"m/s"]
end

@testset "Frequency" begin
    @test plasma_frequency(1e19u"m^-3", q, mp) ≈ 4163294534.0u"s^-1"
    @test ion_plasma_frequency(1e19u"m^-3", 1, mp / Unitful.u) ≈ 4163294534.0u"s^-1"
    @test plasma_frequency(1e19u"m^-3") ≈ 1.783986365e11u"s^-1"
end
