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

+ **Text Editor:** Sublime Text 
```
curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
```
```
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
```
```
sudo pacman -Syu sublime-text
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
