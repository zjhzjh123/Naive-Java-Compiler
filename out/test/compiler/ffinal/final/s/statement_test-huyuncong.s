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
	li $k0, 4
	sub $sp, $sp, 456
	sw $s0, 392($sp)
	sw $s1, 396($sp)
	sw $s2, 400($sp)
	sw $s3, 404($sp)
	sw $s4, 408($sp)
	sw $t8, 384($sp)
	sw $t9, 388($sp)
	sw $ra, 448($sp)
label_914:
	li $t1, 0
	sw $t1, global_1
	jal getInt
	move $s4, $v0
	sw $s4, global_0
	lw $t0, global_0
	addi $s3, $t0, 5
	addi $s4, $s3, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	sw $s3, 0($s4)
	sw $s4, global_2
	li $t1, 0
	move $s4, $t1
	b label_916
label_916:
	lw $t1, global_0
	sle $s3, $s4, $t1
	beqz $s3, label_918
	b label_917
label_917:
	move $s3, $s4
	addi $s4, $s3, 1
	mul $s3, $s3, $k0
	lw $t0, global_2
	addu $s3, $t0, $s3
	li $t0, 1
	sw $t0, 4($s3)
	b label_916
label_918:
	lw $t0, global_0
	addi $s4, $t0, 5
	addi $s3, $s4, 1
	mul $s3, $s3, $k0
	move $a0, $s3
	li $v0, 9
	syscall
	move $s3, $v0
	sw $s4, 0($s3)
	move $s3, $s3
	lw $t0, global_0
	addi $s2, $t0, 5
	addi $s4, $s2, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	sw $s2, 0($s4)
	move $s2, $s4
	li $t0, 1
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	li $t0, 1
	sw $t0, 4($s4)
	li $t1, 2
	move $s4, $t1
	b label_919
label_919:
	li $t1, 1
	beqz $t1, label_922
	b label_920
label_920:
	lw $t1, global_0
	sgt $s1, $s4, $t1
	beqz $s1, label_924
	b label_923
label_923:
	b label_922
label_924:
	mul $s1, $s4, $k0
	lw $t0, global_2
	addu $s1, $t0, $s1
	lw $s1, 4($s1)
	beqz $s1, label_926
	b label_925
label_925:
	lw $t0, global_1
	addi $t1, $t0, 1
	sw $t1, global_1
	lw $t0, global_1
	mul $s1, $t0, $k0
	addu $s1, $s2, $s1
	sw $s4, 4($s1)
	li $t1, 1
	sub $s0, $s4, $t1
	mul $s1, $s4, $k0
	addu $s1, $s3, $s1
	sw $s0, 4($s1)
	b label_926
label_926:
	move $s0, $s4
	li $t1, 1
	move $t8, $t1
	b label_927
label_927:
	lw $t1, global_1
	sle $s1, $t8, $t1
	beqz $s1, label_933
	b label_931
label_931:
	mul $s1, $t8, $k0
	addu $s1, $s2, $s1
	lw $s1, 4($s1)
	mul $s1, $s0, $s1
	lw $t1, global_0
	sle $s1, $s1, $t1
	beqz $s1, label_933
	b label_932
label_932:
	li $t1, 1
	move $s1, $t1
	b label_934
label_933:
	li $t1, 0
	move $s1, $t1
	b label_934
label_934:
	beqz $s1, label_930
	b label_928
label_928:
	mul $s1, $t8, $k0
	addu $s1, $s2, $s1
	lw $s1, 4($s1)
	mul $s1, $s0, $s1
	move $t9, $s1
	lw $t1, global_0
	sgt $s1, $t9, $t1
	beqz $s1, label_936
	b label_935
label_935:
	b label_929
label_936:
	mul $s1, $t9, $k0
	lw $t0, global_2
	addu $s1, $t0, $s1
	li $t0, 0
	sw $t0, 4($s1)
	mul $s1, $t8, $k0
	addu $s1, $s2, $s1
	lw $s1, 4($s1)
	rem $s1, $s0, $s1
	li $t1, 0
	seq $s1, $s1, $t1
	beqz $s1, label_938
	b label_937
label_937:
	mul $s1, $t8, $k0
	addu $s1, $s2, $s1
	lw $t8, 4($s1)
	mul $s1, $s0, $k0
	addu $s1, $s3, $s1
	lw $s1, 4($s1)
	mul $s1, $s1, $t8
	mul $t9, $t9, $k0
	addu $t9, $s3, $t9
	sw $s1, 4($t9)
	b label_930
label_938:
	mul $s1, $t8, $k0
	addu $s1, $s2, $s1
	lw $s1, 4($s1)
	li $t1, 1
	sub $t9, $s1, $t1
	mul $s1, $s0, $k0
	addu $s1, $s3, $s1
	lw $s1, 4($s1)
	mul $t9, $s1, $t9
	mul $s1, $t8, $k0
	addu $s1, $s2, $s1
	lw $s1, 4($s1)
	mul $s1, $s0, $s1
	mul $s1, $s1, $k0
	addu $s1, $s3, $s1
	sw $t9, 4($s1)
	b label_939
label_939:
label_929:
	move $s1, $t8
	addi $t8, $s1, 1
	b label_927
label_930:
	mul $s1, $s0, $k0
	addu $s1, $s3, $s1
	lw $s1, 4($s1)
	move $a0, $s1
	jal toString
	move $s1, $v0
	move $a0, $s1
	jal println
label_921:
	addi $s4, $s4, 1
	b label_919
label_922:
	li $v0, 0
	b label_915
label_915:
	lw $ra, 448($sp)
	lw $s0, 392($sp)
	lw $s1, 396($sp)
	lw $s2, 400($sp)
	lw $s3, 404($sp)
	lw $s4, 408($sp)
	lw $t8, 384($sp)
	lw $t9, 388($sp)
	addu $sp, $sp, 456
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
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
