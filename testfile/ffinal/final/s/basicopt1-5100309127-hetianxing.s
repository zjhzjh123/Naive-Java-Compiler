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
	sub $sp, $sp, 384
	sw $s0, 320($sp)
	sw $s1, 324($sp)
	sw $s2, 328($sp)
	sw $s3, 332($sp)
	sw $s4, 336($sp)
	sw $t7, 308($sp)
	sw $t8, 312($sp)
	sw $t9, 316($sp)
	sw $ra, 376($sp)
label_493:
	li $t0, 100
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 100
	sw $t0, 0($s4)
	move $s1, $s4
	li $t1, 0
	move $s2, $t1
	b label_495
label_495:
	li $t1, 100
	slt $s4, $s2, $t1
	beqz $s4, label_498
	b label_496
label_496:
	li $t0, 100
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 100
	sw $t0, 0($s4)
	mul $s3, $s2, $k0
	addu $s3, $s1, $s3
	sw $s4, 4($s3)
label_497:
	move $s4, $s2
	addi $s2, $s4, 1
	b label_495
label_498:
	li $t1, 0
	move $t9, $t1
	li $t1, 0
	move $s2, $t1
	b label_499
label_499:
	li $t1, 100
	slt $s4, $s2, $t1
	beqz $s4, label_502
	b label_500
label_500:
	li $t1, 0
	move $s4, $t1
	b label_503
label_503:
	li $t1, 100
	slt $s3, $s4, $t1
	beqz $s3, label_506
	b label_504
label_504:
	mul $s3, $s2, $k0
	addu $s3, $s1, $s3
	lw $s3, 4($s3)
	mul $s0, $s4, $k0
	addu $s3, $s3, $s0
	li $t0, 0
	sw $t0, 4($s3)
label_505:
	move $s4, $s4
	addi $s4, $s4, 1
	b label_503
label_506:
label_501:
	move $s4, $s2
	addi $s2, $s4, 1
	b label_499
label_502:
	li $t1, 0
	move $s2, $t1
	b label_507
label_507:
	li $t1, 100
	slt $s4, $s2, $t1
	beqz $s4, label_510
	b label_508
label_508:
	li $t1, 20
	sgt $s4, $s2, $t1
	beqz $s4, label_515
	b label_513
label_513:
	li $t1, 80
	slt $s4, $s2, $t1
	beqz $s4, label_515
	b label_514
label_514:
	li $t1, 1
	move $s4, $t1
	b label_516
label_515:
	li $t1, 0
	move $s4, $t1
	b label_516
label_516:
	beqz $s4, label_512
	b label_511
label_511:
	li $t1, 0
	move $s4, $t1
	b label_517
label_517:
	li $t1, 100
	slt $s3, $s4, $t1
	beqz $s3, label_520
	b label_518
label_518:
	li $t1, 5
	sgt $s3, $s4, $t1
	beqz $s3, label_523
	b label_524
label_523:
	li $t1, 90
	slt $s3, $s2, $t1
	beqz $s3, label_525
	b label_524
label_524:
	li $t1, 1
	move $s3, $t1
	b label_526
label_525:
	li $t1, 0
	move $s3, $t1
	b label_526
label_526:
	beqz $s3, label_522
	b label_521
label_521:
	mul $s3, $s4, $k0
	li $t1, 100
	div $s3, $s3, $t1
	move $t7, $s3
	mul $s3, $s4, $k0
	li $t1, 100
	rem $s3, $s3, $t1
	move $s0, $s3
	addi $t8, $s4, 50
	addu $s3, $s2, $t7
	mul $s3, $s3, $k0
	addu $s3, $s1, $s3
	lw $t7, 4($s3)
	mul $s3, $s0, $k0
	addu $s3, $t7, $s3
	sw $t8, 4($s3)
	b label_522
label_522:
label_519:
	move $s4, $s4
	addi $s4, $s4, 1
	b label_517
label_520:
	b label_512
label_512:
label_509:
	move $s4, $s2
	addi $s2, $s4, 1
	b label_507
label_510:
	li $t1, 0
	move $s2, $t1
	b label_527
label_527:
	li $t1, 100
	slt $s4, $s2, $t1
	beqz $s4, label_530
	b label_528
label_528:
	li $t1, 0
	move $s4, $t1
	b label_531
label_531:
	li $t1, 100
	slt $s3, $s4, $t1
	beqz $s3, label_534
	b label_532
label_532:
	mul $s3, $s2, $k0
	addu $s3, $s1, $s3
	lw $s0, 4($s3)
	mul $s3, $s4, $k0
	addu $s3, $s0, $s3
	lw $s3, 4($s3)
	addu $s3, $t9, $s3
	move $t9, $s3
label_533:
	move $s4, $s4
	addi $s4, $s4, 1
	b label_531
label_534:
label_529:
	move $s4, $s2
	addi $s2, $s4, 1
	b label_527
label_530:
	move $a0, $t9
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
label_494:
label_494:
	lw $ra, 376($sp)
	lw $s0, 320($sp)
	lw $s1, 324($sp)
	lw $s2, 328($sp)
	lw $s3, 332($sp)
	lw $s4, 336($sp)
	lw $t7, 308($sp)
	lw $t8, 312($sp)
	lw $t9, 316($sp)
	addu $sp, $sp, 384
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
