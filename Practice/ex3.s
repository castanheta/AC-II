    .equ ADDR_BASE_HI,0xBF88 # Base address: 16 MSbits
    .equ TRISE,0x6100 # TRISE address is 0xBF886100
    .equ LATE,0x6120 # LATE address is 0xBF886120
    .equ ReadCoreTimer,11
    .equ ResetCoreTimer,12
    .equ PrintInt,6
    .equ PutChar,3
    .data
    .text
    .globl main
main:
    lui $t1,ADDR_BASE_HI    # $t1=0xBF880000
    lw $t2,TRISE($t1)       # READ (Mem_addr = 0xBF880000 + 0x6100)
    andi $t2,$t2,0xFFE1     # MODIFY (bit0=bit3=0 (0 means OUTPUT))
    sw $t2,TRISE($t1)       # WRITE (Write TRISE register)

    li  $t3,0x0009          # counter = 1001;

loop:
    lw      $t2,LATE($t1)
    andi    $t2,$t2,0xFFE1
    sll     $t4,$t3,1         
    or      $t2,$t2,$t4
    sw      $t2,LATE($t1)

    not     $t3,$t3
    andi    $t3,$t3,0x000F

    li      $v0,ResetCoreTimer
    syscall

while:  li  $v0,ReadCoreTimer
        syscall
        blt $v0,2857142,while

    li      $v0,PrintInt
    move    $a0,$t3
    la      $a1,0x00040002
    syscall

    li      $v0,PutChar
    li      $a0,'\n'
    syscall

    j   loop

    li  $v0,0
    jr  $ra