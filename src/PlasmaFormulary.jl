module PlasmaFormulary

using Unitful
using UnitfulEquivalences
using Unitful: μ0, ε0, c, q
using Unitful: k, ħ
using Unitful: me, mp

@derived_dimension NumberDensity Unitful.𝐋^-3

const EnergyOrTemp = Union{Unitful.Temperature, Unitful.Energy}
energy(eot) = uconvert(u"J", eot, Thermal())
temperature(eot) = uconvert(u"K", eot, Thermal())
temperature(T:: Unitful.Temperature) = uconvert(u"K", T)

# Physical Constants (SI)
gravitational_constant = 6.67430e-11 * u"m^3 / s^2 / kg"
planck_constant = 6.62607e-34 * u"J * s"
# Proton/electron mass ratio excluded
# Electron charge/mass ratio excluded
rydberg_constant = 1.09737e7 * u"m^-1"
bohr_radius = 5.29177e-11 * u"m"
atomic_cross_section = 8.79736e-21 * u"m^2"
classical_electron_radius = 2.81794e-15 * u"m"
thomson_cross_section = 6.65246e-29 * u"m^2"
electron_compton_wavelength = 2.42631e-12 * u"m"
reduced_electron_compton_wavelength = 3.86159e-13 * u"m"
fine_structure_constant = 7.29735e-3
# Radiation constants excluded
stefan_boltzmann_constant = 5.67037e-8 * u"W / m^2 / K^4"
# Scales associated with 1 eV excluded
# Energy scales excluded
avogadro_number = 6.02214e23 * u"mol^-1"
faraday_constant = 9.64853e4 * u"C / mol"
gas_constant = 8.31446 * u"J / K / mol"
loschmidt_number = 2.68678e25 * u"m^-3"
atomic_mass_unit = 1.66054e-27 * u"kg"
standard_temperature = 273.15 * u"K"
atmospheric_pressure = 1.01325e5 * u"Pa"
# Pressure of 1 torr excluded
standard_molar_volume = 2.24140e-2 * u"m^3 / mol"
molar_weight_of_air = 2.89647e-2 * u"kg / mol"
# Calorie conversion omitted
gravitational_acceleration = 9.80665 * u"m / s^2"

# Fundamental plasma parameters
# These formulas have been converted to use SI units from the original Gaussian cgs units
# that are used in the 2023 edition of the formulary.
function electron_gyrofrequency(magnetic_field::Unitful.BField)
    upreferred(q * magnetic_field / me)
end

function ion_gyrofrequency(magnetic_field::Unitful.BField; charge_state::Integer = 1, ion_mass::Unitful.Mass = mp)
    upreferred(charge_state * q * magnetic_field / ion_mass)
end

function electron_plasma_frequency(density::NumberDensity)
    upreferred(sqrt(density * q^2 / me / ε0))
end

function ion_plasma_frequency(density::NumberDensity, charge_state::Integer, ion_mass::Unitful.Mass)
    upreferred(sqrt(density * (charge_state * q)^2 / ion_mass / ε0))
end

# electron and ion trapping rates excluded

#electron and ion collision rates excluded

function electron_debroglie_length(eot::EnergyOrTemp)
    upreferred(sqrt(2 * pi * ħ^2 / me / energy(eot)))
end

function classical_minimum_approach_distance(eot::EnergyOrTemp)
    upreferred(q^2 / energy(eot) / (4 * pi * ε0))
end

# TODO: electron_gyryradius

# TODO: ion_gyroradius

function electron_inertial_length(density::NumberDensity)
    upreferred(c / electron_plasma_frequency(density))
end

function ion_inertial_length(density::NumberDensity, charge_state::Integer, ion_mass::Unitful.Mass)
    upreferred(c / ion_plasma_frequency(density, charge_state, ion_mass))
end

function debye_length(density::NumberDensity, eot::EnergyOrTemp)
    upreferred(sqrt(ε0 * energy(eot) / density / q^2))
end

function electron_thermal_velocity(eot::EnergyOrTemp)
    upreferred(sqrt(k * temperature(eot) / me))
end

function ion_thermal_velocity(eot::EnergyOrTemp, ion_mass::Unitful.Mass)
    upreferred(sqrt(k * temperature(eot) / ion_mass))
end

# TODO: ion_sound_velocity

# TODO: ion_sound_velocity

# TODO: plasma_parameter(temperature, density)

"""
    thermal_pressure(T, n)

Calculate the thermal pressure for a Maxwellian distribution.

# Arguments
- `T`: The particle temperature or energy.
- `n`: The particle number density.
"""
function thermal_pressure(T::EnergyOrTemp, n::NumberDensity)
    return n * k * temperature(T) |> upreferred
end

p_th = thermal_pressure

"""
    magnetic_pressure(B)

Calculate the magnetic pressure.
"""
function magnetic_pressure(B::Unitful.BField)
    return (B^2) / (2 * μ0)
end

"""
    beta(T, n, B)

Compute the plamsa beta (β), the ratio of thermal pressure to magnetic pressure.

# Arguments
- `T`: The temperature of the plasma.
- `n`: The particle density of the plasma.
- `B`: The magnetic field in the plasma.
"""
function beta(T::EnergyOrTemp, n::NumberDensity, B::Unitful.BField)
    p_th = thermal_pressure(T, n)
    p_B = magnetic_pressure(B)
    return p_th / p_B |> upreferred
end

include("speeds.jl")

end
