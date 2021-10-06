#Script 1
echo "Welcome to Arch Linux Magic Script"
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
lsblk
echo "Enter the drive: "
read drive
cfdisk $drive 
lsblk
echo "Enter the root partition: "
read rootpartition
mkfs.ext4 $rootpartition 

read -p "Did you also create separate home partition? [y/n]" answerhome
if [[ $answerhome = y ]] ; then
  echo "Enter home partition: "
  read homepartition
  mkfs.ext4 $homepartition
  mkdir /mnt/home
  mount $homepartition /mnt/home
fi

read -p "Did you also create swap partition? [y/n]" answerswap
if [[ $answerswap = y ]] ; then
  echo "Enter swap partition: "
  read swappartition
  mkswap $swappartition
  swapon $swappartition
fi

read -p "Did you also create efi partition? [y/n]" answerefi
if [[ $answerefi = y ]] ; then
  echo "Enter EFI partition: "
  read efipartition
  mkfs.vfat -F 32 $efipartition
  mkdir -p /mnt/boot/efi
  mount $efipartition /mnt/boot/efi
fi
mount $rootpartition /mnt
pacstrap /mnt base base-devel linux-lts linux-firmware linux-lts-headers
genfstab -U /mnt >> /mnt/etc/fstab

sed '1,/^#part2$/d' arch_install.sh > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit 

#part2
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
passwd
pacman --noconfirm -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg
pacman --noconfirm -S dhcpcd networkmanager vim
systemctl enable NetworkManager.service 

echo "Enter Username: "
read username
useradd -m -g users -G wheel -s /bin/bash $username
passwd $username
#visudo
read -p "Search # %wheel ALL=(ALL) ALL then uncomment and save it to give your user sudo privilege. [y/n]" answerwheel
if [[ $answerwheel = y ]] ; then
  EDITOR=vim visudo
fi
echo "Pre-Installation Finish Reboot now"
rm /arch_install2.sh
