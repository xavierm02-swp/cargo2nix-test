I started from the "bare minimum flake" from the [README](https://github.com/cargo2nix/cargo2nix) that sets `rustVersion = "1.75.0"`, with the `edition = "2024"` commented in `Cargo.toml`, which works:

```
$ nix run
Hello world!
```

However, when I uncomment `edition = "2024"` in the `Cargo.toml`, I get an error:
```
$ nix run
error: builder for '/nix/store/c4ljyr0ifaz9k29hbmcw9ryg2q2rm86y-crate-cargo2nix-test-0.1.0.drv' failed with exit code 101;
       last 25 log lines:
       >
       > Caused by:
       >   feature `edition2024` is required
       >
       >   The package requires the Cargo feature called `edition2024`, but that feature is not stabilized in this version of Cargo (1.75.0 (1d8b05cdd 2023-11-20)).
       >   Consider trying a newer version of Cargo (this may require the nightly release).
       >   See https://doc.rust-lang.org/nightly/cargo/reference/unstable.html#edition-2024 for more information about the status of this feature.
       > error: failed to parse manifest at `/build/r8bm1bh445cwzmm4k40rpqfx7w09ard8-source/Cargo.toml`
       >
       > Caused by:
       >   feature `edition2024` is required
       >
       >   The package requires the Cargo feature called `edition2024`, but that feature is not stabilized in this version of Cargo (1.75.0 (1d8b05cdd 2023-11-20)).
       >   Consider trying a newer version of Cargo (this may require the nightly release).
       >   See https://doc.rust-lang.org/nightly/cargo/reference/unstable.html#edition-2024 for more information about the status of this feature.
       > /nix/store/wr08yanv2bjrphhi5aai12hf2qz5kvic-stdenv-linux/setup: line 136: [: !=: unary operator expected
       > error: failed to parse manifest at `/build/r8bm1bh445cwzmm4k40rpqfx7w09ard8-source/Cargo.toml`
       >
       > Caused by:
       >   feature `edition2024` is required
       >
       >   The package requires the Cargo feature called `edition2024`, but that feature is not stabilized in this version of Cargo (1.75.0 (1d8b05cdd 2023-11-20)).
       >   Consider trying a newer version of Cargo (this may require the nightly release).
       >   See https://doc.rust-lang.org/nightly/cargo/reference/unstable.html#edition-2024 for more information about the status of this feature.
       > /nix/store/wr08yanv2bjrphhi5aai12hf2qz5kvic-stdenv-linux/setup: line 131: pop_var_context: head of shell_variables not a function context
       For full logs, run:
         nix log /nix/store/c4ljyr0ifaz9k29hbmcw9ryg2q2rm86y-crate-cargo2nix-test-0.1.0.drv
```

If I try changing setting `rustVersion = "1.86.0"` in `flake.nix`, I get another error:
```
$ nix run
error: builder for '/nix/store/w3wjxl6658mqknr4yvq5cxjmvmiq0686-crate-secp256k1-sys-0.11.0.drv' failed with exit code 101;
       last 23 log lines:
       > unpacking sources
       > unpacking source archive /nix/store/y89zqkdampf343v6khvkg8400hbfd4m7-secp256k1-sys-0.11.0.tar.gz
       > source root is secp256k1-sys-0.11.0
       > setting SOURCE_DATE_EPOCH to timestamp 1153704088 of file secp256k1-sys-0.11.0/wasm/wasm.c
       > patching sources
       > updateAutotoolsGnuConfigScriptsPhase
       > configuring
       > building
       >    Compiling secp256k1-sys v0.11.0 (/build/secp256k1-sys-0.11.0)
       > error: unexpected `cfg` condition value: `recovery`
       >   --> build.rs:42:11
       >    |
       > 42 |     #[cfg(feature = "recovery")]
       >    |           ^^^^^^^^^^^^^^^^^^^^
       >    |
       >    = note: expected values for `feature` are: `alloc`, `default`, `lowmemory`, and `std`
       >    = help: consider adding `recovery` as a feature in `Cargo.toml`
       >    = note: see <https://doc.rust-lang.org/nightly/rustc/check-cfg/cargo-specifics.html> for more information about checking conditional configuration
       >    = note: requested on the command line with `-D unexpected-cfgs`
       >
       >
       > error: could not compile `secp256k1-sys` (build script) due to 1 previous error
       > /nix/store/wr08yanv2bjrphhi5aai12hf2qz5kvic-stdenv-linux/setup: line 131: pop_var_context: head of shell_variables not a function context
       For full logs, run:
         nix log /nix/store/w3wjxl6658mqknr4yvq5cxjmvmiq0686-crate-secp256k1-sys-0.11.0.drv
error: 1 dependencies of derivation '/nix/store/dq6li7lf8xp06ngb9dz8yca2szf8npq9-crate-cargo2nix-test-0.1.0.drv' failed to build
```

Note that using cargo from nixpkgs works just fine:
- `nix-shell -p cargo --run "cargo run"` works:
```
nix-shell -p cargo --run "cargo --version; cargo run"
cargo 1.86.0 (adf9b6ad1 2025-02-28)
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.05s
     Running `target/debug/cargo2nix-test`
Hello world!
```
