{ config, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm; # Ensures QEMU is used with KVM support

  networking.firewall.allowedTCPPorts = [ 16509 ]; # Allow default libvirt port
  networking.firewall.allowedUDPPorts = [ 53 ]; # For DNS with libvirt's default network
  users.groups.libvirt = {};
  users.groups.kvm = {};

  users.extraGroups.libvirt = { };
  users.extraGroups.kvm = { };
  users.extraGroups.libvirt-qemu = { };

  users.users.dkruces = {
    isNormalUser = true;
    extraGroups = [ "libvirt" "kvm" "libvirt-qemu" ];
  };
}
