    .equ ADDR_BASE_HI,0xBF88 # Base address: 16 MSbits
    .equ TRISE,0x6100 # TRISE address is 0xBF886100
    .equ LATE,0x6120 # LATE address is 0xBF886120 

    .equ readCoreTimer, 11
    .equ resetCoreTimer, 12
    .equ printInt,6
    .equ putChar,3

    .data
    .text
    .globl main
main:
    lui     $t1,ADDR_BASE_HI    # $t1=0xBF880000
    lw      $t2,TRISE($t1)       # READ (Mem_addr = 0xBF880000 + 0x6100)
    andi    $t2,$t2,0xFF83     # MODIFY (bit0=bit3=0 (0 means OUTPUT))
    sw      $t2,TRISE($t1)       # WRITE (Write TRISE register)

    li      $t3,0               # counter = 0;

loop:
        lw      $t2,LATE($t1)
        andi    $t2,$t2,0xFF83
        sll     $t4,$t3,2
        or      $t2,$t2,$t4
        sw      $t2,LATE($t1)

        li      $v0,printInt
        move    $a0, $t3
        li      $a1, 0x00050002
        syscall

        li      $v0,putChar
        li      $a0,'\n'
        syscall


if:     bne     $t3,$0,end_if
        li      $t3,25;
end_if:

        addi    $t3,$t3,-1


while:  li  $v0, resetCoreTimer
        syscall
        li  $v0, readCoreTimer
        syscall
        blt $v0, 5714285, while


    j   loop

    li  $v0,0
    jr  $ra