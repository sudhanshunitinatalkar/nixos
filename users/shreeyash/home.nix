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

        kikad
    ];


  programs.git = 
  {
    enable = true;
    # userName = "sudhanshunitinatalkar";
    # userEmail = "atalkarsudhanshu@proton.me";
  };
  
}