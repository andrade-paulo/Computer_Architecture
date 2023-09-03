.data
   vect: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
   sum_value: .word 0

.text
main:
   # Variables
   la $s0, vect
   la $s1, sum_value

   add $s2, $s0, 40  # Store the last position of vect
	
   Loop:
      beq $s0, $s2, Exit  # Condition to stop
      
      # vect value to arg 0
      lw $t0, ($s0)
      add $a0, $t0, $zero
      
      # sum_value value to arg 1
      lw $t1, ($s1)
      add $a1, $t1, $zero
   
      jal Sum  # Function call
   
      sw $v0, ($s1)  # Return to sum_value
   
      addi $s0, $s0, 4  # Iterator
      
		j Loop  # Return to the loop

Sum:
   add $v0, $a0, $a1
   jr $ra

Exit:
li $v0, 10
syscall