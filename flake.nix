{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lollypops = {
      url = "github:arouzing/lollypops";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, lollypops, ... }:
    let system = "x86_64-linux";
    in {
      # nixosConfigurations = {
      #   webserver = nixpkgs.lib.nixosSystem {
      #     inherit system;
      #     modules = [
      #       lollypops.nixosModules.lollypops
      #       ./nixSystemFlake/machines/webserver/configuration.nix
      #     ];
      #   };
      # };
      packages.x86_64-linux = {
        linode = nixos-generators.nixosGenerate {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            # you can include your own nixos configuration here, i.e.
            ./nixos/modules/linode.nix
            ./nixos/golden-image.nix
          ];
          format = "raw";
        };
      };

      apps."x86_64-linux".default =
        lollypops.apps."x86_64-linux".default { configFlake = self; };
    };
}
