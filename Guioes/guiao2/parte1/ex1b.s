	.equ	 READ_CORE_TIMER,11
	.equ	RESET_CORE_TIMER,12
	.equ	PUT_CHAR,3
	.equ	PRINT_INT,6
	.data
	.text
	.globl main
main:	li	$t0, 0			# counter = 0
while:					# while(1) {
	li	$v0,READ_CORE_TIMER	#
	syscall				#
	blt 	$v0,4000000,while	#	while(readCoreTimer() < 200000);
	li	$v0, PUT_CHAR		#
	li	$a0, '\r'		#
	syscall				#	putChar('\r')
	li	$v0, PRINT_INT 		#
	move	$a0, $t0		#
	la	$a1, 0x00400A		#
	syscall				#	printInt(counter, 10 | 4 << 16);
	li	$v0,RESET_CORE_TIMER 	#
	syscall				#	resetCoreTimer()
	addi	$t0,1			#	counter++;
	j	while			# }
	j	$ra			#
