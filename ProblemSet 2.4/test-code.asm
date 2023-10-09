lw $t1, 0($zero)
lw $t2, 4($zero)
lw $t0, 12($zero)
loop:
add $t3, $t1, $t2
add $t4, $t3, $t1
sub $t0, $t0, $t2
or $t5, $t4, $t1
slt $t6, $t4, $t5
beq $t2, $t0, loop