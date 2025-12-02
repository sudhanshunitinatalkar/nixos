# NixOS Configuration
# To enable conservation mode (write '1' to the file)
echo 1 | sudo tee /sys/bus/platform/devices/VPC2004:00/conservation_mode

# To disable it
echo 0 | sudo tee /sys/bus/platform/devices/VPC2004:00/conservation_mode

# github ssh key command
ssh-keygen -t ed25519 -C "atalkarsudhanshu@proton.me"
