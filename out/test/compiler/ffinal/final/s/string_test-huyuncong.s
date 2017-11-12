	.text
print:
	li $v0, 4
	syscall
	jr $ra

____builtin____print_int:
	li $v0, 1
	syscall
	jr $ra

println:
	li $v0, 4
	syscall
	la $a0, ____string_newline
	syscall
	jr $ra

getString:
	la $a0 ____string_buffer
	li $a1 1024
	li $v0 8
	syscall
	move $v1 $a0
	li $a1 0
Label2_Cond:
	lb $v0 ($a0)
	beqz $v0 Label2_StrSpace
	add $a1 $a1 1
	add $a0 $a0 1
	j Label2_Cond
Label2_StrSpace:
	add $a0 $a1 5
	li $v0 9
	syscall
	sw $a1 ($v0)
	add $v0 $v0 4
	move $a0 $v0
	la $a1 ____string_buffer
Label2_CopyCond:
	lb $v1 ($a1)
	beqz $v1 Label2_End
	sb $v1 ($a0)
	add $a0 $a0 1
	add $a1 $a1 1
	j Label2_CopyCond
Label2_End:
	sb $0 ($a0)
	jr $ra

getInt:
	li $v0, 5
	syscall
	jr $ra

toString:
Label12_ToString:
	move $a1 $a0
	li $a0 16
	li $v0 9
	syscall
	bnez $a1 Label12_NotZero
	lb $0 5($v0)
	li $a0 48
	sb $a0 4($v0)
	li $a0 1
	sb $a0 ($v0)
	j Label12_EndToString
Label12_NotZero:
	slt $v1 $a1 0
	add $a3 $v0 15
	sb $0 ($a3)
Label12_Cond:
	beqz $a1 Label12_EndLoop
	rem $a0 $a1 10
	div $a1 $a1 10
	beqz $v1 Label12_LoadChar
	ble $a0 0 Label12_ToNeg
	add $a0 $a0 -10
Label12_ToNeg:
	neg $a0 $a0
Label12_LoadChar:
	add $a0 $a0 48
	add $a3 $a3 -1
	sb $a0 ($a3)
	j Label12_Cond
Label12_EndLoop:
	beqz $v1 Label12_Copy
	li $a0 45
	add $a3 $a3 -1
	sb $a0 ($a3)
Label12_Copy:
	sub $v1 $v0 $a3
	add $v1 $v1 16
	sw $v1 ($v0)
	add $v1 $v0 4
Label12_CopyCond:
	lb $a0 ($a3)
	sb $a0 ($v1)
	add $a3 $a3 1
	add $v1 $v1 1
	bnez $a0 Label12_CopyCond
Label12_EndToString:
	add $v0 $v0 4
	jr $ra

size:
	lw $v0, 0($a0)
	jr $ra

length:
	lw $v0, -4($a0)
	jr $ra

ord:
	addu $a0, $a0, $a1
	lb $v0, 0($a0)
	jr $ra

substring:
	add $a2 $a2 1
	add $a1 $a0 $a1
	add $a2 $a0 $a2
	sub $v1 $a2 $a1
	add $a0 $v1 5
	li $v0 9
	syscall
	sw $v1 ($v0)
	add $v0 $v0 4
	move $a0 $v0
Label1_Loop:
	beq $a1 $a2 Label1_End
	lb $v1 ($a1)
	sb $v1 ($a0)
	add $a0 $a0 1
	add $a1 $a1 1
	j Label1_Loop
Label1_End:
	sb $0 ($a0)
	jr $ra

parseInt:
	li $v0 0
	lb $a3 ($a0)
	seq $v1 $a3 45
	add $a0 $a0 $v1
Label0_Cond:
	lb $a3 ($a0)
	blt $a3 48 Label0_Next
	bgt $a3 57 Label0_Next
	add $a3 $a3 -48
	beqz $v1 Label0_NotNeg
	neg $a3 $a3
Label0_NotNeg:
	mul $v0 $v0 10
	add $v0 $v0 $a3
	add $a0 $a0 1
	j Label0_Cond
Label0_Next:
	jr $ra

stringAdd:
	move $v1 $a0
	lw $v0 -4($a0)
	lw $a0 -4($a1)
	add $a0 $a0 $v0
	move $a2 $a0
	add $a0 $a0 5
	li $v0 9
	syscall
	sw $a2 ($v0)
	add $v0 $v0 4
	move $a0 $v0
Label5_CopyFirst:
	lb $a2 ($v1)
	beqz $a2 Label5_CopySecond
	sb $a2 ($a0)
	add $a0 $a0 1
	add $v1 $v1 1
	j Label5_CopyFirst
Label5_CopySecond:
	lb $v1 ($a1)
	beqz $v1 Label5_End
	sb $v1 ($a0)
	add $a0 $a0 1
	add $a1 $a1 1
	j Label5_CopySecond
Label5_End:
	sb $0 ($a0)
	jr $ra

stringEquals:
Label6_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label6_End
	beqz $v1 Label6_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label6_Begin
Label6_End:
	seq $v0 $v0 $v1
	jr $ra

____builtin_string____greater_than:
Label7_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label7_End
	beqz $v1 Label7_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label7_Begin
Label7_End:
	sgt $v0 $v0 $v1
	jr $ra

____builtin_string____greater_than_or_equal_to:
Label8_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label8_End
	beqz $v1 Label8_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label8_Begin
Label8_End:
	sge $v0 $v0 $v1
	jr $ra

stringLessThan:
Label9_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label9_End
	beqz $v1 Label9_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label9_Begin
Label9_End:
	slt $v0 $v0 $v1
	jr $ra

stringLessThanOrEquals:
Label10_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label10_End
	beqz $v1 Label10_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label10_Begin
Label10_End:
	sle $v0 $v0 $v1
	jr $ra

____builtin_string____not_equal_to:
Label11_Begin:
	lb $v0 ($a0)
	lb $v1 ($a1)
	beqz $v0 Label11_End
	beqz $v1 Label11_End
	add $a0 $a0 1
	add $a1 $a1 1
	j Label11_Begin
Label11_End:
	sne $v0 $v0 $v1
	jr $ra
_calc:
	sub $sp, $sp, 264
	sw $s1, 204($sp)
	sw $s2, 208($sp)
	sw $s3, 212($sp)
	sw $s4, 216($sp)
	sw $ra, 256($sp)
label_940:
	lw $a0, 0($sp)
	jal length
	move $s4, $v0
	move $s2, $s4
	li $t1, 1
	seq $s4, $s2, $t1
	beqz $s4, label_943
	b label_942
label_942:
	lw $v0, 0($sp)
	b label_941
label_943:
	li $t1, 2
	div $s4, $s2, $t1
	move $s4, $s4
	li $t1, 1
	sub $s3, $s4, $t1
	lw $a0, 0($sp)
	li $a1, 0
	move $a2, $s3
	jal substring
	move $s3, $v0
	sw $s3, -264($sp)
	jal _calc
	move $s3, $v0
	move $s3, $s3
	li $t1, 1
	sub $s2, $s2, $t1
	lw $a0, 0($sp)
	move $a1, $s4
	move $a2, $s2
	jal substring
	move $s4, $v0
	sw $s4, -264($sp)
	jal _calc
	move $s4, $v0
	move $s1, $s4
	move $a0, $s3
	move $a1, $s1
	jal stringLessThan
	move $s4, $v0
	beqz $s4, label_945
	b label_944
label_944:
	move $a0, $s3
	move $a1, $s1
	jal stringAdd
	move $s4, $v0
	move $v0, $s4
	b label_941
label_945:
	move $a0, $s3
	move $a1, $s1
	jal stringEquals
	move $s4, $v0
	beqz $s4, label_948
	b label_947
label_947:
	move $a0, $s3
	li $a1, 0
	jal ord
	move $s4, $v0
	move $s2, $s4
	move $a0, $s1
	li $a1, 0
	jal ord
	move $s4, $v0
	move $s4, $s4
	slt $s4, $s2, $s4
	beqz $s4, label_951
	b label_950
label_950:
	move $a0, $s3
	move $a1, $s1
	jal stringAdd
	move $s4, $v0
	move $v0, $s4
	b label_941
label_951:
	move $a0, $s1
	move $a1, $s3
	jal stringAdd
	move $s4, $v0
	move $v0, $s4
	b label_941
label_948:
	move $a0, $s1
	move $a1, $s3
	jal stringLessThan
	move $s4, $v0
	beqz $s4, label_953
	b label_952
label_952:
	move $a0, $s1
	move $a1, $s3
	jal stringAdd
	move $s4, $v0
	move $v0, $s4
	b label_941
label_953:
	b label_949
label_949:
	b label_946
label_946:
	la $a0, string_4
	jal println
label_941:
label_941:
	lw $ra, 256($sp)
	lw $s1, 204($sp)
	lw $s2, 208($sp)
	lw $s3, 212($sp)
	lw $s4, 216($sp)
	addu $sp, $sp, 264
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 168
	sw $s4, 120($sp)
	sw $ra, 160($sp)
label_954:
	jal getString
	move $s4, $v0
	sw $s4, global_0
	jal getString
	move $s4, $v0
	sw $s4, global_1
	lw $a0, global_1
	jal parseInt
	move $s4, $v0
	sw $s4, global_3
	lw $a0, global_0
	jal length
	move $s4, $v0
	lw $t1, global_3
	slt $s4, $s4, $t1
	beqz $s4, label_957
	b label_956
label_956:
	la $a0, string_5
	jal println
	li $v0, 0
	b label_955
label_957:
	lw $t0, global_3
	li $t1, 1
	sub $s4, $t0, $t1
	lw $a0, global_0
	li $a1, 0
	move $a2, $s4
	jal substring
	move $s4, $v0
	sw $s4, -264($sp)
	jal _calc
	move $s4, $v0
	sw $s4, global_2
	lw $a0, global_2
	jal println
	li $v0, 0
	b label_955
label_955:
	lw $ra, 160($sp)
	lw $s4, 120($sp)
	addu $sp, $sp, 168
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 11
string_4:
.asciiz "Never Ever!"
.align 2
.word 13
string_5:
.asciiz "length error!"
.align 2
global_0:
.space 4
.align 2
global_1:
.space 4
.align 2
global_2:
.space 4
.align 2
global_3:
.space 4
.align 2
