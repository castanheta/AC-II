# int main(void)
# {
#	char c;
#	int cnt = 0;
#	do
#	{
#		c = getChar();
#		putChar( c );
#		cnt++;
#	} while( c != '\n' );
# 	printInt(cnt, 10);
#	return 0;
# }
	.equ	getChar, 2
	.equ	putChar, 3
	.equ 	printInt,6
	.data
	.text
	.globl main
main:	li	$t1,0
do:	li	$v0,getChar
	syscall
	move	$t0,$v0
	li	$v0,putChar
	move	$a0,$t0
	syscall
	addi	$t1,1
	bne	$t0,'\n',do
while:
	li	$v0,printInt
	move	$a0,$t1
	li	$a1,10
	syscall
	li 	$v0,0
	jr	$ra
