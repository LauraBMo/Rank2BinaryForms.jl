using Rank2BinaryForms
using Test

using Nemo

@testset "Rank2BinaryForms.jl" begin

    @testset "Computing roots" begin
        i = Image_affineGamma(6)
        @test i[1] == QQBar.([-2,-1,-fmpq(1 // 2)])
        @test i[2] == QQBar.([3, -3, -1])
        @test i[3] == QQBar.([2, 4, -2])
        @test i[4] == QQBar.([fmpq(3 // 2), 2, 3])
        @test i[5] == QQBar.([fmpq(1 // 3), -1, -fmpq(1 // 3)])
        @test i[6] == QQBar.([fmpq(1 // 2), 2, -1])
        @test i[7] == QQBar.([fmpq(2 // 3), fmpq(4 // 3), 2])
        @test i[8] == QQBar.([fmpq(1 // 4), fmpq(1 // 2), -fmpq(1 // 2)])
        @test i[9] == QQBar.([fmpq(1 // 2), fmpq(3 // 4), fmpq(3 // 2)])
        @test i[10] == QQBar.([fmpq(1 // 3), fmpq(1 // 2), fmpq(2 // 3)])
    end

    @testset "Building polynomials" begin
        @testset "Symbols" begin
            i = affineGamma(6)([1,2,3])
            vars = [:x, :y];
            poly = buildpolynomial(vars)(i);
            global x = -2;
            global y = 1;
            @test eval(poly) == QQBar(0)
            global x = 1;
            global y = 5;
            @test eval(poly) == QQBar(6930)
            global x = 1;
            global y = 0;
            @test eval(poly) == QQBar(0)
            global x = 1;
            global y = -1;
            @test eval(poly) == QQBar(0)
            global x = 1;
            global y = -2;
            @test eval(poly) == QQBar(0)
            i = affineGamma(6)([1,2,4])
            poly = buildpolynomial(vars)(i);
            global x = 3;
            global y = 1;
            @test eval(poly) == QQBar(0)
            global x = -3;
            global y = 1;
            @test eval(poly) == QQBar(0)
            global x = -1;
            global y = 1;
            @test eval(poly) == QQBar(0)
        end
        @testset "Nemo fmpz" begin
            g(d) = k -> exp(2 * pi * im * k / d);
            set_getting_rootsofunity(g);
            introots(r) = Int.(round.(real(r)))
            R, vars = PolynomialRing(FlintZZ, ["x", "y"])

            r1 = introots.(affineGamma(4)([1,2,3]))
            @test first(r1) == -1
            @test buildpolynomial(vars)(r1) == vars[1]^3 * vars[2] + 2 * vars[1]^2 * vars[2]^2 + vars[1] * vars[2]^3

            r2 = introots.(affineGamma(4)([1,2,4]))
            @test first(r2) == 2
            @test buildpolynomial(vars)(r2) == vars[1]^3 * vars[2] - vars[1]^2 * vars[2]^2 - 2 * vars[1] * vars[2]^3

            r3 = introots.(affineGamma(4)([1,3,4]))
            @test first(r3) == 0
            @test buildpolynomial(vars)(r3) == vars[1]^3 * vars[2] + vars[1]^2 * vars[2]^2
        end
    end
end
