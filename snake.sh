#!/bin/bash
d=310 m=-20 n=-20 f=0 b=-2 s=0 a=1 && declare -a g=() && for i in {0..400}; do g+=("."); done # initialise variables, \/ get movement from key inputs
while(true) do tput sc && export n=$(read -n1 -s -t .1 a; case $a in "w")echo -20;; "s")echo 20;; "a")echo -1;; "d")echo 1;; *)echo $n;; esac)
[[ "$(($m + $n))" != "0" ]] && m=$n                                     # prevent snake from going back on itself
[[ "$(( (($d%20)+20)%20 ))" == "0" && "${m}" == "1" ]] && d=$(($d-20))  # travel through right of screen
[[ "$(( (($d%20)+20)%20 ))" == "1" && "${m}" == "-1" ]] && d=$(($d+20)) # travel through left of screen
[[ $d -le 20 && "${m}" == "-20" ]] && d=$(($d+400)) # travel through top of screen
[[ $d -gt 380 && "${m}" == "20" ]] && d=$(($d-400)) # travel through bottom of screen
d=$(($d+$m)) && [[ "${g[d-1]}" == "O" ]] && ((b--)) && s=$(($s+1)) && a=1 # moves snake, check if apple eaten
r=$(($RANDOM % 400)) && [[ "${g[r]}" == "." && "${a}" == "1" ]] && g[$r]="O" && a=0 # spawn new apple
[[ "${g[d-1]}" != "." && "${g[d-1]}" != "O" ]] && clear && printf "Game Over. Score: $s\n" && break                          # game over
g[d-1]="s$((f++)) e" b=$(($b+1)) && for i in {0..400}; do g[i]="${g[i]/s$b e/.}" ; done && printf "               \n"           # tidy up tail
printf '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n' "${g[@]//s[0-9]* e/█}" | column -t  && printf "Score: $s      " && tput rc  # print game
done