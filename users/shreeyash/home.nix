{ pkgs, ... }:

{
    home.packages = with pkgs; 
    [
        tree
        util-linux
        vim
        wget
        curl
        git
        gptfdisk
        
        cloudflared

        kicad
    ];


  programs.git = 
  {
    enable = true;
    # userName = "sudhanshunitinatalkar";
    # userEmail = "atalkarsudhanshu@proton.me";
  };
  
}