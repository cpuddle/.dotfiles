{ inputs, pkgs, ... }:

{
    programs.hyprland = {
	enable = true;
	xwayland.enable = true;
	package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
	portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSORS = "1";

	NIXOS_OZONE_WL = "1";
    };

    hardware = {
	opengl.enable = true;

	nvidia.modesetting.enable = true;
    };

    environment.systemPackages = with pkgs; [
    	hyprland
        waybar
	swaynotificationcenter
	libnotify
	swww
	kitty
	alacritty
	rofi-wayland
	networkmanagerapplet
	gnome.nautilus
	firefox
	wayland
    ];

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    systemd.services.hyprland = {
	description = "Hyprland Wayland Compositor";
	after = [ "graphical.target" ];
	serviceConfig = {
	    ExecStart = "/run/current-system/sw/bin/hyprland";
	    User = "collin";
	    Restart = "always";
	    Environment = "XDG_SESSION_TYPE=wayland";
	};
	wantedBy = [ "default.target" ];
    };
}
