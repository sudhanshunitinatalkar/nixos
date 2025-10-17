# NixOS Configuration
# To enable conservation mode (write '1' to the file)
echo 1 | sudo tee /sys/bus/platform/devices/VPC2004:00/conservation_mode

# To disable it
echo 0 | sudo tee /sys/bus/platform/devices/VPC2004:00/conservation_mode