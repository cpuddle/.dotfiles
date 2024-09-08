{ config, pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        egl-wayland
    ];

    hardware.nvidia = {
    	
        modesetting.enable = true;

        powerManagement.enable = false;

        powerManagement.finegrained = false;

        open = false;

        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.production;

	#services.xserver.videoDrivers = [ "nvidia" ];
    };
}
