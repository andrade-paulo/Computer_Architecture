.data
   A: .word 0
   B: .word 0
   initialText: .asciiz "The value "
   biggerText: .asciiz " is bigger than "
   lessText: .asciiz " is less or equal than "

.text
   # Rediang the value of A
   li $v0, 5 # Read_int code
   syscall
   
   la $t1, A  # Assign the *address* of A to s1
   sw $v0, ($t1)  # Register the input v0 inside A
   
   # Rediang the value of B
   li $v0, 5  # Read_int code
   syscall
   
   la $t2, B  # Assign the *address* of B to s2
   sw $v0, ($t2)  # Register the input v0 inside B
   
   # Load variables values
   lw $s1, ($t1)
   lw $s2, ($t2)
   
   # OUTPUT (Initial text)
   la $a0, initialText
   addi $v0, $zero, 4
   syscall
   
   addi $v0, $zero, 1  # Print int
   la $a0, ($s1)  # Print value of A
   syscall
   
   # Conditional
   sgt $t0, $s1, $s2
   bne $t0, $zero, Bigger  # Goes to Bigger when t0 = 1
   
   # OUTPUT (Less or equal)
   la $a0, lessText
   j Final
   
   # OUTPUT (Bigger)
   Bigger: la $a0, biggerText
   
   # OUTPUT (Final)
   Final: addi $v0, $zero, 4
   syscall
   
   addi $v0, $zero, 1  # Print int
   la $a0, ($s2)  # Print value of A
   syscall