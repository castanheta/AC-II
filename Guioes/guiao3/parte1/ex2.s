.equ ADDR_BASE_HI,0xBF88 # Base address: 16 MSbits
	.equ TRISE,0x6100 # TRISE address is 0xBF886100
	.equ TRISB,0x6040
	.equ PORTB,0x6050
	.equ PORTE,0x6110 # PORTE address is 0xBF886110
	.equ LATE,0x6120 # LATE address is 0xBF886120

	.data
	.text
	.globl main
main:	lui	$t1,ADDR_BASE_HI  # int main(void) {
	lw	$t2,TRISE($t1)	  #	$t2 = TRISE		
	andi 	$t2,$t2,0xFFFE	  #	RE0 = 0	
	sw	$t2,TRISE($t1)	  #	
	
	lw	$t2,TRISB($t1)	  # 	$t2 = TRISB
	ori	$t2,$t2,0x0001	  #	RB0 = 1
	sw	$t2,TRISB($t1)

while:	lw	$t2,PORTB($t1)	  #	$t2 = PORTB
	andi	$t2,$t2,1	  #	$t2 = RB0
	xori	$t2,$t2,1	  #     $t2 = RB0\
	lw	$t3,LATE($t1)     #	$t3 = LATE
	andi	$t3,$t3,0xFFFE    #	RE0 = 0
	or	$t3,$t3,$t2       #     RE0 = RB0
	sw	$t3,LATE($t1)		
	j 	while
	li	$v0,0
	jr	$ra
