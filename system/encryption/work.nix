{
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/aedd0d6e-3c63-4a38-927f-8f67119eee78";
    preLvm = true;
    allowDiscards = true;
  };
}
