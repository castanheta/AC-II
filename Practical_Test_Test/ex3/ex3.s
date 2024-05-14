    .equ ADDR_BASE_HI,  0xBF88  # Base address: 16 MSbits
    .equ TRISE,         0x6100  # TRISE address is 0xBF886100 
    .equ LATE,          0x6120
    .equ printInt,      6
    .equ readCoreTimer, 11
    .equ resetCoreTimer, 12     
    .equ putChar,3
    .data
    .text

    .globl main
main:  

       lui  $t0,ADDR_BASE_HI    # $t1=0xBF880000
       lw   $t1,TRISE($t0)      # READ (Mem_addr = 0xBF880000 + 0x6100)
       andi $t1,$t1,0xFFC1      # MODIFY (bit0=bit3=0 (0 means OUTPUT))
       sw   $t1,TRISE($t0)      # WRITE (Write TRISE register)

        li   $t3,1               # counter = 1

loop:   lw      $t2,LATE($t0)    # $t2 = LATE 
        andi    $t2,$t2,0xFFC1  # RE5-RE1 = 0
        sll     $t4,$t3,1       
        or      $t2,$t2,$t4
        sw      $t2,LATE($t0)        # write LATE

    
        sll     $t3,$t3,1
if:     bne     $t3,0x0020,end
        li      $t3,1
end:

         li      $v0,resetCoreTimer
        syscall
while:  li      $v0,readCoreTimer
        syscall
        blt     $v0,8695652,while

        li      $v0,printInt     
        move    $a0,$t3
        li      $a1,0x00050002
        syscall


        li      $v0,putChar
        li      $a0,'\n'
        syscall


        j       loop
                    
       li    $v0,0
       jr    $ra