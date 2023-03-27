{bear}:
  pkg: let
    compileCommands = pkg.overrideAttrs (super: {
    installPhase = "cp compile_commands.json $out";
    cmakeFlags = super.cmakeFlags ++ ["-DCMAKE_EXPORT_COMPILE_COMMANDS=1"];
    stdenv = super.stdenv.override (super: {
      cc = super.cc.overrideAttrs (super: {
        installPhase = super.installPhase or "" + ''
          substitute "${./cc-wrapper-hook}" "$out/nix-support/cc-wrapper-hook" \
            --replace "@bear@" "${bear}/bin/bear"
        '';
        allowedRequisites = null;
      });
    });
  });
in compileCommands
