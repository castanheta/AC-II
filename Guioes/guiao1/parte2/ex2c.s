	.equ	printStr, 8
	.equ	printInt10,7
	.equ	printInt,6
	.equ	readInt10,5
	.data

str1:	.asciiz	"\nIntroduza um inteiro (sinal e módulo): ")
str2:	.asciiz	"\nValor em base 10 (signed): "
str3:	.asciiz	"\nValor em base 2: "
str4:	.asciiz	"\nValor em base 16: "
str5:	.asciiz	"\nValor em base 10 (unsigned): "
str6:	.asciiz	"\nValor em base 10 (unsigned), formata	do: "

	.text
	.globl main
main:				# int main(void){
	li	$v0,printStr	#
	la	$a0,str1	
	syscall			#
	li	$v0,readInt10	#
	syscall
	move	$t0,$v0		#
	
	li	$v0,printStr	#
	la	$a0,str2
	syscall
	li	$v0,printInt10
	move	$a0,$t0
	syscall


	li      $v0,printStr    #
        la      $a0,str3
        syscall
	li	$v0,printInt
	move	$a0,$t0
	li	$a1,2
	syscall


	li      $v0,printStr    #
        la      $a0,str4
        syscall
	li	$v0,printInt
	move	$a0,$t0
	li	$a1,16
	syscall

	li      $v0,printStr    #
        la      $a0,str5
        syscall
	li	$v0,printInt
	move	$a0,$t0
	li	$a1,10
	syscall
	
	li      $v0,printStr    #
        la      $a0,str6
        syscall
	li	$v0,printInt
	move	$a0,$t0
	li	$a1,0x0004002
	syscall
	
	j	main
	li	$v0,0	

