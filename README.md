# CompileCommandsFor

Generate a compile_commands.json for clangd from a nix package/derivtion using cc-wrapper's cc-wrapper-hook and bear.

## Usage

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    compileCommandsFor = {
        url = "github:kngrektor/compileCommandsFor";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, compileCommandsFor}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."${system}";
    inherit (compileCommandsFor.lib."${system}") compileCommands;
  in {
    packages."${system}" = {
      compileCommands = compileCommands pkgs.hello;
    };
  };
}
```

`nix build .#compileCommands --out-link compile_commands.json`

## Prior work

[https://github.com/danielbarter/mini_compile_commands](https://github.com/danielbarter/mini_compile_commands)
