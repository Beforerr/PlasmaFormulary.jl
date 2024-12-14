function gyrofrequency(B::BField, mass::Mass, q::Charge)
    upreferred(q * B / mass)
end

function electron_gyrofrequency(B::BField)
    gyrofrequency(B, me, Unitful.q)
end

function ion_gyrofrequency(B::BField, Z, mass::Mass)
    gyrofrequency(B, mass, Z * Unitful.q)
end

"""
    plasma_frequency(n, [q, mass])

Particle plasma frequency, often this is the cold electrons plasma frequency.

References:
- https://en.wikipedia.org/wiki/Plasma_oscillation
"""
function plasma_frequency(n::NumberDensity, q::Charge, mass::Mass)
    upreferred(q * sqrt(n / mass / ε0))
end

plasma_frequency(n::NumberDensity) = plasma_frequency(n, Unitful.q, me)

"""
    plasma_frequency(n, Z, mass_numb)

Ion plasma frequency.
"""
plasma_frequency(n::NumberDensity, Z::Integer, mass_number) =
    plasma_frequency(n, Z * Unitful.q, mass_number * Unitful.u)

# TODO: Do we need these?
const electron_plasma_frequency = plasma_frequency
const ion_plasma_frequency = plasma_frequency
