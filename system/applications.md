# Preferrences (Applications/Settings)

+ **Theme:** Breeze-Dark
+ **Display Manager:** Maldives (SDDM)

<hr>

+ **Web Browser:** 
	- Brave
	```
	sudo pacman -S brave-bin
	```
	- Firefox Developer Edition
	```
	sudo pacman -S firefox-developer-edition
	```

+ **Text Editors:** 
	- Sublime Text 
	```
	curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
	```
	```
	echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf # This step adds in the sublime mirror.
	```
	```
	sudo pacman -Syu sublime-text
	```
	- Vim 
	```
	sudo pacman -S vim
	```

+ **Office Suite:** LibreOffice
```
sudo pacman -S libreoffice-fresh
```
+ **Image Editor:** GIMP
```
sudo pacman -S gimp
```
+ **Android Development:** Android-Studio
```
sudo pacman -S android-studio
```

---

## Blackarch Zone
### To use any of these, blackarch repos must be present in `/etc/pacman.conf` or externally in `/etc/pacman.d/$FILE_NAME`. In the latter case, `/etc/pacman.conf` must have `include $FILE_NAME`.

+ **Hex Editor:** Bless
```
sudo pacman -S bless
```
+ **Disassemblers:** 
	- Ghidra
	```
	sudo pacman -S ghidra
	```
	- Hopper
	```
	sudo pacman -S hopper
	```

	- xdd (For viewing hex-dump) (included with `vim`)
	- objdump (For viewing hex-dump) (included)
	- strings (For viewing readable strings in hex-dump) (included)


+ **EXIF Utility:** exiftool
	```
	cd ~/Downloads/${DOWNLOAD_DIR}
	curl -O https://exiftool.org/Image-ExifTool-12.39.tar.gz
	gzip -dc Image-ExifTool-12.39.tar.gz | tar -xf -
    cd Image-ExifTool-12.39
    perl Makefile.PL
    make test
    sudo make install
    ```
+ **Embedded Files Viewer:** binwalk
	```
	sudo pacman -S binwalk
	```

+ **Embedded Files Extractors:**
	- gzip (included)
	- unzip (included)
	- unrar (included)
	- tar (included)
	- foremost 
	```
	sudo pacman -S foremost
	```
	- pigz (for zlib files)
	```
	sudo pacman -S pigz
	```

+ **Network pwning & sniffers:**
	- wireshark
	```
	sudo pacman -S wireshak-qt
	sudo pacman -S wireshak-cli
	```

	- tcpdump 
	```
	sudo pacman -S tcpdump
	```

	- traceroute
	```
	sudo pacman -S traceroute
	```

	- python pwn package
	```
	sudo pacman -S pwntools
	```

	- pcapfex 
	```
	sudo pacman -S pcapfex
	```

	- mtr (basically ping + traceroute)
	```
	sudo pacman -S mtr
	```