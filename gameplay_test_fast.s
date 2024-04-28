#mem address 199 stores function we are in, debug info
nop
nop
nop
nop
nop
addi $sp, $r0, 0  # stack pointer is initialized to 0, increments to store stuff

# initialize motors to 50 duty cycle
addi $t0, $r0, 50
nop
nop
nop
sw $t0, 99($r0) # not a motor, but useful to have this nonzero for checking valid moves.
sw $t0, 109($r0)
sw $t0, 119($r0)
sw $t0, 129($r0)
sw $t0, 139($r0)
sw $t0, 149($r0)
sw $t0, 159($r0)
sw $t0, 169($r0)

# protect border of board.
sw $t0, 90($r0)
sw $t0, 91($r0)
sw $t0, 92($r0)
sw $t0, 93($r0)
sw $t0, 94($r0)
sw $t0, 95($r0)
sw $t0, 96($r0)
sw $t0, 97($r0)
sw $t0, 98($r0)
sw $t0, 99($r0)

sw $t0, 170($r0)
sw $t0, 171($r0)
sw $t0, 172($r0)
sw $t0, 173($r0)
sw $t0, 174($r0)
sw $t0, 175($r0)
sw $t0, 176($r0)
sw $t0, 177($r0)
sw $t0, 178($r0)
sw $t0, 179($r0)

sw $t0, 106($r0)
sw $t0, 116($r0)
sw $t0, 126($r0)
sw $t0, 136($r0)
sw $t0, 146($r0)
sw $t0, 156($r0)
sw $t0, 166($r0)


# # debugging memory
# addi $t0, $r0, 64
# nop
# nop
# nop
# sw $t0, 130($r0) 
# sw $t0, 131($r0)
# sw $t0, 132($r0) # gives 0

# jal flash_lights
# nop
# addi $a0, $r0, 192
# jal count_one_threats_fast
# sw $v0, 199($r0)
# jal wait1second
# sw $v1, 199($r0)
# jal wait1second

# sw $r0, 130($r0)
# sw $r0, 131($r0)
# sw $r0, 132($r0)
# # debug^

# #debug
# sw $t0, 131($r0)
# sw $t0, 142($r0)
# sw $t0, 153($r0) # gives 0

# jal flash_lights
# jal count_threats_fast
# sw $v0, 199($r0)
# jal wait1second
# sw $v1, 199($r0)
# jal wait1second

# sw $r0, 131($r0)
# sw $r0, 142($r0)
# sw $r0, 153($r0)
# # debug^

# #debug
# sw $t0, 130($r0)
# sw $t0, 140($r0)
# sw $t0, 150($r0) 

# jal flash_lights
# jal count_threats_fast
# sw $v0, 199($r0)
# jal wait1second
# sw $v1, 199($r0)
# jal wait1second

# sw $r0, 130($r0)
# sw $r0, 140($r0)
# sw $r0, 150($r0)
# # debug^

# #debug
# addi $t0, $r0, 1
# sw $t0, 130($r0)
# sw $t0, 140($r0)
# sw $t0, 150($r0) 

# jal flash_lights
# jal count_threats_fast # stores in v0, v1
# sw $v0, 199($r0)
# jal wait1second
# sw $v1, 199($r0)
# jal wait1second
# jal wait1second

# sw $r0, 130($r0)
# sw $r0, 140($r0)
# sw $r0, 150($r0)
# # debug^

# #debug
# addi $t0, $r0, 1
# sw $t0, 130($r0)
# sw $t0, 140($r0)
# sw $t0, 150($r0) 

# jal flash_lights
# jal count_threats_fast # stores in v0, v1
# sw $v0, 199($r0)
# jal wait1second
# sw $v1, 199($r0)
# jal wait1second
# jal wait1second

# sw $r0, 130($r0)
# sw $r0, 140($r0)
# sw $r0, 150($r0)
# # debug^
# addi $a0, $r0, 109
# jal execute_cpu_move
# addi $a0, $r0, 119
# jal execute_cpu_move
# addi $a0, $r0, 129
# jal execute_cpu_move
# addi $a0, $r0, 139
# jal execute_cpu_move
# addi $a0, $r0, 149
# jal execute_cpu_move
# addi $a0, $r0, 159
# jal execute_cpu_move
# addi $a0, $r0, 169
# jal execute_cpu_move


nop
main:        
nop
nop
nop

    # debug__
    addi $t0, $r0, 1 #debug
    sw $t0, 199($r0) #debug
    # debug^^

jal player_turn             # does not return anything. Waits for move, then instant
    ## scan
    # jal scan_horizontal #debug
    # #scan

    # jal flash_lights #debug
    # # debug__
    # jal count_threats_fast # stores in v0, v1 #debug
    # sw $v0, 199($r0) #debug
    # jal wait1second #debug
    # sw $v1, 199($r0) #debug
    # jal wait1second #debug
    # jal count_threats
    # sw $v0, 199($r0) # display human threats
    # jal wait1second
    # sw $v1, 199($r0) # display cpu threats
    # jal wait1second
    # # debug^^


    # debug__
    addi $t0, $r0, 2 #debug
    sw $t0, 199($r0) #debug
    # debug^^
jal look_for_gameover

jal wait1second  # wait so that computer doesn't move while human hand in the way, or so that nothing registers multiple times.


    # debug__
    addi $t0, $r0, 4 #debug
    sw $t0, 199($r0) #debug
    # debug^^
jal computer_turn # stalls when moving motor
jal look_for_gameover
    # jal scan #debug

j main

scan:
    sw $ra, 0($sp)
    sw $t0, 1($sp)
    addi $sp, $sp, 2

    lw $t0, 100($r0)
    sw $t0, 199($r0)
    jal wait1second  

    lw $t0, 101($r0)
    sw $t0, 199($r0) 
    jal wait1second             

    lw $t0, 102($r0)
    sw $t0, 199($r0) 
    jal wait1second             

    lw $t0, 103($r0)
    sw $t0, 199($r0)
    jal wait1second             

    lw $t0, 104($r0)
    sw $t0, 199($r0)
    jal wait1second             

    lw $t0, 105($r0)
    sw $t0, 199($r0)
    jal wait1second             
    nop
    nop

    addi $sp, $sp, -2
    lw $ra, 0($sp)
    lw $t0, 1($sp)
    jr $ra

scan_horizontal:
    sw $ra, 0($sp)
    sw $t0, 1($sp)
    addi $sp, $sp, 2

    jal flash_lights_short
    lw $t0, 100($r0)
    sw $t0, 199($r0)
    jal wait1second_short  

    jal flash_lights_short
    lw $t0, 110($r0)
    sw $t0, 199($r0) 
    jal wait1second_short             

    jal flash_lights_short
    lw $t0, 120($r0)
    sw $t0, 199($r0) 
    jal wait1second_short             

    jal flash_lights_short
    lw $t0, 130($r0)
    sw $t0, 199($r0)
    jal wait1second_short             

    jal flash_lights_short
    lw $t0, 140($r0)
    sw $t0, 199($r0)
    jal wait1second_short             

    jal flash_lights_short
    lw $t0, 150($r0)
    sw $t0, 199($r0)
    jal wait1second_short             

    jal flash_lights_short    
    lw $t0, 160($r0)
    sw $t0, 199($r0)
    jal wait1second_short
    #######
    jal flash_lights
    #######
    jal flash_lights_short
    lw $t0, 101($r0)
    sw $t0, 199($r0)
    jal wait1second_short  

    jal flash_lights_short
    lw $t0, 111($r0)
    sw $t0, 199($r0) 
    jal wait1second_short             

    jal flash_lights_short
    lw $t0, 121($r0)
    sw $t0, 199($r0) 
    jal wait1second_short             

    jal flash_lights_short
    lw $t0, 131($r0)
    sw $t0, 199($r0)
    jal wait1second_short             

    jal flash_lights_short
    lw $t0, 141($r0)
    sw $t0, 199($r0)
    jal wait1second_short             

    jal flash_lights_short
    lw $t0, 151($r0)
    sw $t0, 199($r0)
    jal wait1second_short             

    jal flash_lights_short    
    lw $t0, 161($r0)
    sw $t0, 199($r0)
    jal wait1second_short

    addi $sp, $sp, -2
    lw $t0, 1($sp)
    lw $ra, 0($sp)
    jr $ra

flash_lights:
    sw $ra, 0($sp)
    sw $t0, 1($sp)
    sw $t1, 2($sp)
    lw $t0, 199($r0) # save the debug data
    sw $t0, 3($sp)
    addi $sp, $sp, 4
    # stack

    addi $t0, $r0, 255
    sw $t0, 199($r0)
    addi $t0, $r0, 1 # the loop limit
    sll $t0, $t0, 21 # 1 million cycles
    addi $t1, $r0, 0
    flash1_loop:
        addi $t1, $t1, 1
        blt $t1, $t0, flash1_loop

    addi $t0, $r0, 0
    sw $t0, 199($r0)
    addi $t0, $r0, 1 # the loop limit
    sll $t0, $t0, 21 # 1 million cycles
    addi $t1, $r0, 0
    flash2_loop:
        addi $t1, $t1, 1
        blt $t1, $t0, flash2_loop    

    addi $t0, $r0, 255
    sw $t0, 199($r0)
    addi $t0, $r0, 1 # the loop limit
    sll $t0, $t0, 21 # 1 million cycles
    addi $t1, $r0, 0
    flash3_loop:
        addi $t1, $t1, 1
        blt $t1, $t0, flash3_loop   

    addi $t0, $r0, 0
    sw $t0, 199($r0)
    addi $t0, $r0, 1 # the loop limit
    sll $t0, $t0, 21 # 1 million cycles
    addi $t1, $r0, 0
    flash4_loop:
        addi $t1, $t1, 1
        blt $t1, $t0, flash4_loop

    # stack
    addi $sp, $sp, -4
    lw $t0, 3($sp)
    sw $t0, 199($r0) #load back the debug data
    lw $t1, 2($sp)
    lw $t0, 1($sp)
    lw $ra, 0($sp)
    jr $ra

flash_lights_short:
    sw $ra, 0($sp)
    sw $t0, 1($sp)
    sw $t1, 2($sp)
    lw $t0, 199($r0) # save the debug data
    sw $t0, 3($sp)
    addi $sp, $sp, 4
    # stack
    addi $t0, $r0, 255
    sw $t0, 199($r0)
    addi $t0, $r0, 1 # the loop limit
    sll $t0, $t0, 18 # 1 million cycles
    addi $t1, $r0, 0
    flash_lights_short_loop:
        addi $t1, $t1, 1
        blt $t1, $t0, flash_lights_short_loop
    # stack
    addi $sp, $sp, -4
    lw $t0, 3($sp)
    sw $t0, 199($r0) #load back the debug data
    lw $t1, 2($sp)
    lw $t0, 1($sp)
    lw $ra, 0($sp)
    jr $ra

end_main:
    nop
    nop
j end_main

look_for_gameover: # brings function to endmain with colors if the game is doneso columbo.
    sw $ra, 0($sp)
    addi $sp, $sp, 1
    jal check_for_win           # returns in $v0, 4 for human, 256 for cpu, 0 for no win.

    # Handle if there is a win or not
    addi $t0, $r0, 4
    addi $t1, $r0, 256
    bne $v0, $t1, no_cpu_win
        j cpu_win
    no_cpu_win:
    bne $v0, $t0, no_human_win # change r0 back to t0, and to "no_human_win"
        j human_win
    no_human_win:


    jal check_for_full_board    # returns in $v0, 1 if full
    bne $v0, $r0, draw_no_win

    addi $sp, $sp, -1
    lw $ra, 0($sp)
    jr $ra


check_for_full_board:       # returns 1 if board full in $v0, otherwise 0
    sw $ra, 0($sp)
    addi $sp, $sp, 1
    
    addi $t0, $r0, 000105
    addi $t1, $r0, 000170
    check_for_full_board_loop:
        lw $t3, 0($t0)
        bne $t3, $r0, check_for_full_board_next
            addi $v0, $r0, 0 # if there is not a piece in this column, the board is not full, so return 0
            j check_for_full_board_end 
        check_for_full_board_next:
    addi $t0, $t0, 10
    blt $t0, $t1, check_for_full_board_loop
    # loop is over, so the board is full
    addi $v0, $r0, 1
    check_for_full_board_end: 
        addi $sp, $sp, -1
        lw $ra, 0($sp)
        jr $ra

check_for_win: # returns in $v0. 0 for no win, 4 for human, 256 for cpu. Maybe about 2k cycles to run.
    sw $ra, 0($sp)
    addi $sp, $sp, 1
    

    jal check_for_column # loop through all possible positions for a column win. Returns in $v0.
    bne $v0, 0, check_for_win_gameover

    jal check_for_row 
    bne $v0, 0, check_for_win_gameover

    jal check_for_pos_diag 
    bne $v0, 0, check_for_win_gameover

    jal check_for_neg_diag
    bne $v0, 0, check_for_win_gameover

    check_for_win_end:
        addi $v0, $r0, 0
        check_for_win_gameover:

            addi $sp, $sp, -1
            lw $ra, 0($sp)
            jr $ra #v0 stores who won.


check_for_column: # loop through all possible starting positions for a column win. Return in $v0, 1 for human, 64 for cpu, 0 for none.
    sw $ra, 0($sp)
    addi $sp, $sp, 1
    
    addi $t0, $r0, 000100 # start of loop through columns
    addi $t1, $r0, 000170 # end of loop through columns
    check_for_column_loop1:

        addi $t2, $r0, 0 # loop up a column start
        addi $t3, $r0, 3 # loop up a column end (a win must start at row 2 or lower)
        check_for_column_loop2:
            add $t8, $t0, $t2 # the potential win starts at $t8.
            addi $t9, $r0, 0
            lw $t4, 0($t8)
            nop
            add $t9, $t9, $t4
            lw $t4, 1($t8)
            nop
            add $t9, $t9, $t4
            lw $t4, 2($t8)
            nop
            add $t9, $t9, $t4
            lw $t4, 3($t8)
            nop
            add $t9, $t9, $t4
            # if $t9 is 4, then the human won. If it is 256, then the computer won.
            addi $t7, $r0, 4
            bne $t9, $t7, check_for_column_human_skip
                j column_human_win
            check_for_column_human_skip:
            addi $t7, $r0, 256
            bne $t9, $t7, check_for_column_cpu_skip
                j column_cpu_win
            check_for_column_cpu_skip:
            nop

        addi $t2, $t2, 1
        blt $t2, $t3, check_for_column_loop2
        
    addi $t0, $t0, 10
    blt $t0, $t1, check_for_column_loop1

    column_no_win:
        addi $v0, $r0, 0
        j check_for_column_end
    column_human_win:
        addi $v0, $r0, 4
        j check_for_column_end
    column_cpu_win:
        addi $v0, $r0, 256
        j check_for_column_end
    check_for_column_end: 
        addi $sp, $sp, -1
        lw $ra, 0($sp)
        jr $ra

check_for_row:
    sw $ra, 0($sp)
    addi $sp, $sp, 1

    addi $t0, $r0, 000100
    addi $t1, $r0, 000140
    check_for_row_loop1:
        addi $t2, $r0, 0
        addi $t3, $r0, 6 # go through all rows
        check_for_row_loop2:
            add $t8, $t0, $t2 # potential win starts at $t8
            addi $t9, $r0, 0
            lw $t4, 0($t8)
            add $t9, $t9, $t4
            lw $t4, 10($t8)
            add $t9, $t9, $t4
            lw $t4, 20($t8)
            add $t9, $t9, $t4
            lw $t4, 30($t8)
            add $t9, $t9, $t4

            # if $t9 is 4, then the human won. If it is 256, then the computer won.
            addi $t8, $r0, 4
            bne $t9, $t8, check_for_row_human_skip
                j row_human_win
            check_for_row_human_skip:
            addi $t8, $r0, 256
            bne $t9, $t8, check_for_row_cpu_skip
                j row_cpu_win
            check_for_row_cpu_skip:
                nop

        addi $t2, $t2, 1
        blt $t2, $t3, check_for_row_loop2
    
    addi $t0, $t0, 10
    blt $t0, $t1, check_for_row_loop1

    row_no_win:
        addi $v0, $r0, 0
        j check_for_row_end
    row_human_win:
        addi $v0, $r0, 4
        j check_for_row_end
    row_cpu_win:
        addi $v0, $r0, 256
        j check_for_row_end
    check_for_row_end: 
        addi $sp, $sp, -1
        lw $ra, 0($sp)
        jr $ra

check_for_pos_diag: # check for upward sloping win
    sw $ra, 0($sp)
    addi $sp, $sp, 1

    addi $t0, $r0, 000100 # start of loop through columns
    addi $t1, $r0, 000140 # end of loop through columns
    check_for_pos_diag_loop1:

        addi $t2, $r0, 0 # loop up a column start
        addi $t3, $r0, 3 # loop up a column end (a win must start at row 2 or lower)
        check_for_pos_diag_loop2:
            add $t8, $t0, $t2 # the potential win starts at $t8.
            addi $t9, $r0, 0
            lw $t4, 0($t8)
            add $t9, $t9, $t4
            lw $t4, 11($t8)
            add $t9, $t9, $t4
            lw $t4, 22($t8)
            add $t9, $t9, $t4
            lw $t4, 33($t8)
            add $t9, $t9, $t4
            # if $t9 is 4, then the human won. If it is 256, then the computer won.
            addi $t8, $r0, 4
            bne $t9, $t8, check_for_pos_diag_human_skip
                j pos_diag_human_win
            check_for_pos_diag_human_skip:
            addi $t8, $r0, 256
            bne $t9, $t8, check_for_pos_diag_cpu_skip
                j pos_diag_cpu_win
            check_for_pos_diag_cpu_skip:
            nop

        addi $t2, $t2, 1
        blt $t2, $t3, check_for_pos_diag_loop2
        
    addi $t0, $t0, 10
    blt $t0, $t1, check_for_pos_diag_loop1

    pos_diag_no_win:
        addi $v0, $r0, 0
        j check_for_pos_diag_end
    pos_diag_human_win:
        addi $v0, $r0, 4
        j check_for_pos_diag_end
    pos_diag_cpu_win:
        addi $v0, $r0, 256
        j check_for_pos_diag_end
    check_for_pos_diag_end: 
        addi $sp, $sp, -1
        lw $ra, 0($sp)    
        jr $ra    

check_for_neg_diag:
    sw $ra, 0($sp)
    addi $sp, $sp, 1

    addi $t0, $r0, 000100 # start of loop through columns
    addi $t1, $r0, 000140 # end of loop through columns
    check_for_neg_diag_loop1:

        addi $t2, $r0, 0 # loop through rows
        addi $t3, $r0, 3 # loop through rows end
        check_for_neg_diag_loop2:
            add $t8, $t0, $t2 # the potential win starts at $t8.
            addi $t9, $r0, 0
            lw $t4, 3($t8)
            add $t9, $t9, $t4
            lw $t4, 12($t8)
            add $t9, $t9, $t4
            lw $t4, 21($t8)
            add $t9, $t9, $t4
            lw $t4, 30($t8)
            add $t9, $t9, $t4
            # if $t9 is 4, then the human won. If it is 256, then the computer won.
            addi $t8, $r0, 4
            bne $t9, $t8, check_for_neg_diag_human_skip
                j neg_diag_human_win
            check_for_neg_diag_human_skip:
            addi $t8, $r0, 256
            bne $t9, $t8, check_for_neg_diag_cpu_skip
                j neg_diag_cpu_win
            check_for_neg_diag_cpu_skip:
            nop

        addi $t2, $t2, 1
        blt $t2, $t3, check_for_neg_diag_loop2
        
    addi $t0, $t0, 10
    blt $t0, $t1, check_for_neg_diag_loop1

    neg_diag_no_win:
        addi $v0, $r0, 0
        j check_for_neg_diag_end
    neg_diag_human_win:
        addi $v0, $r0, 4 
        j check_for_neg_diag_end
    neg_diag_cpu_win:
        addi $v0, $r0, 256
        j check_for_neg_diag_end
    check_for_neg_diag_end: 
        addi $sp, $sp, -1
        lw $ra, 0($sp)
        jr $ra 
    

wait1second: # wait about a second, but don't mess with any registers.
    sw $ra, 0($sp)
    sw $t0, 1($sp)
    sw $t1, 2($sp)
    addi $sp, $sp, 3


    addi $t0, $r0, 3 # the loop limit
    sll $t0, $t0, 21 # 4 million cycles
    addi $t1, $r0, 0
    wait1second_loop:
        addi $t1, $t1, 1
        blt $t1, $t0, wait1second_loop

    addi $sp, $sp, -3
    lw $t1, 2($sp)
    lw $t0, 1($sp)
    lw $ra, 0($sp)
    jr $ra

wait1second_short: # wait about a second, but don't mess with any registers.
    sw $ra, 0($sp)
    sw $t0, 1($sp)
    sw $t1, 2($sp)
    addi $sp, $sp, 3


    addi $t0, $r0, 1 # the loop limit
    sll $t0, $t0, 21 # 4 million cycles
    addi $t1, $r0, 0
    wait1second_short_loop:
        addi $t1, $t1, 1
        blt $t1, $t0, wait1second_short_loop

    addi $sp, $sp, -3
    lw $t1, 2($sp)
    lw $t0, 1($sp)
    lw $ra, 0($sp)
    jr $ra

computer_turn:
    sw $ra, 0($sp)
    addi $sp, $sp, 1

    # jal choose_move # chosen move (motor address) stored in $v0

    # addi $a0, $v0, 0

    # # display chosen move.
    # sw $v0, 199($r0)
    # jal wait1second
    # # display chosen move.


    # jal execute_cpu_move # motor to be moved is stored in $a0
    addi $a0, $r0, 6 # depth assignment
    addi $a1, $r0, 1 # is maximizing player
    addi $a2, $r0, 1
    sll $a2, $a2, 31 # alpha is negative infty
    addi $a3, $r0, 1
    sll $a3, $a3, 30 #beta is positive infty


        jal flash_lights #debug
    jal minimax # chosen move (motor address) stored in v1
        # jal flash_lights
    addi $a0, $v1, 0

        # display chosen move.
        sw $v0, 199($r0) # display minimax value #debug
        jal wait1second #debug
        sw $a0, 199($r0) # display chosen move #debug
        jal wait1second #debug
        # display chosen move.

    jal execute_cpu_move # motor to be moved is stored in $a0

    addi $sp, $sp, -1
    lw $ra, 0($sp)
    jr $ra
    
choose_move: # returns motor address of first open column. TODO pick a better move lol
    sw $ra, 0($sp)
    addi $sp, $sp, 1

    addi $t0, $r0, 000105
    addi $t1, $r0, 000170
    choose_move_loop1:
        lw $t3, 0($t0)
        bne $t3, $r0, choose_move_next # if there is not a piece in this column, return address of motor to be moved
            addi $v0, $t0, 4 
            j choose_move_end 
        choose_move_next:
    addi $t0, $t0, 10
    blt $t0, $t1, choose_move_loop1

    # we assume there is some available spot. (full boards are checked elsewhere)
    choose_move_end: 
        addi $sp, $sp, -1
        lw $ra, 0($sp)
        jr $ra

execute_cpu_move: # move the motor at address $a0, and update memory
    sw $ra, 0($sp)
    addi $sp, $sp, 1

    addi $t0, $r0, 35 # 80 duty cycle
    nop
    nop
    nop
    sw $t0, 0($a0) # start motor
    jal wait1second  # let the motor run for a moment
    # jal wait1second


    addi $t0, $r0, 65
    nop
    nop
    sw $t0, 0($a0) # start motor in other direction
    jal wait1second  # let the motor run for 1 second
    # jal wait1second


    addi $t0, $r0, 50 # 50 duty cycle
    sw $t0, 0($a0) # stop motor

    update_cpu_memory:
        addi $t0, $a0, -9 # start at the motor address -9 (the first board address in this column)
        update_cpu_memory_loop:
            lw $t1, 0($t0) # check the piece memory location $t0
        addi $t0, $t0, 1
        bne $t1, $r0, update_cpu_memory_loop
        addi $t3, $r0, 64 # store 64 in the first 0 position
        sw $t3, -1($t0) # (note the -1 because we add to address after loading)

        # display chosen address.
        addi $t0, $t0, -1 #debug
        sw $t0, 199($r0) #debug
        jal wait1second #debug
        # display chosen address.

    addi $sp, $sp, -1
    lw $ra, 0($sp)  
    jr $ra

player_turn: # waits for player move and updates memory
    sw $ra, 0($sp)
    addi $sp, $sp, 1

    
    wait_for_player: # until column sensor sees a 1, loop. Wait for player move.
        addi $t1, $r0, 000108 # bottom of loop
        addi $t2, $r0, 000178 # top of loop
        wait_for_player_inner_loop:
            lw $t0, 0($t1) #load column A sensor into $t0
            bne $t0, $r0, update_player_memory # if it senses something, break.
        addi $t1, $t1, 10
        blt $t1, $t2, wait_for_player_inner_loop
        j wait_for_player # nothing is ready, go back to wait

    update_player_memory:
        # # debug__
        sw $t1, 199($r0) #debug
        jal wait1second #debug
        # # debug^^

        addi $t0, $t1, -8 # start at the sensor address -8
        update_player_memory_loop:
            lw $t1, 0($t0) # check the piece memory location $t0
        addi $t0, $t0, 1
        bne $t1, $r0, update_player_memory_loop
        addi $t3, $r0, 1 # store 1 in the first 0 position
        sw $t3, -1($t0) # (note the -1 because we add to address after loading)
    
    addi $sp, $sp, -1
    lw $ra, 0($sp)
    jr $ra


cpu_win:
    addi $t0, $r0, 1988
    sw $t0, 199($r0)
    j end_main
human_win:
    addi $t0, $r0, 1974
    sw $t0, 199($r0)
    j end_main
draw_no_win:
    addi $t0, $r0, 255
    sw $t0, 199($r0)
    j end_main




# strategy-----------------------------------------------
# strategy-----------------------------------------------
# strategy-----------------------------------------------
# strategy-----------------------------------------------
# strategy-----------------------------------------------
# strategy-----------------------------------------------
# strategy-----------------------------------------------
# strategy-----------------------------------------------
# strategy-----------------------------------------------
# strategy-----------------------------------------------

count_threats: # returns in v0 the number of human threats (double counting odd threats) and in v1 the number of cpu threats (double counting even threats)

    sw $s0, 0($sp) # loop variable
    sw $s1, 1($sp) # loop variable
    sw $s2, 2($sp) # loop variable
    sw $s3, 3($sp) # loop variable
    sw $s4, 4($sp) # memory location of threat
    sw $s5, 5($sp) # threat tested (4 or 256)
    sw $s6, 6($sp) # number of human threats
    sw $s7, 7($sp) # number of cpu threats
    sw $ra, 8($sp)
    addi $sp, $sp, 9
    #### stack

    addi $s6, $r0, 0 # initialize running counters to 0
    addi $s7, $r0, 0

    addi $s0, $r0, 000100 # start of loop through columns
    addi $s1, $r0, 000170 # end of loop through columns
    count_threats_loop1:

        addi $s2, $r0, 0 # start of loop through rows
        addi $s3, $r0, 6 # end of loop through rows
        count_threats_loop2:
            add $s4, $s0, $s2 # look at memory address $s4
            lw $t0, 0($s4)
            blt $r0, $t0, count_threats_nonempty # if mem>0 then it is nonempty, and we cannot try putting a piece there.

            count_threats_empty:
                check_human_threat:
                    # try filling with human and see if there is a win.
                    addi $s5, $r0, 1
                    sw $s5, 0($s4) # place test token in the board
                    jal check_for_win # returns in v0, 4 if human win
                    addi $t0, $r0, 4
                    bne $t0, $v0, check_cpu_threat # if non4, there is no human threat.
                    # j check_cpu_threat
                    human_threat:
                        addi $t1, $r0, 1
                        and $t0, $s4, $t1 # $t0 is parity of address
                        bne $t0, $r0, human_odd_threat
                        human_even_threat: # an odd threat in connect 4 lingo, but even in memory.
                            addi $s6, $s6, 2 #increment
                            j check_cpu_threat
                        human_odd_threat:
                            addi $s6, $s6, 1
                    
                check_cpu_threat:
                    # try filling with cpu and seeing if there is a win.
                    addi $s5, $r0, 64
                    sw $s5, 0($s4)
                    jal check_for_win # returns in v0, 256 if cpu win.
                    addi $t0, $r0, 256
                    bne $t0, $v0, restore_threat_memory # if nonzero, there is a win and it must be a cpu win.
                    # j restore_threat_memory
                    cpu_threat:
                        and $t0, $s4, 1 # $t0 is parity of address
                        bne $t0, $r0, human_odd_threat
                        cpu_even_threat:
                            addi $s7, $s7, 1
                            j restore_threat_memory
                        cpu_odd_threat:
                            addi $s7, $s7, 2
                restore_threat_memory:
                    sw $r0, 0($s4)
            count_threats_nonempty:
            
        addi $s2, $s2, 1
        blt $s2, $s3, count_threats_loop2
        
    addi $s0, $s0, 10
    blt $s0, $s1, count_threats_loop1


    count_threats_end:
    addi $v0, $s6, 0
    addi $v1, $s7, 0
    #### stack
    addi $sp, $sp, -9
    lw $s0, 0($sp)
    lw $s1, 1($sp)
    lw $s2, 2($sp)
    lw $s3, 3($sp)
    lw $s4, 4($sp)
    lw $s5, 5($sp)
    lw $s6, 6($sp)
    lw $s7, 7($sp)
    lw $ra, 8($sp)
    jr $ra #v0 stores who won.

heuristic: # Output value to $v0 is strength of the gameboard for cpu player (player 2)
    sw $s0, 0($sp) # heuristic value
    sw $ra, 1($sp)
    addi $sp, $sp, 2
    #### stack
    addi $s0, $r0, 0 # initialize heuristic


    jal check_for_win # returns in $v0 4 or 256
    addi $t0, $r0, 256
    bne $v0, $t0, heuristic_no_cpu_win 
        addi $s0, $s0, 2000 # if cpu is in winning state, add to heuristic
    heuristic_no_cpu_win:
    addi $t0, $r0, 4
    bne $v0, $t0, heuristic_no_human_win
        addi $s0, $s0, -2000 # if human is in winning state, add to heuristic
    heuristic_no_human_win:
    jal count_threats_fast # v0 = human threats, v1 = cpu threats
    sub $s0, $s0, $v0 # subtract off human threats
    add $s0, $s0, $v1 # add cpu threats

    sll $s0, $s0, 4 # make threats 8 times more valuable than priority squares

    jal count_priority_spaces # computes prio(cpu) - prio(human), returns in $v0
    add $s0, $s0, $v0
    

    heuristic_end:
    addi $v0, $s0, 0 # store heuristic into $v0
    addi $sp, $sp, -2
    lw $s0, 0($sp)
    lw $ra, 1($sp)
    jr $ra 

minimax: # $a0 stores depth, $a1 stores isMaximizingPlayer (isCPU), $a2 stores alpha, $a3 stores beta. Returns in $v0 the value of the board for CPU, and $v1 is the motor address of the best move.
    sw $s0, 0($sp) # loop variable
    sw $s1, 1($sp) # loop variable
    sw $s2, 2($sp) # loop variable
    sw $s3, 3($sp) # loop variable
    sw $s4, 4($sp) # memory location of testmove.
    sw $s5, 5($sp) # min/maxing value
    sw $s6, 6($sp) # best move
    sw $ra, 7($sp)
    addi $sp, $sp, 8
    #### stack

    # if depth = 0, just return the heuristic.
    bne $a0, $r0, minimax_nonzero_depth
        j minimax_no_possible_moves # if depth == 0, just pretend you have no moves and go on.
    minimax_nonzero_depth: 
    # if board full or game already over, just return heuristic. TODO

    # save $a0 and $a1, and call check_for_win, check_for_full_board
    sw $a0, 0($sp)
    sw $a1, 1($sp)
    sw $a2, 2($sp)
    sw $a3, 3($sp)
    addi $sp, $sp, 4
    jal check_for_win # returns winner value in v0
    addi $sp, $sp, -4
    lw $a0, 0($sp)
    lw $a1, 1($sp)
    lw $a2, 2($sp)
    lw $a3, 3($sp)

    bne $v0, $r0, minimax_no_possible_moves

    sw $a0, 0($sp)
    sw $a1, 1($sp)
    sw $a2, 2($sp)
    sw $a3, 3($sp)
    addi $sp, $sp, 4
    jal check_for_full_board # v0 is 1 if board full
    addi $sp, $sp, -4
    lw $a0, 0($sp)
    lw $a1, 1($sp)
    lw $a2, 2($sp)
    lw $a3, 3($sp) 

    bne $v0, $r0, minimax_no_possible_moves

    j minimax_possible_moves

    minimax_no_possible_moves:
    jal heuristic # stores heuristic vlaue in $v0
    j minimax_end # return the heuristic

    minimax_possible_moves:

    bne $a1, $r0, minimax_isCPU # check if isCPU is true, and if so jump to that section
    minimax_notCPU: # here, isCPU is false.
        addi $s5, $r0, 1
        sll $s5, $s5, 30 # set $s5 to large positive number. We are looking for smallest recursive score.

        addi $s0, $r0, 000100 # start of loop through columns
        addi $s1, $r0, 000170 # end of loop through columns
        minimax_notCPU_loop1:

            addi $s2, $r0, 0 # start of loop through rows
            addi $s3, $r0, 6 # end of loop through rows
            minimax_notCPU_loop2:
                add $s4, $s0, $s2
                lw $t0, 0($s4) # check if mem is empty and below is full
                lw $t1, -1($s4)
                bne $t0, $r0, minimax_notCPU_invalid # if mem(s4) not empty, cannot play there
                bne $t1, $r0, minimax_notCPU_valid
                j minimax_notCPU_invalid
                minimax_notCPU_valid:
                # here, we have a valid move. Store the potential move, set arguments of function, save variables, and recurse.
                    addi $t0, $r0, 1
                    sw $t0, 0($s4) # store the test value in memory (human move)
                    # save arguments
                    sw $a0, 0($sp)
                    sw $a1, 1($sp)
                    sw $a2, 2($sp)
                    sw $a3, 3($sp)
                    addi $sp, $sp, 4
                    addi $a0, $a0, -1 #decrement depth
                    addi $a1, $r0, 1 # set isCPU to 1.
                    # call minimax on the updated arguments
                    jal minimax # returns value in v0
                    addi $sp, $sp, -4 # restore unchanged arguments
                    lw $a0, 0($sp)
                    lw $a1, 1($sp)
                    lw $a2, 2($sp)
                    lw $a3, 3($sp)

                    sw $r0, 0($s4) # restore memory to be empty
                    blt $s5, $v0, minimax_notCPU_invalid # if test val is greater, do not update or do pruning checks. 
                        add $s5, $r0, $v0 #update val to be tetstval
                        # addi $s6, $s0, 9 # update best move 
                        blt $s5, $a2, minimax_end # if value < alpha, break
                        add $a3, $r0, $s5 # set beta = val, since val decreased, i.e. beta = min(beta, value)
                    

                minimax_notCPU_invalid:
            addi $s2, $s2, 1
            blt $s2, $s3, minimax_notCPU_loop2
            
        addi $s0, $s0, 10
        blt $s0, $s1, minimax_notCPU_loop1
    addi $v0, $s5, 0
    addi $v1, $s6, 0
    j minimax_end

    minimax_isCPU: # here, isCPU is true.
        addi $s5, $r0, 1
        sll $s5, $s5, 31 # set $s5 to large negative number

        addi $s0, $r0, 000100 # start of loop through columns
        addi $s1, $r0, 000170 # end of loop through columns
        minimax_isCPU_loop1:

            addi $s2, $r0, 0 # start of loop through rows
            addi $s3, $r0, 6 # end of loop through rows
            minimax_isCPU_loop2:
                add $s4, $s0, $s2
                lw $t0, 0($s4) # check if mem is empty and below is full
                lw $t1, -1($s4)
                bne $t0, $r0, minimax_isCPU_invalid # if mem full, not a valid move
                bne $t1, $r0, minimax_isCPU_valid # if mem below full and mem empty, valid move
                j minimax_isCPU_invalid
                minimax_isCPU_valid:
                # here, we have a valid move. Store the potential move, set arguments of function, save variables, and recurse.
                    addi $t0, $r0, 64
                    sw $t0, 0($s4)
                    # save arguments
                    sw $a0, 0($sp)
                    sw $a1, 1($sp)
                    sw $a2, 2($sp)
                    sw $a3, 3($sp)
                    addi $sp, $sp, 4
                    addi $a0, $a0, -1 #decrement depth
                    addi $a1, $r0, 0 # set isCPU to 0.
                    #save $a0 and $a1, and call minimax
                    
                    jal minimax # returns value in v0, v1 is move
                    addi $sp, $sp, -4
                    lw $a0, 0($sp)
                    lw $a1, 1($sp)
                    lw $a2, 2($sp)
                    lw $a3, 3($sp)
                    # restore unchanged arguments
                        # sw $v0, 199($r0) #debug
                        # jal wait1second #debug
                    sw $r0, 0($s4) # restore memory to be empty
                    blt $v0, $s5, minimax_isCPU_invalid # if test val is smaller, do not update. 
                        addi $s5, $v0, 0 #update val to be tetstval
                        addi $s6, $s0, 9 # update best move
                        blt $a3, $s5, minimax_end # if beta < val, break
                        addi $a2, $s5, 0 # update alpha to be new value
                    # can be optimized here by not considering the rest of the column.
                minimax_isCPU_invalid:
            addi $s2, $s2, 1
            blt $s2, $s3, minimax_isCPU_loop2
            
        addi $s0, $s0, 10
        blt $s0, $s1, minimax_isCPU_loop1
    addi $v0, $s5, 0
    addi $v1, $s6, 0
    # j minimax_end

    minimax_end:
    
    #### stack
    addi $sp, $sp, -8
    lw $s0, 0($sp)
    lw $s1, 1($sp)
    lw $s2, 2($sp)
    lw $s3, 3($sp)
    lw $s4, 4($sp)
    lw $s5, 5($sp)
    lw $s6, 6($sp) 
    lw $ra, 7($sp)
    jr $ra 

count_priority_spaces: # in $v0, returns number(cpu pieces in middle) - numbers(human pieces in middle)
    sw $ra, 0($sp)
    addi $sp, $sp, 1
    # stack

    addi $v0, $r0, 0 # initialize counter
    # list of priority spaces (just the middle col)
    lw $t0, 130($r0)
    add $v0, $v0, $t0
    lw $t0, 131($r0)
    add $v0, $v0, $t0
    lw $t0, 132($r0)
    add $v0, $v0, $t0
    lw $t0, 133($r0)
    add $v0, $v0, $t0
    lw $t0, 134($r0)
    add $v0, $v0, $t0
    lw $t0, 135($r0)
    add $v0, $v0, $t0

    addi $t1, $r0, 15 # makes $t1 a bit mask of bottom 15 bits
    and $t2, $t1, $v0 # t2 stores bottom 3 bits of v0. This is just the human count
    sra $v0, $v0, 6 # push out the human, now cpu spots are there
    sub $v0, $v0, $t2

    # stack
    addi $sp, $sp, -1
    lw $ra, 0($sp)
    jr $ra

count_threats_fast: # messes with a0-a2
    sw $ra, 0($sp)
    addi $sp, $sp,  1
    # stack

    addi $v0, $r0, 0 # initialize running output counters to 0
    addi $v1, $r0, 0

    addi $t8, $r0, 3 # this reg will just always be 3
    addi $t9, $r0, 192 # this reg will just always be 192
    addi $t0, $r0, 000100 # start of loop through columns
    addi $t1, $r0, 000170 # end of loop through columns
    count_threats_fast_loop1:

        addi $t2, $r0, 0 # start of loop through rows
        addi $t3, $r0, 6 # end of loop through rows
        count_threats_fast_loop2:
            add $t4, $t0, $t2 # t4 will be checked threat address
            lw $t5, 0($t4)
            bne $t5, $r0, count_threats_fast_nonempty # if mem address is full, there cannot be a threat there.
            count_threats_fast_empty:
                addi $a0, $r0, 0 # is this point a human threat?
                addi $a1, $r0, 0 # is this point a cpu threat?
                addi $a2, $r0, 0 # is it both

                check_row_threat: 
                    addi $t5, $r0, 0 # initialize the sum of the 4 we are using.

                    lw $t6, 0($t4)
                    add $t5, $t5, $t6
                    lw $t6, 10($t4)
                    add $t5, $t5, $t6
                    lw $t6, 20($t4)
                    add $t5, $t5, $t6                    
                    lw $t6, 30($t4)
                    add $t5, $t5, $t6

                    bne $a0, $r0, count_threats_fast_no_row1_human
                    bne $t5, $t8, count_threats_fast_no_row1_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now if spot is both human and cpu threat.
                    count_threats_fast_no_row1_human:

                    bne $a1, $r0, count_threats_fast_no_row1_cpu
                    bne $t5, $t9, count_threats_fast_no_row1_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_row1_cpu:

                    lw $t6, 30($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -10($t4)
                    add $t5, $t5, $t6 #shift the 4inarow we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_row2_human
                    bne $t5, $t8, count_threats_fast_no_row2_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_row2_human:

                    bne $a1, $r0, count_threats_fast_no_row2_cpu
                    bne $t5, $t9, count_threats_fast_no_row2_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_row2_cpu:

                    lw $t6, 20($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -20($t4)
                    add $t5, $t5, $t6 #shift the 4inarow we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_row3_human
                    bne $t5, $t8, count_threats_fast_no_row3_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_row3_human:

                    bne $a1, $r0, count_threats_fast_no_row3_cpu
                    bne $t5, $t9, count_threats_fast_no_row3_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_row3_cpu:

                    lw $t6, 10($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -30($t4)
                    add $t5, $t5, $t6 #shift the 4inarow we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_row4_human
                    bne $t5, $t8, count_threats_fast_no_row4_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_row4_human:

                    bne $a1, $r0, count_threats_fast_no_row4_cpu
                    bne $t5, $t9, count_threats_fast_no_row4_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_row4_cpu:

                check_row_threat_skip:

                # addi $t6, $r0, 2
                # blt $t6, $t2, check_col_threat_skip
                check_col_threat: 
                    addi $t5, $r0, 0

                    lw $t6, 0($t4)
                    add $t5, $t5, $t6
                    lw $t6, 1($t4)
                    add $t5, $t5, $t6
                    lw $t6, 2($t4)
                    add $t5, $t5, $t6                    
                    lw $t6, 3($t4)
                    add $t5, $t5, $t6
                    
                    bne $a0, $r0, count_threats_fast_no_col1_human
                    bne $t5, $t8, count_threats_fast_no_col1_human # is t5 == 3?
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_col1_human:

                    bne $a1, $r0, count_threats_fast_no_col1_cpu
                    bne $t5, $t9, count_threats_fast_no_col1_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_col1_cpu:

                    lw $t6, 3($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -1($t4)
                    add $t5, $t5, $t6 #shift the 4inacol we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_col2_human
                    bne $t5, $t8, count_threats_fast_no_col2_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_col2_human:

                    bne $a1, $r0, count_threats_fast_no_col2_cpu
                    bne $t5, $t9, count_threats_fast_no_col2_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_col2_cpu:

                    lw $t6, 2($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -2($t4)
                    add $t5, $t5, $t6 #shift the 4inacol we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_col3_human
                    bne $t5, $t8, count_threats_fast_no_col3_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_col3_human:

                    bne $a1, $r0, count_threats_fast_no_col3_cpu
                    bne $t5, $t9, count_threats_fast_no_col3_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_col3_cpu:

                    lw $t6, 1($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -3($t4)
                    add $t5, $t5, $t6 #shift the 4inacol we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_col4_human
                    bne $t5, $t8, count_threats_fast_no_col4_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_col4_human:

                    bne $a1, $r0, count_threats_fast_no_col4_cpu
                    bne $t5, $t9, count_threats_fast_no_col4_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_col4_cpu:
                check_col_threat_skip:

                # addi $t6, $r0, 2
                # addi $t5, $r0, 135
                # blt $t6, $t2, check_pos_diag_threat_skip
                # blt $t5, $t0, check_pos_diag_threat_skip

                check_pos_diag_threat: 
                    addi $t5, $r0, 0
                    
                    lw $t6, 0($t4)
                    add $t5, $t5, $t6
                    lw $t6, 11($t4)
                    add $t5, $t5, $t6
                    lw $t6, 22($t4)
                    add $t5, $t5, $t6                    
                    lw $t6, 33($t4)
                    add $t5, $t5, $t6

                    bne $a0, $r0, count_threats_fast_no_pos_diag1_human
                    bne $t5, $t8, count_threats_fast_no_pos_diag1_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_pos_diag1_human:

                    bne $a1, $r0, count_threats_fast_no_pos_diag1_cpu
                    bne $t5, $t9, count_threats_fast_no_pos_diag1_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_pos_diag1_cpu:

                    lw $t6, 33($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -11($t4)
                    add $t5, $t5, $t6 #shift the 4inapos_diag we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_pos_diag2_human
                    bne $t5, $t8, count_threats_fast_no_pos_diag2_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_pos_diag2_human:

                    bne $a1, $r0, count_threats_fast_no_pos_diag2_cpu
                    bne $t5, $t9, count_threats_fast_no_pos_diag2_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_pos_diag2_cpu:

                    lw $t6, 22($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -22($t4)
                    add $t5, $t5, $t6 #shift the 4inapos_diag we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_pos_diag3_human
                    bne $t5, $t8, count_threats_fast_no_pos_diag3_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_pos_diag3_human:

                    bne $a1, $r0, count_threats_fast_no_pos_diag3_cpu
                    bne $t5, $t9, count_threats_fast_no_pos_diag3_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_pos_diag3_cpu:

                    lw $t6, 11($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -33($t4)
                    add $t5, $t5, $t6 #shift the 4inapos_diag we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_pos_diag4_human
                    bne $t5, $t8, count_threats_fast_no_pos_diag4_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_pos_diag4_human:

                    bne $a1, $r0, count_threats_fast_no_pos_diag4_cpu
                    bne $t5, $t9, count_threats_fast_no_pos_diag4_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_pos_diag4_cpu:
                check_pos_diag_threat_skip:


                # addi $t6, $r0, 3
                # addi $t5, $r0, 135
                # blt $t2, $t6, check_neg_diag_threat_skip
                # blt $t5, $t0, check_neg_diag_threat_skip

                check_neg_diag_threat: 
                    addi $t5, $r0, 0

                    lw $t6, 0($t4)
                    add $t5, $t5, $t6
                    lw $t6, 9($t4)
                    add $t5, $t5, $t6
                    lw $t6, 18($t4)
                    add $t5, $t5, $t6                    
                    lw $t6, 27($t4)
                    add $t5, $t5, $t6

                    bne $a0, $r0, count_threats_fast_no_neg_diag1_human
                    bne $t5, $t8, count_threats_fast_no_neg_diag1_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_neg_diag1_human:

                    bne $a1, $r0, count_threats_fast_no_neg_diag1_cpu
                    bne $t5, $t9, count_threats_fast_no_neg_diag1_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty
                    count_threats_fast_no_neg_diag1_cpu:

                    lw $t6, 27($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -9($t4)
                    add $t5, $t5, $t6 #shift the 4inaneg_diag we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_neg_diag2_human
                    bne $t5, $t8, count_threats_fast_no_neg_diag2_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_neg_diag2_human:

                    bne $a1, $r0, count_threats_fast_no_neg_diag2_cpu
                    bne $t5, $t9, count_threats_fast_no_neg_diag2_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty
                    count_threats_fast_no_neg_diag2_cpu:

                    lw $t6, 18($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -18($t4)
                    add $t5, $t5, $t6 #shift the 4inaneg_diag we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_neg_diag3_human
                    bne $t5, $t8, count_threats_fast_no_neg_diag3_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_neg_diag3_human:

                    bne $a1, $r0, count_threats_fast_no_neg_diag3_cpu
                    bne $t5, $t9, count_threats_fast_no_neg_diag3_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty
                    count_threats_fast_no_neg_diag3_cpu:

                    lw $t6, 9($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -27($t4)
                    add $t5, $t5, $t6 #shift the 4inaneg_diag we look at left by 1

                    bne $a0, $r0, count_threats_fast_no_neg_diag4_human
                    bne $t5, $t8, count_threats_fast_no_neg_diag4_human
                        addi $v0, $v0, 2
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        sub $v0, $v0, $t7
                        addi $a0, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty # we can be done looking now
                    count_threats_fast_no_neg_diag4_human:

                    bne $a1, $r0, count_threats_fast_no_neg_diag4_cpu
                    bne $t5, $t9, count_threats_fast_no_neg_diag4_cpu
                        addi $v1, $v1, 1
                        addi $t7, $r0, 1
                        and $t7, $t7, $t4
                        add $v1, $v1, $t7
                        addi $a1, $r0, 1
                        and $a2, $a0, $a1
                        bne $a2, $r0, count_threats_fast_nonempty
                     
                    count_threats_fast_no_neg_diag4_cpu:
                check_neg_diag_threat_skip:

            count_threats_fast_nonempty:
        addi $t2, $t2, 1
        blt $t2, $t3, count_threats_fast_loop2
        
    addi $t0, $t0, 10
    blt $t0, $t1, count_threats_fast_loop1

    # stack
    addi $sp, $sp,  -1
    lw $ra, 0($sp)
    jr $ra

    
    


# minimax_fast: # $a0 stores depth, $a1 stores isMaximizingPlayer (isCPU), $a2 stores alpha, $a3 stores beta. Returns in $v0 the value of the board for CPU, and $v1 is the motor address of the best move.
#     # if depth = 0, just return the heuristic.
#     bne $a0, $r0, minimax_fast_nonzero_depth
#         jal heuristic # doesn't touch arguments
#         jr $ra
#     minimax_fast_nonzero_depth:
#         jal check_for_win # returns winner value in v0, doesn't touch arguments
#         bne $v0, $r0, minimax_fast_no_possible_moves
#         jal check_for_full_board # v0 is 1 if board full, doesn't touch arguments
#         bne $v0, $r0, minimax_fast_no_possible_moves

#     minimax_fast_possible_moves:
#     sw $s0, 0($sp) # loop variable
#     sw $s1, 1($sp) # loop variable
#     sw $s2, 2($sp) # loop variable
#     sw $s3, 3($sp) # loop variable
#     sw $s4, 4($sp) # memory location of testmove.
#     sw $s5, 5($sp) # min/maxing value
#     sw $s6, 6($sp) # best move
#     sw $ra, 7($sp)
#     addi $sp, $sp, 8
#     #### stack

#     bne $a1, $r0, minimax_fast_isCPU # check if isCPU is true, and if so jump to that section
#     minimax_fast_notCPU: # here, isCPU is false.
#         addi $s5, $r0, 65535 # set s5 to a large positive number

#         addi $s0, $r0, 000100 # start of loop through columns
#         addi $s1, $r0, 000170 # end of loop through columns
#         minimax_fast_notCPU_loop1:

#             addi $s2, $r0, 0 # start of loop through rows
#             addi $s3, $r0, 6 # end of loop through rows
#             minimax_fast_notCPU_loop2:
#                 add $s4, $s0, $s2
#                 lw $t0, 0($s4) # check if mem is empty and below is full
#                 lw $t1, -1($s4)
#                 bne $t0, $r0, minimax_fast_notCPU_invalid # if mem(s4) not empty, cannot play there
#                 bne $t1, $r0, minimax_fast_notCPU_valid
#                     j minimax_fast_notCPU_invalid # mem below is empty
#                 minimax_fast_notCPU_valid:
                    
#                 # here, we have a valid move. Store the potential move, set arguments of function, save variables, and recurse.
#                     addi $t0, $r0, 1
#                     sw $t0, 0($s4) # store the test value in memory (human move)
#                     addi $s2, $s2, 100 # ensure we don't continue looking in this column
                    
#                     # save arguments
#                     sw $a0, 0($sp)
#                     sw $a1, 1($sp)
#                     sw $a2, 2($sp)
#                     sw $a3, 3($sp)
#                     addi $sp, $sp, 4
#                     addi $a0, $a0, -1 #decrement depth
#                     addi $a1, $r0, 1 # set isCPU to 1.
#                     # call minimax_fast on the updated arguments
#                     jal minimax_fast # returns value in v0
#                     addi $sp, $sp, -4 # restore unchanged arguments
#                     lw $a0, 0($sp)
#                     lw $a1, 1($sp)
#                     lw $a2, 2($sp)
#                     lw $a3, 3($sp)

#                     sw $r0, 0($s4) # restore memory to be empty
#                     blt $s5, $v0, minimax_fast_notCPU_invalid # if test val is greater, do not update or do pruning checks. 
#                         add $s5, $r0, $v0 #update val to be tetstval
#                         # addi $s6, $s0, 9 # update best move 
#                         blt $s5, $a2, minimax_fast_end # if value < alpha, break
#                         addi $a3, $s5, 0 # set beta = val, since val decreased, i.e. beta = min(beta, value)
                    

#                 minimax_fast_notCPU_invalid:
#             addi $s2, $s2, 1
#             blt $s2, $s3, minimax_fast_notCPU_loop2
            
#         addi $s0, $s0, 10
#         blt $s0, $s1, minimax_fast_notCPU_loop1
#     addi $v0, $s5, 0
#     addi $v1, $s6, 0
#     j minimax_fast_end

#     minimax_fast_isCPU: # here, isCPU is true.
#         addi $s5, $r0, -65536 # set $s5 to large negative number

#         addi $s0, $r0, 000100 # start of loop through columns
#         addi $s1, $r0, 000170 # end of loop through columns
#         minimax_fast_isCPU_loop1:

#             addi $s2, $r0, 0 # start of loop through rows
#             addi $s3, $r0, 6 # end of loop through rows
#             minimax_fast_isCPU_loop2:
#                 add $s4, $s0, $s2
#                 lw $t0, 0($s4) # check if mem is empty and below is full
#                 lw $t1, -1($s4)
#                 bne $t0, $r0, minimax_fast_isCPU_invalid # if mem full, not a valid move
#                 bne $t1, $r0, minimax_fast_isCPU_valid # if mem below full and mem empty, valid move
#                 j minimax_fast_isCPU_invalid
#                 minimax_fast_isCPU_valid:
#                 # here, we have a valid move. Store the potential move, set arguments of function, save variables, and recurse.
#                     addi $t0, $r0, 64
#                     sw $t0, 0($s4)
#                     addi $s2, $s2, 100 # ensure we don't continue looking in this column

#                     # save arguments
#                     sw $a0, 0($sp)
#                     sw $a1, 1($sp)
#                     sw $a2, 2($sp)
#                     sw $a3, 3($sp)
#                     addi $sp, $sp, 4
#                     addi $a0, $a0, -1 #decrement depth
#                     addi $a1, $r0, 0 # set isCPU to 0.
#                     #save $a0 and $a1, and call minimax_fast
                    
#                     jal minimax_fast # returns value in v0, v1 is move
#                     addi $sp, $sp, -4
#                     lw $a0, 0($sp)
#                     lw $a1, 1($sp)
#                     lw $a2, 2($sp)
#                     lw $a3, 3($sp)
#                     # restore unchanged arguments
#                         # sw $v0, 199($r0) #debug
#                         # jal wait1second #debug
#                     sw $r0, 0($s4) # restore memory to be empty
#                     blt $v0, $s5, minimax_fast_isCPU_invalid # if test val is smaller, do not update. 
#                         addi $s5, $v0, 0 #update val to be tetstval
#                         addi $s6, $s0, 9 # update best move
#                         blt $a3, $s5, minimax_fast_end # if beta < val, break
#                         addi $a2, $s5, 0 # update alpha to be new value
#                     # can be optimized here by not considering the rest of the column.
#                 minimax_fast_isCPU_invalid:
#             addi $s2, $s2, 1
#             blt $s2, $s3, minimax_fast_isCPU_loop2
            
#         addi $s0, $s0, 10
#         blt $s0, $s1, minimax_fast_isCPU_loop1
#     addi $v0, $s5, 0
#     addi $v1, $s6, 0
#     # j minimax_fast_end

#     minimax_fast_end:
    
#     #### stack
#     addi $sp, $sp, -8
#     lw $s0, 0($sp)
#     lw $s1, 1($sp)
#     lw $s2, 2($sp)
#     lw $s3, 3($sp)
#     lw $s4, 4($sp)
#     lw $s5, 5($sp)
#     lw $s6, 6($sp) 
#     lw $ra, 7($sp)
#     jr $ra

#     minimax_fast_no_possible_moves:
#         jal heuristic
#         jr $ra 


count_one_threats_fast: # stores in v1 number of weighted cpu OR human threats. Put $a0,= 192 for cpu threats, $a0 = 3 for human threats.
    sw $ra, 0($sp)
    addi $sp, $sp,  1
    # stack

    addi $t9, $a0, 0 # this reg will just always be 192 or 3.
    #weights good parity by +3, bad parity threat by +1.
    # for human, want to subtract off parity and for cpu want to add parity
    addi $t7, $r0, 1
    and $a0, $t7, $a0 # now a0 stores isHuman
    sub $a1, $r0, $a0
    addi $a1, $a1, 1 # now a1 stores isCPU
    addi $a2, $r0, 2 # now a2 stores 2, the difference between good and bad parity threats.
    
    addi $v1, $r0, 0 # intialize output

     
    addi $t0, $r0, 000100 # start of loop through columns
    addi $t1, $r0, 000170 # end of loop through columns
    count_one_threats_fast_loop1:

        addi $t2, $r0, 0 # start of loop through rows
        addi $t3, $r0, 6 # end of loop through rows
        count_one_threats_fast_loop2:
            add $t4, $t0, $t2 # t4 will be checked threat address
            lw $t5, 0($t4)
            bne $t5, $r0, count_one_threats_fast_nonempty # if mem address is full, there cannot be a threat there.
            count_one_threats_fast_empty:

                check_cpu_row_threat: 
                    addi $t5, $r0, 0 # initialize the sum of the 4 we are using.

                    lw $t6, 0($t4)
                    add $t5, $t5, $t6
                    lw $t6, 10($t4)
                    add $t5, $t5, $t6
                    lw $t6, 20($t4)
                    add $t5, $t5, $t6                    
                    lw $t6, 30($t4)
                    add $t5, $t5, $t6

                    bne $t5, $t9, count_one_threats_fast_no_row1_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        sub $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_row1_cpu:

                    lw $t6, 30($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -10($t4)
                    add $t5, $t5, $t6 #shift the 4inarow we look at left by 1

                    
                    bne $t5, $t9, count_one_threats_fast_no_row2_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_row2_cpu:

                    lw $t6, 20($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -20($t4)
                    add $t5, $t5, $t6 #shift the 4inarow we look at left by 1

                    bne $t5, $t9, count_one_threats_fast_no_row3_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_row3_cpu:

                    lw $t6, 10($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -30($t4)
                    add $t5, $t5, $t6 #shift the 4inarow we look at left by 1

                    bne $t5, $t9, count_one_threats_fast_no_row4_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_row4_cpu:

                # addi $t6, $r0, 2
                # blt $t6, $t2, check_col_threat_skip
                check_cpu_col_threat: 
                    addi $t5, $r0, 0

                    lw $t6, 0($t4)
                    add $t5, $t5, $t6
                    lw $t6, 1($t4)
                    add $t5, $t5, $t6
                    lw $t6, 2($t4)
                    add $t5, $t5, $t6                    
                    lw $t6, 3($t4)
                    add $t5, $t5, $t6
                    
                    
                    bne $t5, $t9, count_one_threats_fast_no_col1_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_col1_cpu:

                    lw $t6, 3($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -1($t4)
                    add $t5, $t5, $t6 #shift the 4inacol we look at left by 1

                    
                    bne $t5, $t9, count_one_threats_fast_no_col2_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_col2_cpu:

                    lw $t6, 2($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -2($t4)
                    add $t5, $t5, $t6 #shift the 4inacol we look at left by 1

                    bne $t5, $t9, count_one_threats_fast_no_col3_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_col3_cpu:

                    lw $t6, 1($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -3($t4)
                    add $t5, $t5, $t6 #shift the 4inacol we look at left by 1

                    bne $t5, $t9, count_one_threats_fast_no_col4_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_col4_cpu:
                check_col_threat_skip:

                # addi $t6, $r0, 2
                # addi $t5, $r0, 135
                # blt $t6, $t2, check_pos_diag_threat_skip
                # blt $t5, $t0, check_pos_diag_threat_skip

                check_pos_diag_threat: 
                    addi $t5, $r0, 0
                    
                    lw $t6, 0($t4)
                    add $t5, $t5, $t6
                    lw $t6, 11($t4)
                    add $t5, $t5, $t6
                    lw $t6, 22($t4)
                    add $t5, $t5, $t6                    
                    lw $t6, 33($t4)
                    add $t5, $t5, $t6

                    
                    bne $t5, $t9, count_one_threats_fast_no_pos_diag1_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_pos_diag1_cpu:

                    lw $t6, 33($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -11($t4)
                    add $t5, $t5, $t6 #shift the 4inapos_diag we look at left by 1

                    
                    bne $t5, $t9, count_one_threats_fast_no_pos_diag2_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_pos_diag2_cpu:

                    lw $t6, 22($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -22($t4)
                    add $t5, $t5, $t6 #shift the 4inapos_diag we look at left by 1

                    
                    bne $t5, $t9, count_one_threats_fast_no_pos_diag3_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_pos_diag3_cpu:

                    lw $t6, 11($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -33($t4)
                    add $t5, $t5, $t6 #shift the 4inapos_diag we look at left by 1

                    
                    bne $t5, $t9, count_one_threats_fast_no_pos_diag4_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_pos_diag4_cpu:
                check_pos_diag_threat_skip:


                # addi $t6, $r0, 3
                # addi $t5, $r0, 135
                # blt $t2, $t6, check_neg_diag_threat_skip
                # blt $t5, $t0, check_neg_diag_threat_skip

                check_neg_diag_threat: 
                    addi $t5, $r0, 0

                    lw $t6, 0($t4)
                    add $t5, $t5, $t6
                    lw $t6, 9($t4)
                    add $t5, $t5, $t6
                    lw $t6, 18($t4)
                    add $t5, $t5, $t6                    
                    lw $t6, 27($t4)
                    add $t5, $t5, $t6

                    
                    bne $t5, $t9, count_one_threats_fast_no_neg_diag1_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_neg_diag1_cpu:

                    lw $t6, 27($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -9($t4)
                    add $t5, $t5, $t6 #shift the 4inaneg_diag we look at left by 1

                    
                    bne $t5, $t9, count_one_threats_fast_no_neg_diag2_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_neg_diag2_cpu:

                    lw $t6, 18($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -18($t4)
                    add $t5, $t5, $t6 #shift the 4inaneg_diag we look at left by 1

                    
                    bne $t5, $t9, count_one_threats_fast_no_neg_diag3_cpu
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        j count_one_threats_fast_nonempty
                    count_one_threats_fast_no_neg_diag3_cpu:

                    lw $t6, 9($t4)
                    sub $t5, $t5, $t6
                    lw $t6, -27($t4)
                    add $t5, $t5, $t6 #shift the 4inaneg_diag we look at left by 1

                    
                    bne $t5, $t9, count_one_threats_fast_nonempty
                        addi $t7, $r0, 1
                        and $t8, $t7, $t4 # gets addressIsEven
                        and $t7, $t8, $a0 # isEven AND isHuman, should add 2
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        # invert $t8.
                        add $t8, $r0, $t8
                        addi $t8, $t8, 1

                        and $t7, $t8, $a1 # isODD and isCPU
                        mul $t7, $a2, $t7 # 2 if above is true, else 0
                        add $v1, $v1, $t7

                        addi $v1, $v1, 1 # increment $v1 by 3. Will subtract off 2 if (isEven AND isCPU) OR (not isEVEN AND not isCPU)
                        # j count_one_threats_fast_nonempty
                check_neg_diag_threat_skip:

            count_one_threats_fast_nonempty:
        addi $t2, $t2, 1
        blt $t2, $t3, count_one_threats_fast_loop2
        
    addi $t0, $t0, 10
    blt $t0, $t1, count_one_threats_fast_loop1

    # stack
    addi $sp, $sp,  -1
    lw $ra, 0($sp)
    jr $ra
