{bear}:
pkg: let
  compileCommands = (pkg.override {
    stdenv = pkg.stdenv.override (super: {
      cc = super.cc.overrideAttrs (self: super: {
        installPhase = super.installPhase or "" + ''
          substitute "${./cc-wrapper-hook}" "$out/nix-support/cc-wrapper-hook" \
            --replace "@bear@" "${bear}/bin/bear"
        '';
      });
      allowedRequisites = null;
    });
  }).overrideAttrs (self: super: {
    installPhase = "cp compile_commands.json $out";
  });
in compileCommands