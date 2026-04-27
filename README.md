# tdlib-wasm

A modern WebAssembly build of Telegram's [TDLib](https://github.com/tdlib/td).

This package is a low-level build artifact intended for use in other projects.
It does not provide a high-level JavaScript API for TDLib.

## Exports

The package exports:

- `dist/td_wasm.js`
- `dist/td_wasm.wasm`
- `dist/td_wasm.d.ts`

## Usage Warning

This package probably should not be used directly for most use cases.

It exposes the Emscripten module and TDLib's WASM entry points, which means
consumers need to handle TDLib's JSON API, authorization flow, storage, runtime
filesystem, and memory-level integration themselves.

## Build

The build is based on TDLib commit:

```text
8fc2344f3e3daf55983032a44c4156bd8a1a7533
```

It is built from the upstream TDLib web example with Emscripten. The local patch
changes the generated output to:

- emit ES module JavaScript glue
- target `web`, `worker`, and `node` environments
- emit TypeScript declarations
- expose the Emscripten `FS` and `cwrap` runtime methods

## License

This repository is licensed under the MIT License. TDLib itself is distributed
under its own license; see the upstream TDLib project for details.
