        .equ    RESET_CORE_TIMER, 12
        .equ    READ_CORE_TIMER, 11
        .equ    SFR_BASE_HI, 0xBF88
        .equ    TRISE, 0x6100
        .equ    PORTE, 0x6110
        .equ    LATE, 0x6120
        .equ    TRISB, 0x6040
	    .equ    PORTB, 0x6050
        .equ    PRINT_INT, 6
        .equ    PUT_CHAR,3
        .data
        .text
        .globl main
main:   addiu    $sp,$sp,-12       #
        sw      $ra,0($sp)
        sw      $s0,4($sp)
        sw      $s1,8($sp)
        

        lui     $s0,SFR_BASE_HI
        lw      $t0,TRISE($s0)          #       $t0 = TRISE
        andi    $t0,$t0,0xFFE1          #       RE1,RE2,RE3,RE4 = 0
        sw      $t0,TRISE($s0)         #       

        li      $s1,0                   #       counter = 0

loop:   lw      $t0,LATE($s0)           #       $t0 = LATE
        andi    $t0,$t0,0xFFE1          #       RESET BITS
        sll     $t1,$s1,1               #       Shift counter value to position 1
        or      $t0,$t0,$t1             #       Merge values
        sw      $t0,LATE($s0)

        li      $a0, 1000 
        jal     delay

        
        andi    $t2,$s1,0x0008
        srl     $t2,$t2,3
        sll     $s1,$s1,1
        xori    $t2,$t2,0x0001
        or      $s1,$s1,$t2
        andi    $s1,$s1,0x000F
        
        j       loop

        lw      $ra,0($sp)
        lw      $s0,4($sp)
        lw      $s0,8($sp)
        addiu   $sp,$sp,12
        li      $v0, 0
        jr      $ra




delay:                                  # void delay(int ms) {
        move    $t0, $a0                #       $t0 = ms;
        
for:    ble     $t0, 0, endfor          #       for(; ms > 0; ms--) {
        li      $v0, RESET_CORE_TIMER   #               
        syscall                         #               resetCoreTimer();
read:   li      $v0, READ_CORE_TIMER    #
        syscall                         #               readCoreTimer();
        blt     $v0, 20000, read        #               while(readCoreTimer() < K);
        addi    $t0, $t0, -1            #               ms--;
        j       for                     #       }
endfor:                                 #       
        jr      $ra                     # }