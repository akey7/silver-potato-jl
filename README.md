# silver-potato-jl
This is a repo to learn the full workflow of Documenter.jl

## Hints along the way

When creating the documentation project according to [Documenter.jl documentation](https://documenter.juliadocs.org/stable/man/guide/#Package-Guide), you will need to add the `SilverPotato` as a dev dependency to the Documenter package. Starting from the root of this repo, do this:

```
cd docs
julia --project=.
]
pkg> dev ..
```

See also [Pkg.jl documentation](https://pkgdocs.julialang.org/v1/managing-packages/#developing)
