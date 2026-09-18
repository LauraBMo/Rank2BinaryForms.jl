using Rank2BinaryForms
using Documenter

DocMeta.setdocmeta!(Rank2BinaryForms, :DocTestSetup, :(using Rank2BinaryForms); recursive=true)

makedocs(;
    modules=[Rank2BinaryForms],
    authors="Laura Brustenga i Moncusí <brust@math.ku.dk>, Shreedevi K. Masuti and contributors",
    repo="https://github.com/LauraBMo/Rank2BinaryForms.jl/blob/{commit}{path}#{line}",
    sitename="Rank2BinaryForms.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://LauraBMo.github.io/Rank2BinaryForms.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/LauraBMo/Rank2BinaryForms.jl",
)
