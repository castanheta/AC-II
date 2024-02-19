	.equ	inkey, 1
	.equ	putChar, 3
	.equ	printInt, 6

	.data
	.text
	.globl main
main:				#int main(void){
	li	$t0,0		#	int cnt = 0;
do:				#	do {
	li	$v0,inkey	#		c = inkey();			
	syscall			#
	move	$t1,$v0		#
if:	beq	$t1,0,else	#		if ( c!= 0)	
	li	$v0,putChar	#
	move	$a0,$t1		#			putChar(c);
	syscall
	j	endif		#
else:	li	$v0,putChar	#		else
	li	$a0,'.'		#			putChar('.')
	syscall			#
endif:	addi	$t0,1		#		cnt++;
while:	bne	$t1,'\n',do	#	} while( c!= '\n');
	li	$v0,printInt	#
	move	$a0,$t0		#
	li	$a1,10		#
	syscall			# 	printInt(cnt,10);
	li	$v0,0		#	return 0;
