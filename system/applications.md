# Preferrences (Applications/Settings)

+ **Theme:** Breeze-Dark
+ **Display Manager:** Maldives (SDDM)

<hr>

+ **Web Browser:** 
	- Brave
	```sh
	sudo pacman -S brave-bin
	```
	- Firefox Developer Edition
	```sh
	sudo pacman -S firefox-developer-edition
	```

+ **Text Editors:** 
	- Sublime Text 
	```sh
	curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
	
	echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf # This step adds in the sublime mirror.
	
	sudo pacman -Syu sublime-text
	```
	- Vim 
	```sh
	sudo pacman -S vim
	```
	- Marktext
	```
	https://marktext.app/
	```

+ **Office Suite:** LibreOffice
```sh
sudo pacman -S libreoffice-fresh
```
+ **Image Editor:** GIMP
```sh
sudo pacman -S gimp
```
+ **Android Development:** Android-Studio
```sh
sudo pacman -S android-studio
```

---

## Blackarch Zone
### To use any of these, blackarch repos must be present in `/etc/pacman.conf` or externally in `/etc/pacman.d/$FILE_NAME`. In the latter case, `/etc/pacman.conf` must have `include $FILE_NAME`.

+ **Blackarch Repositories:**
```sh
curl -O https://blackarch.org/strap.sh
echo 8bfe5a569ba7d3b055077a4e5ceada94119cccef strap.sh | sha1sum -c
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syyu
```

+ **Hex Editor:** Bless
```sh
sudo pacman -S bless
```
+ **Disassemblers:** 
	- Ghidra
	```sh
	sudo pacman -S ghidra
	```
	- Hopper
	```sh
	sudo pacman -S hopper
	```

	- xdd (For viewing hex-dump) (included with `vim`)
	- objdump (For viewing hex-dump) (included)
	- strings (For viewing readable strings in hex-dump) (included)


+ **EXIF Utility:** exiftool
	```sh
	cd ~/Downloads/${DOWNLOAD_DIR}
	curl -O https://exiftool.org/Image-ExifTool-12.39.tar.gz
	gzip -dc Image-ExifTool-12.39.tar.gz | tar -xf -
    cd Image-ExifTool-12.39
    perl Makefile.PL
    make test
    sudo make install
    ```
+ **Embedded Files Viewer:** binwalk
	```sh
	sudo pacman -S binwalk
	```

+ **Embedded Files Extractors:**
	- gzip (included)
	- unzip (included)
	- unrar (included)
	- tar (included)
	- foremost 
	```sh
	sudo pacman -S foremost
	```
	- pigz (for zlib files)
	```sh
	sudo pacman -S pigz
	```

+ **Network pwning & sniffers:**
	- wireshark
	```sh
	sudo pacman -S wireshak-qt
	sudo pacman -S wireshak-cli
	```

	- tcpdump 
	```sh
	sudo pacman -S tcpdump
	```

	- traceroute
	```sh
	sudo pacman -S traceroute
	```

	- python pwn package
	```sh
	sudo pacman -S pwntools
	```
	- pcapfex 
	```sh
	sudo pacman -S pcapfex
	```
	- mtr (basically ping + traceroute)
	```sh
	sudo pacman -S mtr
	```