###########################################################
# TWO-DIMENSIONAL GENERALIZED BORN MODEL                  #
###########################################################

module GeneralizedBorn

using Random

export init_model, rij, delta_g_solv

"""
    init_model(radius::Float64, charge::Float64, row_and_col_count::Int, size_x::Float64, size_y::Float64)

Initialize a dictionary that contains the data for a Generalized Born Model simulation.

# Arguments
- `radius::Float64`: Born radius of the atoms
- `charge::Float64`: Charge of the atoms
- `row_and_col_count::Int`: The size of the 2D grid of atoms.
- `size_x::Float64`: The x length of the simulation.
- `size_y::Float64`: The y length of the simulation. 
"""
function init_model(radius::Float64, charge::Float64, row_and_col_count::Int, size_x::Float64, size_y::Float64)
    rows = collect(range(start=radius, stop=size_y, step=size_y / row_and_col_count))
    cols = collect(range(start=radius, stop=size_x, step=size_x / row_and_col_count))
    grid_matrix_1 = [(row, col) for row ∈ rows, col ∈ cols]
    grid_vector = reshape(grid_matrix_1, length(rows) * length(cols))
    xs = [t[i] for t in grid_vector, i in 1:2]
    as = radius .+ zeros(Float64, length(xs[:, 1]))
    qs = charge .+ zeros(Float64, length(xs[:, 1]))

    Dict(:xs => xs, :as => as, :qs => qs)
end

"""
    rij(xs::Matrix{Float64}, i::Int, j::Int)

Calculate the distance between two atoms.

# Arguments
- `xs::Matrix{Float64}`: Locations of the atoms
- `i::Int`: ith atom
- `j::Int`: jth atom
"""
function rij(xs::Matrix{Float64}, i::Int, j::Int)
    sqrt((xs[i,1]-xs[j,1])^2 + (xs[i,2]-xs[j,2])^2)
end

"""
    delta_g_solv(model::Dict{Symbol, Array{Float64}}, epsilon::Float64)

Calculate ΔG of solvation, assuming no overlap between spheres.

# Arguments
- `model::Dict{Symbol, Array{Float64}}`: The initialized model.
- `epsilon::Float64`: Permitivity of the medium.
"""
function delta_g_solv(model::Dict{Symbol, Array{Float64}}, epsilon::Float64)
    xs = model[:xs]
    as = model[:as]
    qs = model[:qs]
    n = length(xs[:, 1])
    a = -0.5 * (1 - 1/epsilon)
    b = 0

    function fn_c(i)
        qs[i]^2 / (2 * as[i])
    end

    c = sum(fn_c.(eachindex(qs)))

    for i ∈ 1:n-1
        for j ∈ i+1:n
            b += qs[i] * qs[j] / rij(xs, i, j)
        end
    end

    a * b + c
end

end
