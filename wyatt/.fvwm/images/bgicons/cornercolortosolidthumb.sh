#! /bin/bash
for file in *.png; do printf "$file "; convert "$file" -crop '1x1+0+0' -format "%[fx:int(255*p{10,10}.r)],%[fx:int(255*p{10,10}.g)],%[fx:int(255*p{10,10}.b)]\n" info:;done | while read -r line; do NAME="$(echo "$line" | awk '{print $1}')"; COLOR="$(rgb2hex "$(echo "$line" | awk '{print $2}'|sed 's/,/ /g'|awk '{print $1}')" "$(echo "$line" | awk '{print $2}'|sed 's/,/ /g' |awk '{print $2}')" "$(echo "$line" | awk '{print $2}'|sed 's/,/ /g' |awk '{print $3}')")"; ffmpeg -y -f lavfi -i "color=""$COLOR"":size=32x32"  "$NAME""_color"".png"; done

