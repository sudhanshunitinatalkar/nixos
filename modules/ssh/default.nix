# modules/ssh/default.nix
{ ... }:

{

  services.openssh.enable = true;

  home-manager.users.sudha = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
        };
        "pbrlab.eltros.in" = {
          user = "pbr";
          proxyCommand = "cloudflared access ssh --hostname %h";
        };
      };
    };
  };
}