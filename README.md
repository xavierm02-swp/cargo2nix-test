I'm trying to use packages that need edition 2024, so I started from the "bare minimum flake" and added the rust overlays to get newer versions, as described in the [README](https://github.com/cargo2nix/cargo2nix).

- `nix-shell -p cargo --run "cargo run"` works:
```
    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.14s
     Running `target/debug/cargo2nix-test`
Hello world!
```

- `nix run` does not work:
```
error: builder for '/nix/store/j3azpsqjxwza8nh0mm5vq8hs92374nmm-crate-secp256k1-sys-0.11.0.drv' failed with exit code 101;
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
         nix log /nix/store/j3azpsqjxwza8nh0mm5vq8hs92374nmm-crate-secp256k1-sys-0.11.0.drv
error: 1 dependencies of derivation '/nix/store/lvs4lmh8qn5c4k3nkla4z2a0d028jgls-crate-cargo2nix-test-0.1.0.drv' failed to build
```