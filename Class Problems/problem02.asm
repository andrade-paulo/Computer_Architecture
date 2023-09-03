.data
   X: .word 0
   Y: .word
   
.text   
   li $v0, 5  # Read_int
   syscall  # Pseudo-SO
   
   la $s2, X  # Assign the *address* of X to s2
   sw $v0, ($s2)  # Register the input of v0 inside X
   
   lw $t0, ($s2)  # Assign the value of X to t0
   addi $t0, $t0, 1  # Increment t0 to 1
   
   la $s3, Y  # Assign the *address* of Y to s3
   sw $t0, ($s3)   # Register new value inside Y