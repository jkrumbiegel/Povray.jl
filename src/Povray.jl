module Povray

using FileIO

export pov, @pov_str, render

function indent(str)
    parts = split(str, r"(?<=\n)")
    l = length(parts)
    string(Iterators.flatten(zip(("\t" for _ in 1:l), parts))...)
end

macro pov_str(str)
    :("\"" * string($str) * "\"")
end

function pov(args...)
    join(pov.(args), "\n")
end

function pov(s::Symbol, args...)
    parts = indent(join(pov.(args), "\n"))

    """
    $s {
    $parts
    }"""
end

pov(x) = string(x)
pov(vec::AbstractVector{<:Real}) = "<" * join(string.(vec), ", ") * ">"
pov(s::Symbol) = string(s)


function render(s::String)

    open("temp.pov", "w") do f
        write(f, s)
    end

    run(`povray temp.pov`)
    load("temp.png")

end

end
