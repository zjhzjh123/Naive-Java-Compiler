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
_printNum:
	sub $sp, $sp, 140
	sw $s4, 92($sp)
	sw $ra, 132($sp)
label_457:
	lw $a0, 0($sp)
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
label_458:
label_458:
	lw $ra, 132($sp)
	lw $s4, 92($sp)
	addu $sp, $sp, 140
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 504
	sw $s2, 448($sp)
	sw $s3, 452($sp)
	sw $s4, 456($sp)
	sw $ra, 496($sp)
label_459:
	li $t0, 4
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 4
	sw $t0, 0($s4)
	sw $s4, global_0
	li $t0, 5
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 5
	sw $t0, 0($s4)
	sw $s4, global_3
	li $t1, 0
	sw $t1, global_1
	b label_461
label_461:
	lw $t0, global_1
	li $t1, 4
	slt $s4, $t0, $t1
	beqz $s4, label_464
	b label_462
label_462:
	li $t0, 11
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s3, $v0
	li $t0, 11
	sw $t0, 0($s3)
	lw $t0, global_1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
label_463:
	lw $t1, global_1
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_1
	b label_461
label_464:
	li $t1, 0
	sw $t1, global_1
	b label_465
label_465:
	lw $t0, global_1
	li $t1, 4
	slt $s4, $t0, $t1
	beqz $s4, label_468
	b label_466
label_466:
	li $t1, 0
	sw $t1, global_2
	b label_469
label_469:
	lw $t0, global_2
	li $t1, 10
	slt $s4, $t0, $t1
	beqz $s4, label_472
	b label_470
label_470:
	lw $t0, global_1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_2
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, 888
	sw $t0, 4($s4)
label_471:
	lw $t1, global_2
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_2
	b label_469
label_472:
label_467:
	lw $t1, global_1
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_1
	b label_465
label_468:
	li $t1, 0
	sw $t1, global_1
	b label_473
label_473:
	lw $t0, global_1
	li $t1, 5
	slt $s4, $t0, $t1
	beqz $s4, label_476
	b label_474
label_474:
	li $t0, 2
	mul $s4, $t0, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s3, $v0
	lw $t0, global_1
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	lw $t0, global_1
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, -1
	sw $t0, 0($s4)
label_475:
	lw $t1, global_1
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_1
	b label_473
label_476:
	li $t0, 3
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	li $t0, 9
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	sw $s4, -140($sp)
	jal _printNum
	move $s4, $v0
	li $t1, 0
	sw $t1, global_1
	b label_477
label_477:
	lw $t0, global_1
	li $t1, 3
	sle $s4, $t0, $t1
	beqz $s4, label_480
	b label_478
label_478:
	li $t1, 0
	sw $t1, global_2
	b label_481
label_481:
	lw $t0, global_2
	li $t1, 9
	sle $s4, $t0, $t1
	beqz $s4, label_484
	b label_482
label_482:
	lw $t0, global_1
	li $t1, 10
	mul $s4, $t0, $t1
	lw $t1, global_2
	addu $s3, $s4, $t1
	lw $t0, global_1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_2
	mul $s2, $t0, $k0
	addu $s4, $s4, $s2
	sw $s3, 4($s4)
label_483:
	lw $t1, global_2
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_2
	b label_481
label_484:
label_479:
	lw $t1, global_1
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_1
	b label_477
label_480:
	li $t1, 0
	sw $t1, global_1
	b label_485
label_485:
	lw $t0, global_1
	li $t1, 3
	sle $s4, $t0, $t1
	beqz $s4, label_488
	b label_486
label_486:
	li $t1, 0
	sw $t1, global_2
	b label_489
label_489:
	lw $t0, global_2
	li $t1, 9
	sle $s4, $t0, $t1
	beqz $s4, label_492
	b label_490
label_490:
	lw $t0, global_1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_2
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	sw $s4, -140($sp)
	jal _printNum
	move $s4, $v0
label_491:
	lw $t1, global_2
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_2
	b label_489
label_492:
label_487:
	lw $t1, global_1
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_1
	b label_485
label_488:
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	li $t0, 10
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	li $t0, 0
	sw $t0, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 10
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	sw $s4, -140($sp)
	jal _printNum
	move $s4, $v0
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, -2
	sw $t0, 0($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	li $t0, 10
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	mul $s4, $s4, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, -10
	sw $t0, 0($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $s4, 0($s4)
	sw $s4, -140($sp)
	jal _printNum
	move $s4, $v0
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $s4, 0($s4)
	sw $s4, -140($sp)
	jal _printNum
	move $s4, $v0
	li $v0, 0
	b label_460
label_460:
	lw $ra, 496($sp)
	lw $s2, 448($sp)
	lw $s3, 452($sp)
	lw $s4, 456($sp)
	addu $sp, $sp, 504
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
global_3:
.space 4
.align 2
