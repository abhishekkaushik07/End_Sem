main:
li $a0,1
jal recurs_sum

add $s0,$0,$v0   # Final result is stored in $s0.
j end

recurs_sum:
li $t0,2
slt $t1,$a0,$t0
beq $t1,$0,loop
move $v0,$a0
jr $ra



loop:
addi $sp,$sp,-8
sw $a0,0($sp)
sw $ra,4($sp)
addi $a0,$a0,-1
jal recurs_sum
lw $t0,0($sp)
add $v0,$v0,$t0
lw $ra,4($sp)
addi $sp,$sp,8
jr $ra



end:
li $v0,10
syscall