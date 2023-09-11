.data
   n1: .word 0
   n2: .word 0
   n3: .word 0
   n4: .word 0
   
   out_beginning: .asciiz "The sum "
   out_less_equal_21: .asciiz " reached the expected value with 3 terms"
   out_greater_equal_24: .asciiz " reached the goal value with 4 terms"
   out_less_24: .asciiz " is bellow expected"
   
.text
   # Read n1
   li $v0, 5
   syscall
   
   la $t1, n1
   sw $v0, ($t1)
   
   # Read n2
   li $v0, 5
   syscall
   
   la $t2, n2
   sw $v0, ($t2)
   
   # Read n3
   li $v0, 5
   syscall
   
   la $t3, n3
   sw $v0, ($t3)
   
   # Values of variables
   lw $s1, ($t1)
   lw $s2, ($t2)
   lw $s3, ($t3)
   
   # Sum
   add $s0, $s1, $s2
   add $s0, $s0, $s3
   
   # If equal to 21
   ble $s0, 21, LessEqual21
   
   # Else
   li $v0, 5
   syscall
   
   la $t1, n4
   sw $v0, ($t1)
   
   lw $s4, ($t1)
   
   # New sum
   add $s0, $s0, $s4
   
   # If greater or equal to 24
   bge $s0, 24, GreaterEqual24
   
   # Loser
   la $t0, out_less_24
   j Output
   
   LessEqual21: la $t0, out_less_equal_21
   j Output
   
   GreaterEqual24: la $t0,  out_greater_equal_24
   
   Output:
   la $a0, out_beginning
   
   li $v0, 4
   syscall
   
   la $a0, ($s0)
   
   li $v0, 1
   syscall
   
   la $a0, ($t0)
   
   li $v0, 4
   syscall
