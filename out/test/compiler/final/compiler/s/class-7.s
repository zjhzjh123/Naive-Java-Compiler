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
	sub $sp, $sp, 228
	sw $k1, 104($sp)
	sw $gp, 108($sp)
	sw $fp, 112($sp)
	sw $v1, 116($sp)
	sw $s5, 120($sp)
	sw $s6, 124($sp)
	sw $s7, 128($sp)
	sw $t2, 132($sp)
	sw $t3, 136($sp)
	sw $t4, 140($sp)
	sw $t5, 144($sp)
	sw $t6, 148($sp)
	sw $t7, 152($sp)
	sw $t8, 156($sp)
	sw $t9, 160($sp)
	sw $s0, 164($sp)
	sw $s1, 168($sp)
	sw $s2, 172($sp)
	sw $s3, 176($sp)
	sw $s4, 180($sp)
	sw $k0, 184($sp)
	sw $ra, 220($sp)
label_95:
	li $t0, 2
	li $t1, 4
	mul $k0, $t0, $t1
	move $a0, $k0
	li $v0, 9
	syscall
	move $k0, $v0
	move $s2, $k0
	move $s3, $s2
	li $t0, 1
	sw $t0, 0($s2)
	li $t1, 2
	move $k0, $t1
	b label_97
label_97:
	li $t1, 10
	sle $s4, $k0, $t1
	beqz $s4, label_100
	b label_98
label_98:
	li $t0, 2
	li $t1, 4
	mul $s4, $t0, $t1
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	sw $s4, 4($s2)
	lw $s4, 4($s2)
	move $s2, $s4
	sw $k0, 0($s2)
label_99:
	move $k0, $k0
	li $t1, 1
	addu $k0, $k0, $t1
	b label_97
label_100:
	lw $k0, 4($s3)
	lw $k0, 4($k0)
	lw $k0, 4($k0)
	lw $k0, 0($k0)
	lw $s4, 4($s3)
	lw $s4, 4($s4)
	lw $s2, 0($s4)
	lw $s4, 4($s3)
	lw $s4, 0($s4)
	lw $s3, 0($s3)
	addu $s4, $s3, $s4
	addu $s4, $s4, $s2
	addu $k0, $s4, $k0
	move $a0, $k0
	jal toString
	move $k0, $v0
	move $a0, $k0
	jal println
	li $v0, 0
	b label_96
label_96:
	lw $ra, 220($sp)
	lw $k1, 104($sp)
	lw $gp, 108($sp)
	lw $fp, 112($sp)
	lw $v1, 116($sp)
	lw $s5, 120($sp)
	lw $s6, 124($sp)
	lw $s7, 128($sp)
	lw $t2, 132($sp)
	lw $t3, 136($sp)
	lw $t4, 140($sp)
	lw $t5, 144($sp)
	lw $t6, 148($sp)
	lw $t7, 152($sp)
	lw $t8, 156($sp)
	lw $t9, 160($sp)
	lw $s0, 164($sp)
	lw $s1, 168($sp)
	lw $s2, 172($sp)
	lw $s3, 176($sp)
	lw $s4, 180($sp)
	lw $k0, 184($sp)
	addu $sp, $sp, 228
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
