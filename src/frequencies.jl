function gyrofrequency(B::BField, mass, q)
    upreferred(q * B / mass)
end

function electron_gyrofrequency(B::BField)
    gyrofrequency(B, me, Unitful.q)
end

function ion_gyrofrequency(B::BField, Z, mass)
    gyrofrequency(B, mass, Z * Unitful.q)
end

"""
    plasma_frequency(n, [q, mass])

Particle plasma frequency, often this is the cold electrons plasma frequency.

References:
- https://en.wikipedia.org/wiki/Plasma_oscillation
"""
function plasma_frequency(n::NumberDensity, q, mass::Mass)
    upreferred(sqrt(n * q^2 / mass / ε0))
end

plasma_frequency(n::NumberDensity) = plasma_frequency(n, Unitful.q, me)

function ion_plasma_frequency(
    density::NumberDensity,
    charge_state::Integer,
    ion_mass::Unitful.Mass,
)
    upreferred(sqrt(density * (charge_state * q)^2 / ion_mass / ε0))
end