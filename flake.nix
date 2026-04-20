{
  description = "Linux configurator for Logitech devices";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.stdenv.mkDerivation rec {
          pname = "logitune";
          version = "0.2.3";

          src = pkgs.fetchFromGitHub {
            owner = "mmaher88";
            repo = "logitune";
            rev = "v${version}";
            hash = "sha256-zyALn1mOdQoUPj5j045pvCQjffQB6Rl/+QyKziCqixw=";
          };

          nativeBuildInputs = with pkgs; [
            cmake
            ninja
            pkg-config
            qt6.wrapQtAppsHook
          ];

          buildInputs = with pkgs; [
            qt6.qtbase
            qt6.qtdeclarative
            qt6.qtsvg
            systemd
          ];

          cmakeFlags = [
            "-DBUILD_TESTING=OFF"
          ];

          meta = with pkgs.lib; {
            description = "Linux configurator for Logitech devices (Options+ alternative)";
            homepage = "https://github.com/mmaher88/logitune";
            license = licenses.gpl3Only;
            mainProgram = "logitune";
            platforms = platforms.linux;
          };
        };

        packages.logitune = self.packages.${system}.default;
      }
    );
}
