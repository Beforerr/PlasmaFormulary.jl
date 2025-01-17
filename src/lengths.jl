"""
Calculate the radius of circular motion for a charged particle in a uniform magnetic field

References: [PlasmaPy API Documentation](https://docs.plasmapy.org/en/latest/api/plasmapy.formulary.lengths.gyroradius.html)

# Examples
```jldoctest
julia> gyroradius(0.2u"T", Unitful.me, Unitful.q, 1e6u"K")
0.00015651672339994665 m
```
"""
function gyroradius(B::BField, mass::Mass, q::Charge, Vperp::Velocity)
    return upreferred(mass * Vperp / (q * B))
end

function gyroradius(B::BField, mass::Mass, q::Charge, T::EnergyOrTemp)
    Vperp = thermal_velocity(T, mass)
    return gyroradius(B, mass, q, Vperp)
end

electron_gyroradius(B::BField, Vperp::Velocity) = gyroradius(B, me, Unitful.q, Vperp)
electron_gyroradius(B::BField, T::EnergyOrTemp) = electron_gyroradius(B, thermal_velocity(T, me))

function electron_debroglie_length(eot::EnergyOrTemp)
    upreferred(sqrt(2 * pi * ħ^2 / me / energy(eot)))
end

function classical_minimum_approach_distance(eot::EnergyOrTemp)
    upreferred(q^2 / energy(eot) / (4 * pi * ε0))
end

"""
The inertial length is the characteristic length scale for a particle to be accelerated in a plasma. The Hall effect becomes important on length scales shorter than the ion inertial length.

References: [PlasmaPy API Documentation](https://docs.plasmapy.org/en/latest/api/plasmapy.formulary.lengths.inertial_length.html)
"""
function inertial_length(n::NumberDensity, q::Charge, mass::Mass)
    upreferred(c / plasma_frequency(n, q, mass))
end

electron_inertial_length(n::NumberDensity) = upreferred(c / plasma_frequency(n))

function ion_inertial_length(n::NumberDensity, Z, mass::Mass)
    inertial_length(n, Z * Unitful.q, mass)
end

function debye_length(density::NumberDensity, eot::EnergyOrTemp)
    upreferred(sqrt(ε0 * energy(eot) / density / q^2))
end
