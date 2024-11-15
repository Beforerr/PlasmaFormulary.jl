using PlasmaFormulary
using Test
using Aqua
using Unitful

@testset "PlasmaFormulary.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(PlasmaFormulary)
    end

    @testset "Utils" begin
        include("utils.jl")
    end
end
