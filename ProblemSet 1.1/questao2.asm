.data
msg1: .asciiz "Insert an integer value: "

.text
.globl main
# Inside of main there'are some "syscalls" responsible of
# alter the register value $ra that stores
# the address of main's return.

main: addu $s0, $ra, $0 # stores the register $ra inside $s0

labell: li $v0, 4 # print_str
la $a0, msg1 # string's address
syscall

# Input
li $v0, 5 # read_int
syscall # Integer goes to $v0

# Math
addu $t0, $v0, $0 # move number to $t0
sll $t0, $t0, 2 # Shift 2 bits to the left

# Print result
li $v0, 1 # print_int
addu $a0, $t0, $0 # move result to $a0
syscall

# Return address goes to $ra
addu $ra, $0, $s0

# Exit
li $v0, 10
syscall
