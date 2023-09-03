# Aluno: Paulo Henrique Almeida de Andrade
# Arquivo string com as implementações de cada função requisitada

.text
	strlen:
		# Stack
		addi $sp, $sp, -12
		sw $s0, 8($sp)
		sw $t0, 4($sp)
		sw $t1, 0($sp)
		
		add $s0, $zero, $zero  # Iterator
		
		LOOP_LEN: 
			add $t0, $s0, $a0  # Adress
			lb $t1, ($t0)  # Value
			beq $t1, $zero, EXIT_LEN
			
			# Else
			addi $s0, $s0, 1  # Add iterator
			j LOOP_LEN
			
		EXIT_LEN:
			add $v0, $s0, $zero  # Return value
			
			# Restore registers from stack
			lw $s0, ($sp)
			lw $t0, 4($sp)
			lw $t1, 8($sp)
			addi $sp, $sp, 12
			
			jr $ra  # Return
	
	
	strcpy:
		# Stack
		addi $sp, $sp, -16
		sw $s0, ($sp)
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		sw $t2, 12($sp)
		
		add $s0, $zero, $zero  # Iterator
	
		LOOP_CPY: 
			add $t0, $s0, $a1  # Adress of source's character
			lb $t1, ($t0)  # Value of source's character
			
			add $t2, $s0, $a0  # Adress of destination's character
			sb $t1, ($t2)  # Value of destination's character 
			
			addi $s0, $s0, 1
			beq $t1, $zero, EXIT_CPY
			
			j LOOP_CPY
			
		EXIT_CPY: 		
			add $v0, $t0, $zero
		
			# Restore registers and stack
			lw $s0, ($sp)
			lw $t0, 4($sp)
			lw $t1, 8($sp)
			lw $t2, 12($sp)
			addi $sp, $sp, 16
			
			jr $ra  # Return
	
	
	strncpy:
		# Stack
		addi $sp, $sp, -16
		sw $s0, ($sp)
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		sw $t2, 12($sp)
		
		add $s0, $zero, $zero  # Iterator
	
		LOOP_NCPY: 
			add $t0, $s0, $a1  # Adress of source's character
			lb $t1, ($t0)  # Value of source's character
			
			add $t2, $s0, $a0  # Adress of destination's character
			sb $t1, ($t2)  # Value of destination's character 
			
			addi $s0, $s0, 1
			
			beq $s0, $a2, ADD_0_NCPY  # If iterator = maximum number of characters
			beq $t1, $zero, EXIT_NCPY
			
			j LOOP_NCPY
		
		# Add \0 to the end of incomplete strings 
		ADD_0_NCPY:
		add $t2, $s0, $a0
		sb $zero, ($t2)
					
		EXIT_NCPY: 		
			add $v0, $t0, $zero
		
			# Restore registers and stack
			lw $s0, ($sp)
			lw $t0, 4($sp)
			lw $t1, 8($sp)
			lw $t2, 12($sp)
			addi $sp, $sp, 16
			
			jr $ra  # Return
	
	
	strcmp:
		# Stack
		addi $sp, $sp, -20
		sw $s0, ($sp)
		sw $t0, 4($sp)
		sw $t1, 8($sp)
		sw $t2, 12($sp)
		sw $t3, 16($sp)
	
		# Initial registers
		add $s0, $zero, $zero  # Iterator
		add $v0, $zero, $zero  # Return value
	
		LOOP_CMP:
			add $t0, $s0, $a0  # Adress of first string
			lb $t1, ($t0)  # Character of first string
			
			add $t2, $s0, $a1  # Adress of second string
			lb $t3, ($t2)  # Character of second string
			
			bgt $t1, $t3, BIGGER
			
			blt $t1, $t3, LESS
			
			beq $t1, $zero, EXIT_CMP
			
			add $s0, $s0, 1
			j LOOP_CMP
		
		BIGGER:
			addi $v0, $v0, 1
			j EXIT_CMP 
		
		LESS:
			addi $v0, $v0, -1
			j EXIT_CMP
		
		EXIT_CMP:
			# Restore registers and stack
			lw $s0, ($sp)
			lw $t0, 4($sp)
			lw $t1, 8($sp)
			lw $t2, 12($sp)
			lw $t3, 16($sp)
			addi $sp, $sp, 20
		
			jr $ra  # Return

	
	strcat:
		# Stack
		addi $sp, $sp, -24	 
		sw $s0, ($sp)
		sw $s1, 4($sp)
		sw $s2, 8($sp)
		sw $t0, 12($sp)
		sw $t1, 16($sp)
		sw $t2, 20($sp)
		
		add $s0, $zero, $zero  # Read Iterator 
		add $s2, $zero, $zero  # Write Iterator
		
		# Reading the first string
		LOOP_CAT_READ:
			add $s1, $s0, $a0
			lb $t1, ($s1)
			
			beq $t1, $zero, LOOP_CAT_WRITE
			
			addi $s0, $s0, 1
			j LOOP_CAT_READ
		
		# Writing the second string after the first
		LOOP_CAT_WRITE:
			add $t0, $s2, $a1  # Adress of source's string
			lb $t1, ($t0)  # Character of source's string
			
			add $t2, $s2, $s1  # Adress of destination's string
			sb $t1, ($t2)  # Character of destination's string
			
			addi $s2, $s2, 1
			beq $t1, 0, EXIT_CAT
			
			j LOOP_CAT_WRITE
		
		EXIT_CAT:
		add $v0, $a0, $zero
		
		# Restore registers and stack
		lw $s0, ($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $t0, 12($sp)
		lw $t1, 16($sp)
		lw $t2, 20($sp)
		addi $sp, $sp, 24
		
		jr $ra  # Return
		
	
	strncat:
		# Stack
		addi $sp, $sp, -24	 
		sw $s0, ($sp)
		sw $s1, 4($sp)
		sw $s2, 8($sp)
		sw $t0, 12($sp)
		sw $t1, 16($sp)
		sw $t2, 20($sp)
		
		add $s0, $zero, $zero  # Read Iterator 
		add $s2, $zero, $zero  # Write Iterator
		
		# Reading the first string
		LOOP_NCAT_READ:
			add $s1, $s0, $a0
			lb $t1, ($s1)
			
			beq $t1, $zero, LOOP_NCAT_WRITE
			
			addi $s0, $s0, 1
			j LOOP_NCAT_READ
		
		# Writing the second string after the first
		LOOP_NCAT_WRITE:
			add $t0, $s2, $a1  # Adress of source's string
			lb $t1, ($t0)  # Character of source's string
			
			add $t2, $s2, $s1  # Adress of destination's string
			sb $t1, ($t2)  # Character of destination's string
			
			addi $s2, $s2, 1
			beq $s2, $a2, ADD_0_NCAT  # If iterator = maximum number of characters
			beq $t1, $zero, EXIT_NCAT
			
			j LOOP_NCAT_WRITE
		
		# Add \0 to the end of incomplete strings
		ADD_0_NCAT:
		add $t2, $s2, $s1
		sb $zero, ($t2)
		
		EXIT_NCAT:
		add $v0, $a0, $zero
		
		# Restore registers and stack
		lw $s0, ($sp)
		lw $s1, 4($sp)
		lw $s2, 8($sp)
		lw $t0, 12($sp)
		lw $t1, 16($sp)
		lw $t2, 20($sp)
		addi $sp, $sp, 24
		
		jr $ra  # Return
	
