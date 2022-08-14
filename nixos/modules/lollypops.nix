{ config, pkgs, lib, ... }:

{
  lollypops.deployment = {
    ssh = {
      user = "admin";
      opts = "-A";
      host = "${config.networking.hostName}.example.com";
    };
    sudo.enable = true;
    config-dir = "/tmp/dep";
  };
}
