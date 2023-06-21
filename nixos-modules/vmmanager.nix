{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.vmmanager;
in {
  options.programs.vmmanager = {
    enable = mkEnableOption "VMManager";

    package = mkOption {
      type = types.package;
      description = mdDoc "The package to use for the vmmanager binary.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
