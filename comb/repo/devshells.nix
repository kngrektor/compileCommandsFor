{
  inputs,
  cell,
}: let
  inherit (inputs) std;
  lib = inputs.nixpkgs.lib // builtins;
in
  lib.mapAttrs (_: std.lib.dev.mkShell) {
    default = {
      name = "CreateCommands";
      nixago = with cell.configs;
        [
          treefmt
        ]
        ++ (with inputs.std-data-collection.data.configs; [
          editorconfig
          conform
          lefthook
        ]);
    };
  }
