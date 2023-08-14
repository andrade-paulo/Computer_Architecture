.include "string.asm"
.globl main

.data
	text: .asciiz "hello "
	text1: .asciiz "world"
	line_break: .asciiz "\n"
	
	menu_text: "Menu:\n [1] - strlen\n [2] - strcmp\n [3] - strcpy\n [4] - strncpy\n [5] - strcat\n [6] - strncat\n [0] EXIT\n"

.text
	main:
		MENU_LOOP:
			# Menu choice
			la $a0, menu_text
			li $v0, 4
			syscall

			# Input integer
			li $v0, 5
			syscall
			
			# Options
			beq $v0, 0, EXIT
			beq $v0, 1, OPTION_STRLEN
			beq $v0, 2, OPTION_STRCMP
			beq $v0, 3, OPTION_STRCPY
			beq $v0, 4, OPTION_STRNCPY
			beq $v0, 5, OPTION_STRCAT
			beq $v0, 6, OPTION_STRNCAT
	
		OPTION_STRLEN:
			# Input
      	la $a0, text
			jal strlen
		
			# Result
			add $a0, $v0, $zero
			li $v0, 1
			syscall
		
			jal break_line
		
			# Back to loop
			j MENU_LOOP
		
		OPTION_STRCMP:
			# Input
			la $a0, text
			la $a1, text1
			jal strcmp
		
			# Result
			add $a0, $v0, $zero
			li $v0, 1
			syscall
		
			jal break_line
		
			# Back to loop
			j MENU_LOOP
		
		OPTION_STRCPY:
			# Input
			la $a0, text
			la $a1, text1
			jal strcpy

			# Result string 1
			li $v0, 4
			syscall
		
			jal break_line
		
			# Result string 2
			add $a0, $a1, $zero
			li $v0, 4
			syscall
		
			jal break_line
		
			# Back to loop
			j MENU_LOOP
		
		OPTION_STRNCPY:
			# Input
			la $a0, text
			la $a1, text1
			la $a2, 2
			jal strncpy

			# Result string 1
			li $v0, 4
			syscall
		
			jal break_line
			
			# Result string 2
			add $a0, $a1, $zero
			li $v0, 4
			syscall
		
			jal break_line
		
			# Back to loop
			j MENU_LOOP
		
		OPTION_STRCAT:
			# Input
			la $a0, text
			la $a1, text1
			jal strcat
		
			# Result
			add $a0, $v0, $zero
			li $v0, 4
			syscall
		
			jal break_line
		
			# Back to loop
			j MENU_LOOP
		
		OPTION_STRNCAT:
			# Input
			la $a0, text
			la $a1, text1
			addi $a2, $zero, 2
			jal strncat
		
			# Result
			add $a0, $v0, $zero
			li $v0, 4
			syscall
		
			jal break_line
			
			# Back to loop
			j MENU_LOOP

		EXIT:
			li $v0, 10
			syscall


	break_line:
		la $a0, line_break
		li $v0, 4
		syscall
		
		jr $ra
