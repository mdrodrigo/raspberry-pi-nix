{ pkgs, lib, ... }: {
  time.timeZone = "America/New_York";
  users.users.root.initialPassword = "root";
  networking = {
    hostName = "example";
    useDHCP = false;
    interfaces = {
      wlan0.useDHCP = true;
      eth0.useDHCP = true;
    };
  };
  raspberry-pi-nix.board = "bcm2711";
  hardware = {
    raspberry-pi = {
      config = {
        all = {
          base-dt-params = {
            BOOT_UART = {
              value = 1;
              enable = true;
            };
            uart_2ndstage = {
              value = 1;
              enable = true;
            };
          };
          dt-overlays = {
            disable-bt = {
              enable = true;
              params = { };
            };
          };
        };
      };
    };
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.shellhub-agent = {
    enable = true;
    tenantId = "fc19fa78-0a7b-4905-9596-01b7b5c2cc9e";
  };
  nix.settings.experimental-features = lib.mkDefault "nix-command flakes";
}
