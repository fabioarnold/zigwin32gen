# zigwin32gen

Autogenerated Zig bindings for Win32 using https://github.com/marlersoft/win32json

## How to generate the Windows Zig bindings

* Clone the repo
```
git clone https://github.com/marlersoft/win32json deps/win32json
```
> TODO: once win32json is more complete, I'll reference a specific tag/sha to checkout

* Generate the Zig bindings
```
zig build genzig
```

This will generate the bindings in the "out" directory.  The file `out/win32.zig` is the main package file.  It will contain pub imports to all sub modules in the "win32" directory.  It will also contain a special pub symbol `everything` that provides direct access to all symbols in the Windows SDK through a single namespace.

## win32json vs C/C++ Win32 SDK

The win32metadata project from which win32json is generated does not expose the exact same interface as the classic C/C++ header files did.  One thing I'd like is to support is to be able to take a Windows C/C++ example and port it to Zig without changing any names/types or the way it interfaces with the Windows API.  To support this I'll need to:

* Support a set of modules with the same structure as the Window headers.  For example, importing the `windows` module should have all the same declarations as the `windows.h` header.
* Generate structs with the same field names (hungarian notation)
* Support code that can be compiled for either Ascii or Wide characters.  Provide mappings like `CreateFile` to `CreateFileA` or `CreateFileW` based on this configuration.


For example, intead of `DWORD` or `UINT32`, I would generate `u32`.  Instead of field names with hungarian notation, I would generate them with snake case.  These would only be cosmetic changes, where it would look more natural to use the Windows API directly alongside other Zig APIs.  The bigger advantage to this is not having to track all the different ways to declare the same type, for example, a developer having to know that `DWORD`, `UINT32`, `ULONG`, `UINT` are all the same as `u32`.
* I may want to be able support different "views" into the api that change things like how to import the api.  These extra views should not add to compile-time unless they are being used.
* I may want to consider also generating wrapper APIs?  It's clear that wrapping APIs should exist, but I'm not sure if this wrapping API should be created/maintained manually or autogenerated from the Windows API data.
* I may want to make it possible to generate subsets of the complete API.  One example of where this could be used it to generate bindings to be included in the standard library, where only a small portion of the complete API is required.

