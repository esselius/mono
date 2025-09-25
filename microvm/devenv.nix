{ inputs, pkgs, ... }:

{
  outputs.vm1 =
    (inputs.nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        inputs.microvm.nixosModules.microvm
        {
          networking.hostName = "vm1";

          # Enable auto-login for root on console
          services.getty.autologinUser = "root";

          # Enable SSH with root login and port forwarding
          services.openssh = {
            enable = true;
            settings.PermitRootLogin = "yes";
          };

          networking.firewall.allowedTCPPorts = [ 22 ];

          microvm = {
            vmHostPackages = pkgs;
            # User networking for SSH
            interfaces = [
              {
                type = "user";
                id = "qemu";
                mac = "02:00:00:01:01:01";
              }
            ];
            # Forward host port 2222 to guest port 22
            forwardPorts = [
              {
                host.port = 2222;
                guest.port = 22;
              }
            ];
            shares = [
              {
                proto = "9p";
                tag = "ro-store";
                source = "/nix/store";
                mountPoint = "/nix/.ro-store";
              }
            ];
            socket = "control.socket";
          };
        }
      ];
    }).config.microvm.declaredRunner;
}
