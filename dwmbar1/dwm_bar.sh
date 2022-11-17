#!/bin/sh

LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

export IDENTIFIER="unicode"

export SEP1="["
export SEP2="]"
# Import the modules
. "$DIR/bar-functions/dwm_battery.sh"
. "$DIR/bar-functions/dwm_backlight.sh"
. "$DIR/bar-functions/dwm_pulse.sh"
. "$DIR/bar-functions/dwm_weather.sh"

parallelize() {
    while true
    do
        printf "Running parallel processes\n"
        dwm_weather &
        sleep 5
    done
}
parallelize &

# Update dwm status bar every second
while true
do
    # Append results of each func one by one to the upperbar string
    upperbar=""
    upperbar="$upperbar$(dwm_battery)"
    upperbar="$upperbar$(dwm_backlight)"
   
    # Append results of each func one by one to the lowerbar string
    lowerbar=""
    lowerbar="$lowerbar$(dwm_pulse)"
    lowerbar="$lowerbar$(__DWM_BAR_WEATHER__)"
    
    #xsetroot -name "$upperbar"
    
    # Uncomment the line below to enable the lowerbar 
    xsetroot -name "$upperbar;$lowerbar"
    sleep 1
done
