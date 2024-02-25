	.equ ADDR_BASE_HI,0xBF88 # Base address: 16 MSbits
	.equ TRISE,0x6100 # TRISE address is 0xBF886100
	.equ TRISD,0x60C0
	.equ TRISB,0x6040
	.equ PORTB,0x6050
	.equ PORTD,0x60D0
	.equ PORTE,0x6110 # PORTE address is 0xBF886110
	.equ LATE,0x6120 # LATE address is 0xBF886120
	.equ PRINT_STRING,8	
	.data

str1:	.asciiz	"CLICK"
	.text
	.globl main
main:	
	lui	$t1,ADDR_BASE_HI  # int main(void) {
	lw	$t2,TRISE($t1)	  #	$t2 = TRISE		
	andi 	$t2,$t2,0xFFFE	  #	RE0 = 0	
	sw	$t2,TRISE($t1)	  #	
	
	lw	$t2,TRISD($t1)	  # 	$t2 = TRISB
	ori	$t2,$t2,0x0100	  #	RB0 = 1
	sw	$t2,TRISD($t1)

loop:	lw	$t2,PORTD($t1)	
	ori	$t3,$t2,0x0000
	beq	$t3,1,endif
	li	$v0,PRINT_STRING
	la	$a0,str1
	syscall
endif:
	j	loop
	li	$v0,0
	jr	$ra
