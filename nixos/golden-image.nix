{ config, pkgs, lib, modulesPath, ... }:

{
  imports = [ modules/base.nix modules/openssh.nix modules/users ];
}
