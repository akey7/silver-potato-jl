using Test

include("../src/generalized_born_model.jl")
using .GeneralizedBornModel

function setup_test_environmment()
    radius = 5.0
    charge = 1.0
    row_and_col_count = 2
    size_x = 500.0
    size_y = 500.0

    init_model(radius, charge, row_and_col_count, size_x, size_y)
end

@testset "Test GBM initialization" begin
    model = setup_test_environmment()
    
    centers_x = model[:xs][:, 1]
    centers_y = model[:xs][:, 2]

    @test all(isapprox.(centers_x, [5.0, 255.0, 5.0, 255.0], atol=0.01))
    @test all(isapprox.(centers_y, [5.0, 5.0, 255.0, 255.0], atol=0.01))
end

@testset "Test rij calculation" begin
    xs = [1.0 1.0; 2.0 2.0]
    @test isapprox(rij(xs, 1, 2), 1.414, atol=0.01)
end
