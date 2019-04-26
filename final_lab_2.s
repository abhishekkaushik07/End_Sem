.data

data_base: .ascii "AATTATCGAAATTATCGAAATTATCGAAAAAA"     # data_base of size 32    #ATTATCGAAATTATCGAAATTATCGAAAAAA

input: .ascii "TTTTT"   # input string

input_size: .word 5

.text

main:
# v1 will tell output
la $s0,data_base  #base address of data_base
la $s1,input      #base address of input
li $s3,32        # size of data_base is 32
lw $s2,input_size  #size of input

li $t0,0       #counter from position i to position i+input_size

sub $t1,$s3,$s2   #this many times it loops outer1
addi $t1,$t1,1   

li $t5,0  

li $s6,1   #to verify it is matched or not


while:
beq $t5,$t1,end
add $a0,$s0,$t5   					#base address of data_base in matching loop it starts again at updated position
move $a1,$s1 					#base address of input
li $a2,1                        # assume it is being matched in matching
li $a3,0						# go upto input_size in matching
li $v0,0
jal matching
beq $v0,$s6,found
addi $t5,$t5,1
j while


matching:
beq $a3,$s2,m_finish

lb $s4,0($a0)                  #store letters
lb $s5,0($a1)
bne $s4,$s5,go_back
beq $a2,$0,go_back
addi $a0,$a0,1                #move to next adress in given loop for data_base
addi $a1,$a1,1					#move to next adress in given loop for input
addi $a3,$a3,1  
j matching


go_back:
jr $ra

m_finish:
li $v0,1
jr $ra





found:
li $v1,1


end:
li $v0,10
syscall