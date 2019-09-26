using Povray
using Test


@testset "scene" begin

    c = pov(:Camera, :location, [0, 0, 0], :look_at, [1, 2, 3])
    println(c)

end

@testset "scene 2" begin

    c = pov(:Camera, :location, [1, 2, 3], :look_at, [3, 4, 5])
    s = pov(
        :Sphere, [0, 0, 0], 3,
        pov(:Texture,
            pov(:Pigment, :color, pov"blue"),
            pov(:Finish, :reflection, 1)
        ))

    scene = pov(c, s)
    println(scene)

end


@testset "scene 2" begin

    c = pov(:Camera, :location, [1, 2, 3], :look_at, [3, 4, 5])
    i = pov(
        :Intersection,
        pov(:Union,
            pov(:Sphere, [0, 0, 0], 3),
            pov(:Sphere, [1, 1, 1], 4)
        ),
        pov(:Box, [1, 1, 1], [4, 4, 4])
    )

    scene = pov(c, i)
    println(scene)

end

# @testset "render" begin

    cam = pov(:camera, :location, [0, 5, 10], :look_at, [0, 0, 0])

    reye = 1
    eyepos = [0, reye, 0]

    s_eye = pov(:sphere, eyepos, reye)

    eye = pov(
        :difference,
        s_eye,
        pov(:sphere, eyepos, reye * 0.9),
        pov(:sphere, eyepos .+ [0, 0, reye], reye * 0.3),
        pov(:pigment, :color, :White)
    )

    iris = pov(
        :intersection,
        s_eye
    )

    ground = pov(
        :plane, [0, 1, 0], 0,
        pov(:pigment, :checker, :White, :Gray)
    )

    l = pov(:light_source, [5, 5, 5], :White)

    scene = pov(
        "#include \"colors.inc\"",
        cam, eye, ground, l
    )

    render(scene)

# end
