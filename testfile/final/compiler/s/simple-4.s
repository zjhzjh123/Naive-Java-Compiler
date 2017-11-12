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
main:
	sub $sp, $sp, 192
	sw $k1, 68($sp)
	sw $gp, 72($sp)
	sw $fp, 76($sp)
	sw $v1, 80($sp)
	sw $s5, 84($sp)
	sw $s6, 88($sp)
	sw $s7, 92($sp)
	sw $t2, 96($sp)
	sw $t3, 100($sp)
	sw $t4, 104($sp)
	sw $t5, 108($sp)
	sw $t6, 112($sp)
	sw $t7, 116($sp)
	sw $t8, 120($sp)
	sw $t9, 124($sp)
	sw $s0, 128($sp)
	sw $s1, 132($sp)
	sw $s2, 136($sp)
	sw $s3, 140($sp)
	sw $s4, 144($sp)
	sw $k0, 148($sp)
	sw $ra, 184($sp)
label_152:
	li $t1, 5
	move $k0, $t1
	li $t1, 0
	move $k0, $t1
	li $t1, 0
	sne $k0, $k0, $t1
	beqz $k0, label_156
	b label_154
label_154:
	div $k0, $k0, $k0
	li $t1, 1
	sne $k0, $k0, $t1
	beqz $k0, label_156
	b label_155
label_155:
	li $t1, 1
	move $k0, $t1
	b label_157
label_156:
	li $t1, 0
	move $k0, $t1
	b label_157
label_157:
	move $k0, $k0
	beqz $k0, label_159
	b label_158
label_158:
	li $t1, 10
	move $k0, $t1
	b label_160
label_159:
	li $t1, 20
	move $k0, $t1
	b label_160
label_160:
	li $t1, 10
	seq $k0, $k0, $t1
	beqz $k0, label_163
	b label_161
label_161:
	div $k0, $k0, $k0
	li $t1, 0
	seq $k0, $k0, $t1
	beqz $k0, label_163
	b label_162
label_162:
	li $t1, 1
	move $k0, $t1
	b label_164
label_163:
	li $t1, 0
	move $k0, $t1
	b label_164
label_164:
	beqz $k0, label_167
	b label_165
label_165:
	li $t1, 5
	seq $k0, $k0, $t1
	beqz $k0, label_167
	b label_166
label_166:
	li $t1, 1
	move $k0, $t1
	b label_168
label_167:
	li $t1, 0
	move $k0, $t1
	b label_168
label_168:
	li $t1, 1
	xor $k0, $k0, $t1
	move $k0, $k0
	beqz $k0, label_170
	b label_169
label_169:
	li $t1, 30
	move $k0, $t1
	b label_170
label_170:
	move $v0, $k0
	b label_153
label_153:
	lw $ra, 184($sp)
	lw $k1, 68($sp)
	lw $gp, 72($sp)
	lw $fp, 76($sp)
	lw $v1, 80($sp)
	lw $s5, 84($sp)
	lw $s6, 88($sp)
	lw $s7, 92($sp)
	lw $t2, 96($sp)
	lw $t3, 100($sp)
	lw $t4, 104($sp)
	lw $t5, 108($sp)
	lw $t6, 112($sp)
	lw $t7, 116($sp)
	lw $t8, 120($sp)
	lw $t9, 124($sp)
	lw $s0, 128($sp)
	lw $s1, 132($sp)
	lw $s2, 136($sp)
	lw $s3, 140($sp)
	lw $s4, 144($sp)
	lw $k0, 148($sp)
	addu $sp, $sp, 192
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
