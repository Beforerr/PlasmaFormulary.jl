export gyroradius, rc_

"""
Calculate the radius of circular motion for a charged particle in a uniform magnetic field

References: [PlasmaPy API Documentation](https://docs.plasmapy.org/en/latest/api/plasmapy.formulary.lengths.gyroradius.html)

# Examples
```jldoctest
julia> gyroradius(0.2u"T", 1e6u"K")
0.006682528174870854 m
```
"""
function gyroradius(B, Vperp::Velocity; mass_numb=1, Z=1)
    mass = mass_numb * u
    return upreferred(mass * Vperp / (Z * q * B))
end

function gyroradius(B, T::EnergyOrTemp; mass_numb=1, Z=1)
    Vperp = thermal_speed(T, mass_numb)
    return gyroradius(B, Vperp; mass_numb, Z)
end

gyroradius(val::Union{Velocity, EnergyOrTemp}, B::BField; kw...) = gyroradius(B, val; kw...)

const rc_ = gyroradius