#!/bin/sh

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# colors

black=#1e222a
green=#7bb75b
white=#abb2bf
grey=#282c34
blue=#4c99d3
red=#ce3e60
yellow=#e8b32a
purple=#a57fc4
darkblue=#388dce

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$black^ ^b$green^ CPU"
  printf "^c$white^ ^b$grey^ $cpu_val"
}

pkg_updates() {
  #updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
  updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
  # updates=$({ timeout 20 aptitude search '~U' 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)

  if [ -z "$updates" ]; then
    printf "  ^c$yellow^     Fully Updated"
  else
    printf "  ^c$yellow^     $updates"" updates"
  fi
}

battery() {
  get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
  printf "^c$black^^b$green^  "
  printf "^c$green^^b$black^  $get_capacity"
}

brightness() {
  printf "^c$black^^b$red^   "
  printf "^c$red^%.0f\n" $(cat /sys/class/backlight/*/brightness)
}

mem() {
  printf "^c$blue^^b$black^  "
  printf "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$red^ 󰤨  ^d^%s" " ^c$red^Connected" ;;
	down) printf "^c$black^ ^b$red^ 󰤭  ^d^%s" " ^c$red^Disconnected" ;;
	esac
}

clock() {
	printf "^c$black^^b$darkblue^ 󰥔  "
	printf "^c$black^^b$blue^  $(date '+%H:%M')  "
}

vol() {
	printf "^c$purple^^b$black^  "
  pamixer --get-volume-human
}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  #sleep 1 && xsetroot -name "$updates $(battery) $(brightness) $(cpu) $(mem) $(wlan) $(clock)"
  sleep 1 && xsetroot -name "$updates $(battery) $(wlan) $(clock) $(vol) "
done
