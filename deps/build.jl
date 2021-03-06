using BinaryProvider # requires BinaryProvider 0.3.0 or later

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, ["libxgboost", "xgboost"], :libxgboost),
]


# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.aarch64-linux-gnu-cxx03.tar.gz", "b599fac7b8416309421e9b0731dbc4f91a5bec207be5302ecbbf743e1e0dca48"),
    Linux(:aarch64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.aarch64-linux-gnu-cxx11.tar.gz", "752f619f32f874e0b379a8e947dfa955155a8924990f9015e90c9f93d99922d6"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.aarch64-linux-musl-cxx03.tar.gz", "fb55dd7aad759f73e0654aeefa4d7435eed98aa17678c088dbfbd6bd79c9607a"),
    Linux(:aarch64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.aarch64-linux-musl-cxx11.tar.gz", "5224fd2154051eab20acfb71fec4c1cd365ff268dab8b4333f7694c84c4a3096"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.arm-linux-gnueabihf-cxx03.tar.gz", "656a4eb4a2a44f05b83509471fa2046d946088240dd90eabfffb96dbae9a31d4"),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.arm-linux-gnueabihf-cxx11.tar.gz", "ee683b6df2f2cecb2a1c88262f6757c31bac576be7fb55c49be21f62fc352a48"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.arm-linux-musleabihf-cxx03.tar.gz", "270d398fafa2cb082a1f382f29c3a2e62ae0d66d66b87fc9ca61b50d51767099"),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.arm-linux-musleabihf-cxx11.tar.gz", "d0439f8f30558160e17b13410a79c32bd206e42247ba56a3b4b7d3adaaebefb7"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.i686-linux-gnu-cxx03.tar.gz", "fd9801855a15f0bffa3d0b92dc31bb63f31c9ace482ad25c6f530f713537cce9"),
    Linux(:i686, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.i686-linux-gnu-cxx11.tar.gz", "eefe95c4a7156d0d561ad8d508d75b85706507174fa08868577ff7f7ff26965b"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.i686-linux-musl-cxx03.tar.gz", "e2831d6abe161966bc4f9b267bae3e928418509b7e3e3272db19e052d6d84b83"),
    Linux(:i686, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.i686-linux-musl-cxx11.tar.gz", "115198a90d8084c587195407ee154ded8cafc64f2c34ec24f0496618b726b6a1"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.i686-w64-mingw32-cxx03.tar.gz", "7a9b377d1b0934508b9f806639a78b6fcf387373fc6224fe022ede86a52a2620"),
    Windows(:i686, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.i686-w64-mingw32-cxx11.tar.gz", "e978a037ac8e24913179802023c65021b34a09d2571b883fef6b0eb560931ddc"),
    Linux(:powerpc64le, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.powerpc64le-linux-gnu-cxx03.tar.gz", "9d6e028b794b755564fa1e9bff58c49be661b64e9beee4441c670eca3c0576ff"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.x86_64-apple-darwin14-cxx03.tar.gz", "8518d582a25eb12b8e0ef7f2dec49b6e1e84c0e9fe5f4eee616f9afdb4224578"),
    MacOS(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.x86_64-apple-darwin14-cxx11.tar.gz", "7b35da5c646c04b2fecef829b84bf6efc77ae396ef35fa48fd21465dae8b346a"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.x86_64-linux-gnu-cxx03.tar.gz", "2f20ff0361701246f0be3f757f06896f7917ec13b3ed0733492333928a99e566"),
    Linux(:x86_64, libc=:glibc, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.x86_64-linux-gnu-cxx11.tar.gz", "0521ddeca97c5f00c056312fd21957862ee7e624ec810602c0e7b277905edff8"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.x86_64-linux-musl-cxx03.tar.gz", "a6b104e8bbdee41bbe7d19cc66919a7f58699ad862d448a4749d4eb4e8be7de7"),
    Linux(:x86_64, libc=:musl, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.x86_64-linux-musl-cxx11.tar.gz", "f805bb141150b225b84e33b9b5f8cb2a40b4ea081b65958e5d2782fd439520d5"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx03)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.x86_64-w64-mingw32-cxx03.tar.gz", "b2d880cdf5b8246ada770df54c49e9904dceea2f168ca238e16f76b01261c675"),
    Windows(:x86_64, compiler_abi=CompilerABI(:gcc_any, :cxx11)) => ("https://github.com/JuliaPackaging/Yggdrasil/releases/download/XGBoost-v0.82-2/XGBoost.v0.82.0.x86_64-w64-mingw32-cxx11.tar.gz", "59b4ae4edd24916a241ee6e695d220927836e66b7cc678d530f26a0a7b0c3b1f"),
)

# Install unsatisfied or updated dependencies:
unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
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
write_deps_file(joinpath(@__DIR__, "deps.jl"), products, verbose=verbose)
