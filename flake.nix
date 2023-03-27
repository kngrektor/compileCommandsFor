{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    std-data-collection = {
      url = "github:divnix/std-data-collection";
      inputs = {
        std.follows = "std";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    self,
    std,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = self + "/comb";
      cellBlocks = with std.blockTypes; [
        (functions "lib")
        (devshells "devshells")
        (nixago "configs")
      ];
    }
    {
      devShells = std.harvest self ["repo" "devshells"];
      lib = std.harvest self ["compileCommands" "lib"];
    };
}
