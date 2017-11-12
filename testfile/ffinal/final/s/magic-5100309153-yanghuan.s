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
_origin:
	sub $sp, $sp, 200
	sw $s3, 148($sp)
	sw $s4, 152($sp)
	sw $ra, 192($sp)
label_0:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s4)
	sw $s4, global_0
	li $t1, 0
	sw $t1, global_3
	b label_2
label_2:
	lw $t0, global_3
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_5
	b label_3
label_3:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s3, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s3)
	lw $t0, global_3
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	li $t1, 0
	sw $t1, global_4
	b label_6
label_6:
	lw $t0, global_4
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_9
	b label_7
label_7:
	lw $t0, global_3
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_4
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	li $t0, 0
	sw $t0, 4($s4)
label_8:
	lw $t1, global_4
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_4
	b label_6
label_9:
label_4:
	lw $t1, global_3
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_3
	b label_2
label_5:
label_1:
label_1:
	lw $ra, 192($sp)
	lw $s3, 148($sp)
	lw $s4, 152($sp)
	addu $sp, $sp, 200
	jr $ra
_search:
	sub $sp, $sp, 1524
	sw $s0, 1460($sp)
	sw $s1, 1464($sp)
	sw $s2, 1468($sp)
	sw $s3, 1472($sp)
	sw $s4, 1476($sp)
	sw $ra, 1516($sp)
label_10:
	lw $t0, 4($sp)
	li $t1, 0
	sgt $s4, $t0, $t1
	beqz $s4, label_14
	b label_15
label_14:
	lw $t0, 4($sp)
	li $t1, 0
	slt $s4, $t0, $t1
	beqz $s4, label_16
	b label_15
label_15:
	li $t1, 1
	move $s4, $t1
	b label_17
label_16:
	li $t1, 0
	move $s4, $t1
	b label_17
label_17:
	beqz $s4, label_18
	b label_19
label_18:
	lw $t0, 0($sp)
	li $t1, 0
	seq $s4, $t0, $t1
	beqz $s4, label_20
	b label_19
label_19:
	li $t1, 1
	move $s4, $t1
	b label_21
label_20:
	li $t1, 0
	move $s4, $t1
	b label_21
label_21:
	beqz $s4, label_22
	b label_23
label_22:
	lw $t0, 0($sp)
	li $t1, 1
	sub $s4, $t0, $t1
	mul $s4, $s4, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s1, 4($s4)
	lw $t0, 0($sp)
	li $t1, 1
	sub $s4, $t0, $t1
	mul $s4, $s4, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 1
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s3, 4($s4)
	lw $t0, 0($sp)
	li $t1, 1
	sub $s4, $t0, $t1
	mul $s4, $s4, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s3
	addu $s4, $s4, $s1
	li $t1, 15
	seq $s4, $s4, $t1
	beqz $s4, label_24
	b label_23
label_23:
	li $t1, 1
	move $s4, $t1
	b label_25
label_24:
	li $t1, 0
	move $s4, $t1
	b label_25
label_25:
	beqz $s4, label_13
	b label_12
label_12:
	lw $t0, 0($sp)
	li $t1, 2
	seq $s4, $t0, $t1
	beqz $s4, label_31
	b label_29
label_29:
	lw $t0, 4($sp)
	li $t1, 2
	seq $s4, $t0, $t1
	beqz $s4, label_31
	b label_30
label_30:
	li $t1, 1
	move $s4, $t1
	b label_32
label_31:
	li $t1, 0
	move $s4, $t1
	b label_32
label_32:
	beqz $s4, label_27
	b label_26
label_26:
	li $t1, 45
	move $s4, $t1
	lw $t1, 8($sp)
	sub $s4, $s4, $t1
	li $t0, 2
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	li $t0, 2
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	sw $s4, 4($s3)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s3, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	lw $s1, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 0
	mul $s2, $t0, $k0
	addu $s4, $s4, $s2
	lw $s4, 4($s4)
	addu $s4, $s4, $s1
	addu $s4, $s4, $s3
	move $s4, $s4
	li $t0, 1
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 2
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	lw $s1, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	lw $s2, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s0, 4($s3)
	li $t0, 0
	mul $s3, $t0, $k0
	addu $s3, $s0, $s3
	lw $s3, 4($s3)
	addu $s3, $s3, $s2
	addu $s3, $s3, $s1
	seq $s3, $s3, $s4
	beqz $s3, label_37
	b label_35
label_35:
	li $t0, 2
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	li $t0, 2
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	lw $s2, 4($s3)
	li $t0, 2
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s1, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	addu $s3, $s1, $s3
	lw $s1, 4($s3)
	li $t0, 2
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s0, 4($s3)
	li $t0, 0
	mul $s3, $t0, $k0
	addu $s3, $s0, $s3
	lw $s3, 4($s3)
	addu $s3, $s3, $s1
	addu $s3, $s3, $s2
	seq $s3, $s3, $s4
	beqz $s3, label_41
	b label_39
label_39:
	li $t0, 2
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 0
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	lw $s1, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	li $t0, 0
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	lw $s3, 4($s3)
	li $t0, 0
	mul $s2, $t0, $k0
	lw $t0, global_0
	addu $s2, $t0, $s2
	lw $s2, 4($s2)
	li $t0, 0
	mul $s0, $t0, $k0
	addu $s2, $s2, $s0
	lw $s2, 4($s2)
	addu $s3, $s2, $s3
	addu $s3, $s3, $s1
	seq $s3, $s3, $s4
	beqz $s3, label_45
	b label_43
label_43:
	li $t0, 2
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	lw $s2, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 1
	mul $s1, $t0, $k0
	addu $s3, $s3, $s1
	lw $s0, 4($s3)
	li $t0, 0
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s1, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	addu $s3, $s1, $s3
	lw $s3, 4($s3)
	addu $s3, $s3, $s0
	addu $s3, $s3, $s2
	seq $s3, $s3, $s4
	beqz $s3, label_49
	b label_47
label_47:
	li $t0, 2
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 2
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	lw $s0, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 2
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	lw $s1, 4($s3)
	li $t0, 0
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 2
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	lw $s3, 4($s3)
	addu $s3, $s3, $s1
	addu $s3, $s3, $s0
	seq $s3, $s3, $s4
	beqz $s3, label_53
	b label_51
label_51:
	li $t0, 2
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 2
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	lw $s1, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	lw $s2, 4($s3)
	li $t0, 0
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 0
	mul $s0, $t0, $k0
	addu $s3, $s3, $s0
	lw $s3, 4($s3)
	addu $s3, $s3, $s2
	addu $s3, $s3, $s1
	seq $s3, $s3, $s4
	beqz $s3, label_57
	b label_55
label_55:
	li $t0, 0
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	li $t0, 2
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	lw $s0, 4($s3)
	li $t0, 1
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t0, 1
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	lw $s3, 4($s3)
	li $t0, 2
	mul $s2, $t0, $k0
	lw $t0, global_0
	addu $s2, $t0, $s2
	lw $s2, 4($s2)
	li $t0, 0
	mul $s1, $t0, $k0
	addu $s2, $s2, $s1
	lw $s2, 4($s2)
	addu $s3, $s2, $s3
	addu $s3, $s3, $s0
	seq $s4, $s3, $s4
	beqz $s4, label_57
	b label_56
label_56:
	li $t1, 1
	move $s4, $t1
	b label_58
label_57:
	li $t1, 0
	move $s4, $t1
	b label_58
label_58:
	beqz $s4, label_53
	b label_52
label_52:
	li $t1, 1
	move $s4, $t1
	b label_54
label_53:
	li $t1, 0
	move $s4, $t1
	b label_54
label_54:
	beqz $s4, label_49
	b label_48
label_48:
	li $t1, 1
	move $s4, $t1
	b label_50
label_49:
	li $t1, 0
	move $s4, $t1
	b label_50
label_50:
	beqz $s4, label_45
	b label_44
label_44:
	li $t1, 1
	move $s4, $t1
	b label_46
label_45:
	li $t1, 0
	move $s4, $t1
	b label_46
label_46:
	beqz $s4, label_41
	b label_40
label_40:
	li $t1, 1
	move $s4, $t1
	b label_42
label_41:
	li $t1, 0
	move $s4, $t1
	b label_42
label_42:
	beqz $s4, label_37
	b label_36
label_36:
	li $t1, 1
	move $s4, $t1
	b label_38
label_37:
	li $t1, 0
	move $s4, $t1
	b label_38
label_38:
	beqz $s4, label_34
	b label_33
label_33:
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_2
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	addi $s4, $s4, 1
	li $t0, 0
	mul $s3, $t0, $k0
	lw $t0, global_2
	addu $s3, $t0, $s3
	sw $s4, 4($s3)
	li $t1, 0
	move $s4, $t1
	b label_59
label_59:
	li $t1, 2
	sle $s3, $s4, $t1
	beqz $s3, label_62
	b label_60
label_60:
	li $t1, 0
	move $s2, $t1
	b label_63
label_63:
	li $t1, 2
	sle $s3, $s2, $t1
	beqz $s3, label_66
	b label_64
label_64:
	mul $s3, $s4, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s1, 4($s3)
	mul $s3, $s2, $k0
	addu $s3, $s1, $s3
	lw $s3, 4($s3)
	move $a0, $s3
	jal toString
	move $s3, $v0
	move $a0, $s3
	jal print
	la $a0, string_5
	jal print
label_65:
	move $s3, $s2
	addi $s2, $s3, 1
	b label_63
label_66:
	la $a0, string_6
	jal print
label_61:
	move $s4, $s4
	addi $s4, $s4, 1
	b label_59
label_62:
	la $a0, string_7
	jal print
	b label_34
label_34:
	b label_28
label_27:
	lw $t0, 4($sp)
	li $t1, 2
	seq $s4, $t0, $t1
	beqz $s4, label_68
	b label_67
label_67:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 1
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s2, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 0
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	li $t1, 15
	move $s3, $t1
	sub $s4, $s3, $s4
	sub $s3, $s4, $s2
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, 4($sp)
	mul $s2, $t0, $k0
	addu $s4, $s4, $s2
	sw $s3, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	li $t1, 0
	sgt $s4, $s4, $t1
	beqz $s4, label_74
	b label_72
label_72:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	li $t1, 10
	slt $s4, $s4, $t1
	beqz $s4, label_78
	b label_76
label_76:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	mul $s4, $s4, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	seq $s4, $s4, $t1
	beqz $s4, label_78
	b label_77
label_77:
	li $t1, 1
	move $s4, $t1
	b label_79
label_78:
	li $t1, 0
	move $s4, $t1
	b label_79
label_79:
	beqz $s4, label_74
	b label_73
label_73:
	li $t1, 1
	move $s4, $t1
	b label_75
label_74:
	li $t1, 0
	move $s4, $t1
	b label_75
label_75:
	beqz $s4, label_71
	b label_70
label_70:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	mul $s4, $s4, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	lw $t0, 4($sp)
	li $t1, 2
	seq $s4, $t0, $t1
	beqz $s4, label_81
	b label_80
label_80:
	lw $t0, 0($sp)
	addi $s3, $t0, 1
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	lw $s4, 4($s4)
	lw $t0, 8($sp)
	addu $s4, $t0, $s4
	sw $s3, -1524($sp)
	li $t1, 0
	sw $t1, -1520($sp)
	sw $s4, -1516($sp)
	jal _search
	move $s4, $v0
	b label_82
label_81:
	lw $t0, 4($sp)
	addi $s2, $t0, 1
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, 4($sp)
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	lw $t0, 8($sp)
	addu $s4, $t0, $s4
	lw $t1, 0($sp)
	sw $t1, -1524($sp)
	sw $s2, -1520($sp)
	sw $s4, -1516($sp)
	jal _search
	move $s4, $v0
	b label_82
label_82:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	mul $s4, $s4, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
	b label_71
label_71:
	b label_69
label_68:
	li $t1, 1
	move $s4, $t1
	b label_83
label_83:
	li $t1, 9
	sle $s3, $s4, $t1
	beqz $s3, label_86
	b label_84
label_84:
	mul $s3, $s4, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t1, 0
	seq $s3, $s3, $t1
	beqz $s3, label_88
	b label_87
label_87:
	mul $s3, $s4, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	li $t0, 1
	sw $t0, 4($s3)
	lw $t0, 0($sp)
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	lw $t0, 4($sp)
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	sw $s4, 4($s3)
	lw $t0, 4($sp)
	li $t1, 2
	seq $s3, $t0, $t1
	beqz $s3, label_90
	b label_89
label_89:
	lw $t0, 0($sp)
	addi $s3, $t0, 1
	lw $t0, 8($sp)
	addu $s2, $t0, $s4
	sw $s3, -1524($sp)
	li $t1, 0
	sw $t1, -1520($sp)
	sw $s2, -1516($sp)
	jal _search
	move $s3, $v0
	b label_91
label_90:
	lw $t0, 4($sp)
	addi $s2, $t0, 1
	lw $t0, 8($sp)
	addu $s3, $t0, $s4
	lw $t1, 0($sp)
	sw $t1, -1524($sp)
	sw $s2, -1520($sp)
	sw $s3, -1516($sp)
	jal _search
	move $s3, $v0
	b label_91
label_91:
	lw $t0, 0($sp)
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	lw $t0, 4($sp)
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	li $t0, 0
	sw $t0, 4($s3)
	mul $s3, $s4, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	li $t0, 0
	sw $t0, 4($s3)
	b label_88
label_88:
label_85:
	move $s4, $s4
	addi $s4, $s4, 1
	b label_83
label_86:
	b label_69
label_69:
	b label_28
label_28:
	b label_13
label_13:
label_11:
label_11:
	lw $ra, 1516($sp)
	lw $s0, 1460($sp)
	lw $s1, 1464($sp)
	lw $s2, 1468($sp)
	lw $s3, 1472($sp)
	lw $s4, 1476($sp)
	addu $sp, $sp, 1524
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 180
	sw $s4, 132($sp)
	sw $ra, 172($sp)
label_92:
	li $t0, 10
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 10
	sw $t0, 0($s4)
	sw $s4, global_1
	li $t0, 1
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 1
	sw $t0, 0($s4)
	sw $s4, global_2
	li $t1, 3
	sw $t1, -200($sp)
	jal _origin
	li $t1, 0
	sw $t1, -1524($sp)
	li $t1, 0
	sw $t1, -1520($sp)
	li $t1, 0
	sw $t1, -1516($sp)
	jal _search
	move $s4, $v0
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_2
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	li $v0, 0
	b label_93
label_93:
	lw $ra, 172($sp)
	lw $s4, 132($sp)
	addu $sp, $sp, 180
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 1
string_5:
.asciiz " "
.align 2
.word 1
string_6:
.asciiz "\n"
.align 2
.word 1
string_7:
.asciiz "\n"
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
global_4:
.space 4
.align 2
