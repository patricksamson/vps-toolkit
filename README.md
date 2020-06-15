# VPS Toolkit
VPS Toolkit is a tool that is developed to simplify installing and configuring software on Ubuntu servers. Essentially the VPS Toolkit automates several processes and makes installing, uninstalling, and maintaining software around a server stack (LAMP, LEMP and other variations).

# Compatibility
Ubuntu (18.04). May work on other versions, variants and distributions but that has not been tested.
For Ubuntu, non-LTS versions are less likely to work properly as some packages might be missing or more recent.

# Installation and Usage
Clone repository on any Ubuntu based distro and execute the `setup.sh` bash script file.
```shell
apt-get update
apt-get install sudo git
git clone https://github.com/patricksamson/vps-toolkit -b master --single-branch --depth 1 /opt/vps-toolkit
sudo bash /opt/vps-toolkit/init.sh
sudo bash /opt/vps-toolkit/setup.sh
```
And follow the instructions on the screen.
