.data
vetor: .word 10, 11, 12, 13, 14

.text
la $t0, vetor
lw $s1, 4($t0)