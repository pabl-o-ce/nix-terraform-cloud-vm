{ config, pkgs, lib, ... }: 

{
    services.openssh = {
        enable = lib.mkDefault true;
        openFirewall = lib.mkDefault true;
        startWhenNeeded = lib.mkDefault true;
        kexAlgorithms = lib.mkDefault [ "curve25519-sha256@libssh.org" ];
        passwordAuthentication = lib.mkDefault false;
        kbdInteractiveAuthentication = lib.mkDefault false;
        permitRootLogin = lib.mkDefault "no";
    };
    security.pam = {
        enableSSHAgentAuth = lib.mkDefault true;
        services.sudo.sshAgentAuth = lib.mkDefault true;
    };
}