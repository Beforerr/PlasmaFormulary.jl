export gyroradius

"""
Calculate the radius of circular motion for a charged particle in a uniform magnetic field
"""
function gyroradius(B, mass_numb, Z, Vperp::Unitful.Velocity)
    mass = mass_numb * u
    return upreferred(mass * Vperp / (Z * q * B))
end

function gyroradius(B, mass_numb, Z, T)
    Vperp = thermal_speed(T, mass_numb)
    return gyroradius(B, mass_numb, Z, Vperp)
end

function gyroradius(B; Vperp=missing, T=missing, mass_numb=1, Z=1)
    Vperp !== missing && return gyroradius(B, mass_numb, Z, Vperp)
    T !== missing && return gyroradius(B, mass_numb, Z, T)
end