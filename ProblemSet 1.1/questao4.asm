.data
pal1: .word 0x10203040
pal2: .space 4
pal3: .word 0xffffffff

.text
main: lw $s0, pal1
sw $s0,pal2
sw $s0,pal3+0
