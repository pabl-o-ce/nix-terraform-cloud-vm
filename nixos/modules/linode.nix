{ config, pkgs, lib, modulesPath, ... }:

{
    # boot.loader.grub.enable = lib.mkDefault true;
    # boot.loader.grub.version = lib.mkDefault 2;
    # boot.loader.grub.devices = ["/dev/sda"];
    
    # Virtualization support
    imports = [(modulesPath + "/profiles/qemu-guest.nix")];
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    services.qemuGuest = {
      enable = true;
    };

    fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    # Most linode instances have a swap disk paird with them
    swapDevices =
    [ 
      { device = "/dev/sdb"; }
    ];
    boot = {
        kernelModules = [ "kvm-amd" "kvm-intel" ];
        initrd.kernelModules =  [ "virtio_pci" "virtio_scsi" "ahci" "sd_mod" ];
        kernelParams = [ "console=ttyS0,19200n8" ]; # needed for Lish
        loader.grub = {
            forceInstall = true;
            # also needed for Lish
            extraConfig = ''
                serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
                terminal_input serial;
                terminal_output serial
            ''; 
        };
    };
    networking = {
      # Most of Linode’s default images have had systemd’s predictable interface names disabled. 
      # Because of this, most of Linode’s networking guides assume an interface of eth0
      usePredictableInterfaceNames = false; 
      useDHCP = false; # Disable DHCP globally as we will not need it.
      interfaces.eth0.useDHCP = true;
    };

    # Linode wants root ssh for their Lish and Glish services using lib.mkDefault so users can override it
    services.openssh = {
      enable = lib.mkDefault true;
      # permitRootLogin = lib.mkDefault "yes";
    };
    # Base Packages requested by linode for support reasons
    environment.systemPackages = with pkgs; [
      inetutils
      mtr
      sysstat
    ];
}