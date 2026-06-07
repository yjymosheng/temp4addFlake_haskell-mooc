{
  description = "A Nix-flake-based Haskell development environment with GHC 9.2.8";

  inputs = {
    # 使用旧版 nixpkgs，保留 GHC 9.2 支持（例如 24.05 稳定版）
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import nixpkgs { inherit system; };
          }
        );
      ghcVersion = "ghc928"; # 现在这个属性存在了
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs, system }:
        let
          haskellPackages = pkgs.haskell.packages.${ghcVersion};
        in
        {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              cabal-install
              haskellPackages.ghc # GHC 9.2.8
              haskellPackages.haskell-language-server
              zlib
              pkg
            ];
          };
        }
      );
    };
}
