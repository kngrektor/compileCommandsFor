{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
in {
  treefmt = std.lib.cfg.treefmt {
    packages = [
      nixpkgs.alejandra
      nixpkgs.nodePackages.prettier
    ];
    data.formatter = {
      nix = {
        command = "alejandra";
        includes = ["*.nix"];
      };
      prettier = {
        command = "prettier";
        includes = ["*.md" "*.json"];
      };
    };
  };
}
