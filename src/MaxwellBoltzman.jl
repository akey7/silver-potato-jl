module MaxwellBoltzmann

using Distributions

export maxwell_pdf, maxwell_rvs

kb = 1.380649e-23
kg_per_amu = 1.661e-27

function scale(temp_k::Float64, mass_amu::Float64)
    sqrt(2*kb*temp_k/mass_amu/kg_per_amu)
end

"""
    maxwell_pdf(speeds::Vector{Float64}, temp_k::Float64, mass_amu::Float64)

Calculate Maxwell distribution PDF.

# Arguments
- `speeds::Vector{Float64}`: speeds of the atoms that is the x-axis of the PDF.
- `temp_k::Float64`: Temp (Kelvin) for the distribution
- `mass_amu::Float64`: Mass (amu) of molecules.
"""
function maxwell_pdf(speeds::Vector{Float64}, temp_k::Float64, mass_amu::Float64)
    sigma = scale(temp_k, mass_amu)

    function pdf(speed)
        sqrt(2/π)*(speed^2*exp(-speed^2/(2*sigma^2))) / sigma^3
    end

    pdf.(speeds)
end

"""
    maxwell_rvs(temp_k::Float64, mass_amu::Float64, size::Float64)

Pull random variables out of a Maxwell PDF.

# Arguments
- `temp_k::Float64`: Temperature in Kelvin.
- `mass_amu::Float64`: Mass (amu) of molecules
- `size::Int`: Number of random samples to draw.
"""
function maxwell_rvs(temp_k::Float64, mass_amu::Float64, size::Int)
    sigma = scale(temp_k, mass_amu)
    dist = sigma * Chi(3)
    rand(dist, size)
end

end