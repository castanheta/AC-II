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

main:                                   # void main(void) {
        addiu   $sp, $sp, -12           #       abrir espaco na stack
        sw      $ra, 0($sp)             #       salvaguardar $ra
        sw      $s0, 4($sp)             #       salvaguardar $s0
        sw      $s1, 8($sp)             #       salvaguardar $s1
                                        #
        lui     $s0, SFR_BASE_HI        #
        lw      $t1, TRISE($s0)         #       $t1 = [TRISE];
        andi    $t1, $t1, 0xFFE1        #       TRISE[3..0] = 0;
        sw      $t1, TRISE($s0)         #       WRITE TRISE Register
                                        #
         li      $s1, 1                 #       count = 0;                                #
loop:                                   #       while(1) {
       li      $v0,PRINT_INT
        move    $a0,$s1
        la      $a1,0x0004000F
        syscall
       
       lw      $t1, LATE($s0)          #               $t1 = [LATE];
        andi    $t1, $t1, 0xFFE1        #               RE[3..0] = 0;
        sll     $t3,$s1,1
        or      $t1, $t1, $t3           #               RE[3..0] = count;
        sw      $t1, LATE($s0)          #               WRITE LATE Register;
        li      $a0, 333                #
        jal     delay                   #               delay(333);

        

        li      $v0,PUT_CHAR
        li      $a0,' '
        syscall
        
        andi    $s1, $s1, 0x000F        #                       count &= 0x000F
if_last:bne     $s1, 0x0010, end            #                       if(count == 0) {
        srl      $s1, $s1,2                 #                               count = 1;
end:                                    #                       }
                 #               }
                                        #
        j       loop                    #       }
        
        lw      $ra, 0($sp)             #       repor $ra
        lw      $s0, 4($sp)             #       salvaguardar $s0
        lw      $s1, 8($sp)             #       salvaguardar $s1
        addiu   $sp, $sp, 12            #       repor espaco na stack
        jr      $ra                     # }

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