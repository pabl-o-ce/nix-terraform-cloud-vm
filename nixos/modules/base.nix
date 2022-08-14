{ config, pkgs, lib, modulesPath, ... }:

{
  system.stateVersion = "22.05";
  users.users.root.password = lib.mkDefault "";
}
