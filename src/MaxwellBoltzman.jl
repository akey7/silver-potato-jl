module MaxwellBoltzmann

using Distributions

export maxwell_pdf, maxwell_rvs

kb = 1.380649e-23
kg_per_amu = 1.661e-27

function scale(temp_k, mass_amu)
    sqrt(2*kb*temp_k/mass_amu/kg_per_amu)
end

function maxwell_pdf(speeds, temp_k, mass_amu)
    sigma = scale(temp_k, mass_amu)

    function pdf(speed)
        sqrt(2/π)*(speed^2*exp(-speed^2/(2*sigma^2))) / sigma^3
    end

    pdf.(speeds)
end

function maxwell_rvs(temp_k, mass_amu, size)
    sigma = scale(temp_k, mass_amu)
    dist = sigma * Chi(3)
    rand(dist, size)
end

end