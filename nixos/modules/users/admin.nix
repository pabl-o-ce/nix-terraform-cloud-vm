{ config, pkgs, lib, ... }: {
  users.users.admin = {
    isNormalUser = true;
    initialPassword = "test";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJAGm66rJsr8vjuhgbFH4lEPncPq27o6BHz09jikoOiM example-key"
    ];
    description = "administrator";
    extraGroups = [ "wheel" ];
  };
}
