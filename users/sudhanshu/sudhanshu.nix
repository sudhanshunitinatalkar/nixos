{ pkgs, ... }:

{
  users.users.sudhanshu = 
  {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" ];
  };

  home-manager.users.sudhanshu = {
    imports = [ ../../users/sudhanshu/home.nix ];
  };
}
