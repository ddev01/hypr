#!/bin/bash

clear
echo "Are you logged on Hyprland right now? [Y/N]"
read hypr
option="${hypr^^}"
if [ "$option" == "Y" ]; then
        hyprctl monitors all
        echo "type your main monitor, example [DP-1, HDMI-1]"
        read monitor
        for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
            sed -i "s/DP-1/$monitor/" "$theme_path" &>/dev/null
        done
        echo "type the refresh rate of your monitor, example [60, 140, 240]"
        read refresh
        for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
            sed -i "s/@240/@$refresh/" "$theme_path" &>/dev/null
        done
        echo "type the resolution of your monitor, example [1920x1080, 1280x720]"
        read resolution
        for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
            sed -i "s/1920x1080@$refresh/$resolution@$refresh/" "$theme_path" &>/dev/null
        done

    echo "Do you have a second monitor? [Y/N]"
    read hypr
    option="${hypr^^}"
    if [ "$option" == "Y" ]; then
        hyprctl monitors all
        echo "type your monitor, example [DP-2, HDMI-2]"
        read monitor2
        for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
            sed -i "s/DP-2/$monitor2/" "$theme_path" &>/dev/null
        done
        echo "type the refresh rate of your monitor, example [60, 140, 240]"
        read refresh2
        for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
            sed -i "s/@144/@$refresh2/" "$theme_path" &>/dev/null
        done
        echo "type the resolution of your monitor, example [1920x1080, 1280x720]"
        read resolution2
        for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
            sed -i "s/1920x1080@$refresh2/$resolution2@$refresh2/" "$theme_path" &>/dev/null
        done
        clear
        echo "type the width of your main display"
        echo "example: [1920, 1280]"
        read orientation
        # Second monitor is always on the left of main
        for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
            sed -i "s/1920x0/-${orientation}x0/" "$theme_path" &>/dev/null
        done

        echo "Do you have a third monitor? [Y/N]"
        read hypr
        option="${hypr^^}"
        if [ "$option" == "Y" ]; then
            hyprctl monitors all
            echo "type your third monitor, example [DP-3, HDMI-3]"
            read monitor3
            
            # Add third monitor config with 270 degree rotation to all theme configs
            for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
                echo "monitor = $monitor3, 1920x1080@60, 0x0, 1, transform,3" >> "$theme_path"
            done

            echo "type the refresh rate of your third monitor, example [60, 140, 240]"
            read refresh3
            echo "type the resolution of your third monitor, example [1920x1080, 1280x720]"
            read resolution3

            # Update resolution and refresh rate for third monitor
            for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
                sed -i "s/${monitor3}, 1920x1080@60/${monitor3}, ${resolution3}@${refresh3}/" "$theme_path"
            done

            # Position third monitor to the right of main monitor
            for theme_path in ./hypr/hyprland.conf ./themes/themes/*/hypr/hyprland.conf; do
                sed -i "s/${monitor3}, ${resolution3}@${refresh3}, 0x0/${monitor3}, ${resolution3}@${refresh3}, ${orientation}x0/" "$theme_path"
            done
        fi
    fi
else
    echo "When you log on hyprland, run this script again to set you monitor and refresh rate" 
    sleep 4   
fi
clear
ifconfig
echo "Type your network interface name, example: (wlan0/eth0/enp3s0) "
read interface
sed -i "s/wlan0/$interface/" ./waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/blue/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/dawn/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/green/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/lavender/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/mauve/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/moon/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/peach/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/pink/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/red/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/sapphire/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/tokyo-night/waybar/config.jsonc &>/dev/null
sed -i "s/wlan0/$interface/" ./themes/themes/yellow/waybar/config.jsonc &>/dev/null
clear  
cp -r ./fastfetch ./hypr ./kitty ./rofi ./waybar -t ~/.config
cp -r ./themes -t ~/Documents/
sudo cp -r ./cursor/hypr-dots -t /usr/share/icons/ 
sudo cp -r ./gtkthemes/* -t /usr/share/themes/ 
cp -r ./.zshrc ./.p10k.zsh -t ~/
swww init &> /dev/null
swww img ~/.config/hypr/wallpaper.jpg &> /dev/null
killall waybar &> /dev/null
waybar &> /dev/null &
cd ..
rm -rf hypr-dots
hyprctl setcursor hypr-dots 24
sudo chmod -R 777 /usr/share/themes
sudo chmod -R 777 /usr/share/icons
sudo chmod -R 777 /usr/bin/papirus-folders
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' &> /dev/null
gsettings set org.gnome.desktop.interface gtk-theme "hypr-dots-mauve" &> /dev/null
gsettings set org.gnome.desktop.interface cursor-theme 'hypr-dots' &> /dev/null
papirus-folders -C cat-mocha-mauve &> /dev/null
clear
echo "Now, let's load the Hyprland, Waybar, and Rofi themes into the theme-switcher variable for the first time."
sleep 4
echo ""
echo ""
echo -n "Select your theme in: "
sleep 1
echo -n "5 "
sleep 0.5 
echo -n "4 "
sleep 0.5
echo -n "3 "
sleep 0.5
echo -n "2 "
sleep 0.5
echo "1 "
sleep 0.5 
bash ~/Documents/themes/theme-switcher.sh &> /dev/null &
echo ""
echo ""
echo "*****************************"
echo "Press any key to continue"
echo "*****************************"
read 
clear
echo "Now, let's load the GTK theme and icons into the theme-switcher variable for the first time."
sleep 3
echo ""
echo "Select your Hyprland theme again, and then select your GTK and icons theme"
sleep 2
echo ""
echo ""
echo -n "Select your theme in: "
sleep 1
echo -n "5 "
sleep 0.5 
echo -n "4 "
sleep 0.5
echo -n "3 "
sleep 0.5
echo -n "2 "
sleep 0.5
echo  "1 "
sleep 0.5 
bash ~/Documents/themes/theme-switcher.sh &> /dev/null &
echo ""
echo ""
echo "*****************************"
echo "Press any key to continue"
echo "*****************************"
read
clear
sleep 0.2
echo -e "\033[31m     ******       ******     "
sleep 0.2
echo -e "\033[31m   **      **   **      **   "
sleep 0.2
echo -e "\033[31m **         ** **         ** "
sleep 0.2
echo -e "\033[31m**           ***           **"
sleep 0.2
echo -e "\033[31m**            *            **"
sleep 0.2
echo -e "\033[31m **                       ** "
sleep 0.2
echo -e "\033[31m   **                   **   "
sleep 0.2
echo -e "\033[31m     **               **     "
sleep 0.2
echo -e "\033[31m       **           **       "
sleep 0.2
echo -e "\033[31m         **       **         "
sleep 0.2
echo -e "\033[31m           **   **           "
sleep 0.2
echo -e "\033[31m             **             "
echo ""
echo ""
echo "" 
echo ""
echo "*****************************"
echo "Thanks for using my rice! :)"
echo "*****************************"
