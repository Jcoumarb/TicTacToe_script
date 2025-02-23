#!/bin/bash

#instantiation of spot values
s1=1
s2=2
s3=3
s4=4
s5=5
s6=6
s7=7
s8=8
s9=9

turn=0  #holds turn number to figure out whose turn it is
won=0 #remains 0 until there is a winner (winner is X: won = 1 || winner is O: won = 2)

board_print() {
    echo ""
    echo "- - - - - - -"
    echo "| $s1 | $s2 | $s3 |"
    echo "- - - - - - -"
    echo "| $s4 | $s5 | $s6 |"
    echo "- - - - - - -"
    echo "| $s7 | $s8 | $s9 |"
    echo "- - - - - - -"
    echo ""
}

turn() {
    #mod turn to figure out if its 'X's or '0's turn
    remainder=$((turn % 2))
    player=X
    if [[ $remainder -eq 1 ]]; then
        player=O
    fi
    
    echo "Player $player Turn:"

    #input validation logic
    valid=0
    input=1
    while ((valid == 0)); do
        read -p "Select cell: " input

        if [[ ! $input =~ ^[1-9]$ ]]; then  #ensures in is a number and that it is in range
            echo "Please enter a valid cell id (1-9)"
        elif [[ ! $(eval echo "\$s$input") =~ ^[1-9]$ ]]; then #ensures that the spot is not occupied
            echo "This spot is occupied"
        else
            eval "s$input=\"$player\"" #if both of the cases have passed then makes the spot value the 
            valid=1
        fi
    done
}

check_win() {
    #sets 'won' to 1 if player 'X' wins or to 2 if player 'O' wins

    #checks all possible win conditions
    if [[ "$s1" == "$s2" && "$s2" == "$s3" ]]; then
        if [[ "$s1" == "X" ]]; then
             won=1
        else
            won=2
        fi
    elif [[ "$s4" == "$s5" && "$s5" == "$s6" ]]; then
        if [[ "$s4" == "X" ]]; then
             won=1
        else
            won=2
        fi  
    elif [[ "$s7" == "$s8" && "$s8" == "$s9" ]]; then
        if [[ "$s7" == "X" ]]; then
             won=1
        else
            won=2
        fi
    elif [[ "$s1" == "$s4" && "$s4" == "$s7" ]]; then
        if [[ "$s1" == "X" ]]; then
             won=1
        else
            won=2
        fi
    elif [[ "$s2" == "$s5" && "$s5" == "$s8" ]]; then
        if [[ "$s2" == "X" ]]; then
             won=1
        else
            won=2
        fi
    elif [[ "$s3" == "$s6" && "$s6" == "$s9" ]]; then
        if [[ "$s3" == "X" ]]; then
             won=1
        else
            won=2
        fi
    elif [[ "$s1" == "$s5" && "$s5" == "$s9" ]]; then
        if [[ "$s1" == "X" ]]; then
             won=1
        else
            won=2
        fi
    elif [[ "$s3" == "$s5" && "$s5" == "$s7" ]]; then
        if [[ "$s3" == "X" ]]; then
             won=1
        else
            won=2
        fi
    fi
}

echo "Tic Tac Toe Game: "

#this game loop continues until there is winner or draw
while ((won == 0 && turn < 9)); do
    board_print
    turn
    check_win
    ((turn+=1))
done

board_print

#final statement based on won variable
if ((won == 0)); then
    echo "Tie!"
elif ((won == 1)); then
    echo "Player X wins!"
else 
    echo "Player O wins!"
fi

