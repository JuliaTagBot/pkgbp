# This package autogenerated by BinaryBuilder.jl
module Ogg_jll

# We always require BP and Libdl
using BinaryProvider, Libdl
# Export each product accessor (functions, strings, handles, etc...)
export libogg

# Generate underscore-prefixed variable names that map to file locations
_libogg = nothing

# Convenience function to get the current directory
moddir() = dirname(something(pathof(@__MODULE__), @__FILE__))

# Executables push their dirnames onto PATH, on all platforms
function update_exe_vars!(PATH::Vector{String} = String[])
    update_deps_exe_vars!(PATH)
    # Embed our own executable product paths
    for p in ()
        push!(PATH, dirname(p))
    end
    return unique!(PATH)
end

# Library products push their dirnames onto a variable that
# depends on the current platform, that variable name is handled
# by the calling funciton, `envvars()`
function update_lib_vars!(LIBPATH::Vector{String} = String[])
    update_deps_lib_vars!(LIBPATH)
    # Embed our own library product paths
    for p in (_libogg,)
        push!(LIBPATH, dirname(p))
    end
    return unique!(LIBPATH)
end

# Same as above, but for dependencies
function update_deps_exe_vars!(PATH::Vector{String} = String[])
    
    return PATH
end
function update_deps_lib_vars!(LIBPATH::Vector{String} = String[])
    
    return LIBPATH
end


# Helper functions for dealing with environment variables
splitenv(l) = filter(!isempty, split(l, Sys.iswindows() ? ";" : ":"))
joinenv(l) = join(l, Sys.iswindows() ? ";" : ":")
function libpath_env()
    if Sys.iswindows()
        return "PATH"
    elseif Sys.isapple()
        return "DYLD_LIBRARY_PATH"
    else
        return "LD_LIBRARY_PATH"
    end
end

# Define the environment variables that must be set for the binaries
# to find their necessary dependencies.  We slap the dirname of every
# library product onto `LD_LIBRARY_PATH`.  We insert the dirname of
# every executable product onto `PATH`, etc...
#
# This method returns a `Dict` of environment mappings containing the
# mapping necessary for this package and all dependencies, that should
# be dynamically integrated into the current environment variables.
_envvar_cache = nothing
function envvars()
    global _envvar_cache

    # If we've already cached this work, don't do it again
    if _envvar_cache != nothing
        return _envvar_cache
    else
        _envvar_cache = Dict()
    end

    # Initialize the PATH to those paths specific to just our package
    _envvar_cache["PATH"] = update_exe_vars!()

    # For libraries, if we're on windows we merge it into PATH:
    if Sys.iswindows()
        update_lib_vars!(_envvar_cache["PATH"])
    else
        # Otherwise, it's a separate environment variable
        _envvar_cache[libpath_env()] = update_lib_vars!()
    end

    return _envvar_cache
end

# Given ENV and envvars(), merge them to create a withenv and
# apply that to `f` to run the function within an appropriate ENV
function with_merged_envs(f::Function, envs = envvars())
    merged_mapping = Pair[]
    for (k, v) in envs
        push!(merged_mapping,
            k => joinenv(vcat(splitenv(get(ENV, k, "")), v))
        )
    end

    return withenv(f, merged_mapping...)
end

function products(prefix::Prefix)
    return products = [
        LibraryProduct(prefix, ["libogg"], :libogg)
    ]
end

# Download and install the binaries
function build(;
        prefix::Prefix = Prefix(joinpath(moddir(), "..", "usr")),
        verbose::Bool = false,
    )
    # These are the 'location variables' that we locate() at the end
    global _libogg
    
    # Download binaries from hosted location
    bin_prefix = "https://github.com/staticfloat/OggBuilder/releases/download/v1.3.3-6"

    download_info = Dict(
        Linux(:aarch64, libc=:glibc) => ("$bin_prefix/Ogg.v1.3.3.aarch64-linux-gnu.tar.gz", "ce2329057df10e4f1755da696a5d5e597e1a9157a85992f143d03857f4af259c"),
        Linux(:armv7l, libc=:glibc, call_abi=:eabihf) => ("$bin_prefix/Ogg.v1.3.3.arm-linux-gnueabihf.tar.gz", "a70830decaee040793b5c6a8f8900ed81720aee51125a3aab22440b26e45997a"),
        Linux(:i686, libc=:glibc) => ("$bin_prefix/Ogg.v1.3.3.i686-linux-gnu.tar.gz", "1045d82da61ff9574d91f490a7be0b9e6ce17f6777b6e9e94c3c897cc53dd284"),
        Linux(:i686, libc=:musl) => ("$bin_prefix/Ogg.v1.3.3.i686-linux-musl.tar.gz", "d8fc3c201ea40feeb05bc84d7159286584427f54776e316ef537ff32347c4007"),
        Windows(:i686) => ("$bin_prefix/Ogg.v1.3.3.i686-w64-mingw32.tar.gz", "3f6f6f524137a178e9df7cb5ea5427de6694c2a44ef78f1491d22bd9c6c8a0e8"),
        Linux(:powerpc64le, libc=:glibc) => ("$bin_prefix/Ogg.v1.3.3.powerpc64le-linux-gnu.tar.gz", "b133194a9527f087bbf942f77bf6a953cb8c277c98f609479bce976a31a5ba39"),
        MacOS(:x86_64) => ("$bin_prefix/Ogg.v1.3.3.x86_64-apple-darwin14.tar.gz", "077898aed79bbce121c5e3d5cd2741f50be1a7b5998943328eab5406249ac295"),
        Linux(:x86_64, libc=:glibc) => ("$bin_prefix/Ogg.v1.3.3.x86_64-linux-gnu.tar.gz", "6ef771242553b96262d57b978358887a056034a3c630835c76062dca8b139ea6"),
        Linux(:x86_64, libc=:musl) => ("$bin_prefix/Ogg.v1.3.3.x86_64-linux-musl.tar.gz", "a7ff6bf9b28e1109fe26c4afb9c533f7df5cf04ace118aaae76c2fbb4c296b99"),
        FreeBSD(:x86_64) => ("$bin_prefix/Ogg.v1.3.3.x86_64-unknown-freebsd11.1.tar.gz", "a87e432f1e80880200b18decc33df87634129a2f9d06200cae89ad8ddde477b6"),
        Windows(:x86_64) => ("$bin_prefix/Ogg.v1.3.3.x86_64-w64-mingw32.tar.gz", "c6afdfb19d9b0d20b24a6802e49a1fbb08ddd6a2d1da7f14b68f8627fd55833a"),
    )

    ps = products(prefix)
    unsatisfied = any(!satisfied(p; verbose=verbose) for p in ps)

    dl_info = choose_download(download_info, platform_key_abi())
    if dl_info === nothing && unsatisfied
                # If we don't have a compatible .tar.gz to download, complain.
        # Alternatively, you could attempt to install from a separate provider,
        # build from source or something even more ambitious here.
        error("Your platform (\"$(Sys.MACHINE)\", parsed as \"$(triplet(platform_key_abi()))\") is not supported by this package!")

    end

    # If we have a download, and we are unsatisfied (or the version we're
    # trying to install is not itself installed) then load it up!
    if unsatisfied || !isinstalled(dl_info...; prefix=prefix)
        # Download and install binaries
        install(dl_info...; prefix=prefix, force=true, verbose=verbose)
    end

    # Write out a deps.jl file that will contain mappings for our products
    #depsjl_path = joinpath(moddir(), "deps.jl")
    #write_deps_file(depsjl_path, ps, verbose=verbose)

    # Actually, just locate them every time for now, using our amazing
    # prescience, knowing which index corresponds to which variable name,
    # saving ourselves the hassle of an eval(). (Eventually this could be
    # baked into a deps.jl file).  Note that we need to have our library
    # path for dependencies set properly here, otherwise we won't be able
    # to satisfy things properly.
    locate_libenv = Dict(
        libpath_env() => update_deps_lib_vars!()
    )
    if verbose
        display(locate_libenv)
    end
    with_merged_envs(locate_libenv) do
        _libogg = locate(ps[1]; verbose=verbose)
    end
end

# `libogg` is a LibraryProduct, which is exported as
# a handle that dlopen()'s 
libogg(; kwargs...) = dlopen(_libogg, RTLD_LAZY|RTLD_DEEPBIND|RTLD_GLOBAL; kwargs...)

# Our __init__() function attempts to open `deps.jl`, then checks each
# dependency to ensure it can be satisfied.  If anything goes wrong, we
# regenerate `deps.jl` and try again.
function __init__()
    # We want other packages to be able to use us to get our metadata,
    # so provide a global turn-off switch to skip automatic install
    if get(ENV, "BINARYPROVIDER_SKIP_AUTO_INSTALL", "") == "true"
        return
    end

    # Otherwise, auto-install our products
    build()

    # Force-load all library products (for now)
    libogg()
end

end # module
