	.equ	READ_CORE_TIMER,11
	.equ	RESET_CORE_TIMER,12
	.equ 	PRINT_INT, 6
	.equ	PUT_CHAR,3

	.data
	.text
	.globl main
main:					# int main(void) {
	addiu	$sp,$sp,-8		# abrir espaço na pilha
	sw	$ra, 0($sp)		# guardar $ra
	sw	$s0, 4($sp)		# guardar $s0
	li	$s0, 0			# counter = 0;
while:					# while(1){
	li	$v0,PUT_CHAR		#
	li	$a0,'\r'		#	putChar('\r');
	syscall
	li	$v0, PRINT_INT		#
	move	$a0, $s0
	la	$a1, 0x0004000A		#
	syscall				#	printInt(counter, 10 | 4 << 16); 	li	$v0, RESET_CORE_TIMER	#
	li      $a0, 1000     	        #       $a0 = 1000;
        jal     delay                   #       delay(1000);
	addi	$s0,1			# 	counter++;
	j	while
					# }
	li	$v0,0			#
	lw	$s0,4($sp)		#
	lw	$ra,0($sp)		#
	addiu	$sp,$sp,8		#
	jr	$ra

delay:					# void delay(int ms)
	li	$v0, RESET_CORE_TIMER	#
	syscall				#	resetCoreTimer()
	move	$t0,$a0			#
	mul	$t0,$t0,20000		#
while2:					#	
	li	$v0,READ_CORE_TIMER	#
	syscall				#
	blt	$v0,$t0,while2		#	while(readCoreTimer() < K * ms);
	jr	$ra			#
