        .equ ADDR_BASE_HI,0xBF88    # Base address: 16 MSbits
        .equ TRISE,0x6100           # TRISE address is 0xBF886100
        .equ TRISB,0X6040           
        .equ LATE,0x6120
        .equ PORTB,0x6050
        .equ RESET_CORE_TIMER,12
        .equ READ_CORE_TIMER,11

        .data   
        .text
        .globl main
main:   addiu   $sp,$sp,-8
        sw      $ra,0($sp)
        sw      $s0,4($sp)

        lui     $s0,ADDR_BASE_HI
        lw      $t1,TRISE($s0)      # $t0 must be previously initialized
        andi    $t1,$t1,0xFFE1      # Reset bits 4-1
        sw      $t1,TRISE($s0)      # Update TRISE register

        li      $t2,0               #e.g. up counter (initial value is 0)
loop:
        lw      $t1,LATE($s0)       # Read LATE register
        andi    $t1,$t1,0xFFE1      # Reset bits 4-1
        sll     $t3,$t2,1           # Shift counter value to "position" 1
        or      $t1,$t1,$t3         # Merge counter w/ LATE value
        sw      $t1,LATE($s0)       # Update LATE register


        li      $a0,1000
        jal     delay

        addi    $t2,$t2,1
        andi    $t2,$t2,0x000F       # e.g. up counter MOD 16 
        j       loop
        lw      $ra,0($sp)
        lw      $s0,4($sp)
        addiu   $sp,$sp,-8
        li      $v0,0
        jr      $ra

delay:					             # void delay(int ms)
	    li	$v0, RESET_CORE_TIMER	     #
	    syscall				#	resetCoreTimer()
	    move	$t0,$a0			#
	    mul	$t0,$t0,20000		#
while2:					#	
	    li	$v0,READ_CORE_TIMER	#
	    syscall				#
	    blt	$v0,$t0,while2		#	while(readCoreTimer() < K * ms);
	    jr	$ra			#