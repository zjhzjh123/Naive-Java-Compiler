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
label_564:
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
	b label_566
label_566:
	lw $t0, global_3
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_569
	b label_567
label_567:
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
	b label_570
label_570:
	lw $t0, global_4
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_573
	b label_571
label_571:
	lw $t0, global_3
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_4
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, 0
	sw $t0, 4($s4)
label_572:
	lw $t1, global_4
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_4
	b label_570
label_573:
label_568:
	lw $t1, global_3
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_3
	b label_566
label_569:
label_565:
label_565:
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
label_574:
	lw $t0, 4($sp)
	li $t1, 0
	sgt $s4, $t0, $t1
	beqz $s4, label_578
	b label_579
label_578:
	lw $t0, 4($sp)
	li $t1, 0
	slt $s4, $t0, $t1
	beqz $s4, label_580
	b label_579
label_579:
	li $t1, 1
	move $s4, $t1
	b label_581
label_580:
	li $t1, 0
	move $s4, $t1
	b label_581
label_581:
	beqz $s4, label_582
	b label_583
label_582:
	lw $t0, 0($sp)
	li $t1, 0
	seq $s4, $t0, $t1
	beqz $s4, label_584
	b label_583
label_583:
	li $t1, 1
	move $s4, $t1
	b label_585
label_584:
	li $t1, 0
	move $s4, $t1
	b label_585
label_585:
	beqz $s4, label_586
	b label_587
label_586:
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
	lw $s2, 4($s4)
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
	lw $s1, 4($s4)
	lw $t0, 0($sp)
	li $t1, 1
	sub $s4, $t0, $t1
	mul $s4, $s4, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s1
	addu $s4, $s4, $s2
	li $t1, 15
	seq $s4, $s4, $t1
	beqz $s4, label_588
	b label_587
label_587:
	li $t1, 1
	move $s4, $t1
	b label_589
label_588:
	li $t1, 0
	move $s4, $t1
	b label_589
label_589:
	beqz $s4, label_577
	b label_576
label_576:
	lw $t0, 0($sp)
	li $t1, 2
	seq $s4, $t0, $t1
	beqz $s4, label_595
	b label_593
label_593:
	lw $t0, 4($sp)
	li $t1, 2
	seq $s4, $t0, $t1
	beqz $s4, label_595
	b label_594
label_594:
	li $t1, 1
	move $s4, $t1
	b label_596
label_595:
	li $t1, 0
	move $s4, $t1
	b label_596
label_596:
	beqz $s4, label_591
	b label_590
label_590:
	li $t1, 45
	move $s4, $t1
	lw $t1, 8($sp)
	sub $s2, $s4, $t1
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 2
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	sw $s2, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 2
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s1, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s2, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 0
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	addu $s4, $s4, $s2
	addu $s4, $s4, $s1
	move $s3, $s4
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 2
	mul $s2, $t0, $k0
	addu $s4, $s4, $s2
	lw $s2, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 1
	mul $s1, $t0, $k0
	addu $s4, $s4, $s1
	lw $s1, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s0, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	addu $s4, $s0, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s1
	addu $s4, $s4, $s2
	seq $s4, $s4, $s3
	beqz $s4, label_601
	b label_599
label_599:
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 2
	mul $s2, $t0, $k0
	addu $s4, $s4, $s2
	lw $s2, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s1, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	addu $s4, $s1, $s4
	lw $s0, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s1, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	addu $s4, $s1, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s0
	addu $s4, $s4, $s2
	seq $s4, $s4, $s3
	beqz $s4, label_605
	b label_603
label_603:
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	lw $s4, 4($s4)
	li $t0, 1
	mul $s2, $t0, $k0
	lw $t0, global_0
	addu $s2, $t0, $s2
	lw $s1, 4($s2)
	li $t0, 0
	mul $s2, $t0, $k0
	addu $s2, $s1, $s2
	lw $s2, 4($s2)
	li $t0, 0
	mul $s1, $t0, $k0
	lw $t0, global_0
	addu $s1, $t0, $s1
	lw $s1, 4($s1)
	li $t0, 0
	mul $s0, $t0, $k0
	addu $s1, $s1, $s0
	lw $s1, 4($s1)
	addu $s2, $s1, $s2
	addu $s4, $s2, $s4
	seq $s4, $s4, $s3
	beqz $s4, label_609
	b label_607
label_607:
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 1
	mul $s2, $t0, $k0
	addu $s4, $s4, $s2
	lw $s2, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s1, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	addu $s4, $s1, $s4
	lw $s1, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s0, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	addu $s4, $s0, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s1
	addu $s4, $s4, $s2
	seq $s4, $s4, $s3
	beqz $s4, label_613
	b label_611
label_611:
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 2
	mul $s2, $t0, $k0
	addu $s4, $s4, $s2
	lw $s1, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	lw $s2, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s0, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	addu $s4, $s0, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s2
	addu $s4, $s4, $s1
	seq $s4, $s4, $s3
	beqz $s4, label_617
	b label_615
label_615:
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	lw $s2, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 1
	mul $s1, $t0, $k0
	addu $s4, $s4, $s1
	lw $s0, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s1, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	addu $s4, $s1, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s0
	addu $s4, $s4, $s2
	seq $s4, $s4, $s3
	beqz $s4, label_621
	b label_619
label_619:
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	lw $s1, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	lw $s2, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s0, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	addu $s4, $s0, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s2
	addu $s4, $s4, $s1
	seq $s4, $s4, $s3
	beqz $s4, label_621
	b label_620
label_620:
	li $t1, 1
	move $s4, $t1
	b label_622
label_621:
	li $t1, 0
	move $s4, $t1
	b label_622
label_622:
	beqz $s4, label_617
	b label_616
label_616:
	li $t1, 1
	move $s4, $t1
	b label_618
label_617:
	li $t1, 0
	move $s4, $t1
	b label_618
label_618:
	beqz $s4, label_613
	b label_612
label_612:
	li $t1, 1
	move $s4, $t1
	b label_614
label_613:
	li $t1, 0
	move $s4, $t1
	b label_614
label_614:
	beqz $s4, label_609
	b label_608
label_608:
	li $t1, 1
	move $s4, $t1
	b label_610
label_609:
	li $t1, 0
	move $s4, $t1
	b label_610
label_610:
	beqz $s4, label_605
	b label_604
label_604:
	li $t1, 1
	move $s4, $t1
	b label_606
label_605:
	li $t1, 0
	move $s4, $t1
	b label_606
label_606:
	beqz $s4, label_601
	b label_600
label_600:
	li $t1, 1
	move $s4, $t1
	b label_602
label_601:
	li $t1, 0
	move $s4, $t1
	b label_602
label_602:
	beqz $s4, label_598
	b label_597
label_597:
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
	move $s3, $t1
	b label_623
label_623:
	li $t1, 2
	sle $s4, $s3, $t1
	beqz $s4, label_626
	b label_624
label_624:
	li $t1, 0
	move $s2, $t1
	b label_627
label_627:
	li $t1, 2
	sle $s4, $s2, $t1
	beqz $s4, label_630
	b label_628
label_628:
	mul $s4, $s3, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	mul $s1, $s2, $k0
	addu $s4, $s4, $s1
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal print
	la $a0, string_5
	jal print
label_629:
	move $s4, $s2
	addi $s2, $s4, 1
	b label_627
label_630:
	la $a0, string_6
	jal print
label_625:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_623
label_626:
	la $a0, string_7
	jal print
	b label_598
label_598:
	b label_592
label_591:
	lw $t0, 4($sp)
	li $t1, 2
	seq $s4, $t0, $t1
	beqz $s4, label_632
	b label_631
label_631:
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
	lw $s3, 4($s4)
	li $t1, 15
	move $s4, $t1
	sub $s4, $s4, $s3
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
	lw $s4, 4($s4)
	lw $t0, 4($sp)
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	li $t1, 0
	sgt $s4, $s4, $t1
	beqz $s4, label_638
	b label_636
label_636:
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
	beqz $s4, label_642
	b label_640
label_640:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, 4($sp)
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	mul $s4, $s4, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	seq $s4, $s4, $t1
	beqz $s4, label_642
	b label_641
label_641:
	li $t1, 1
	move $s4, $t1
	b label_643
label_642:
	li $t1, 0
	move $s4, $t1
	b label_643
label_643:
	beqz $s4, label_638
	b label_637
label_637:
	li $t1, 1
	move $s4, $t1
	b label_639
label_638:
	li $t1, 0
	move $s4, $t1
	b label_639
label_639:
	beqz $s4, label_635
	b label_634
label_634:
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
	beqz $s4, label_645
	b label_644
label_644:
	lw $t0, 0($sp)
	addi $s2, $t0, 1
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	lw $t0, 8($sp)
	addu $s4, $t0, $s4
	sw $s2, -1524($sp)
	li $t1, 0
	sw $t1, -1520($sp)
	sw $s4, -1516($sp)
	jal _search
	move $s4, $v0
	b label_646
label_645:
	lw $t0, 4($sp)
	addi $s4, $t0, 1
	lw $t0, 0($sp)
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	lw $t0, 4($sp)
	mul $s2, $t0, $k0
	addu $s3, $s3, $s2
	lw $s3, 4($s3)
	lw $t0, 8($sp)
	addu $s3, $t0, $s3
	lw $t1, 0($sp)
	sw $t1, -1524($sp)
	sw $s4, -1520($sp)
	sw $s3, -1516($sp)
	jal _search
	move $s4, $v0
	b label_646
label_646:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, 4($sp)
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	mul $s4, $s4, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
	b label_635
label_635:
	b label_633
label_632:
	li $t1, 1
	move $s3, $t1
	b label_647
label_647:
	li $t1, 9
	sle $s4, $s3, $t1
	beqz $s4, label_650
	b label_648
label_648:
	mul $s4, $s3, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	seq $s4, $s4, $t1
	beqz $s4, label_652
	b label_651
label_651:
	mul $s4, $s3, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	sw $s3, 4($s4)
	lw $t0, 4($sp)
	li $t1, 2
	seq $s4, $t0, $t1
	beqz $s4, label_654
	b label_653
label_653:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	lw $t0, 8($sp)
	addu $s2, $t0, $s3
	sw $s4, -1524($sp)
	li $t1, 0
	sw $t1, -1520($sp)
	sw $s2, -1516($sp)
	jal _search
	move $s4, $v0
	b label_655
label_654:
	lw $t0, 4($sp)
	addi $s4, $t0, 1
	lw $t0, 8($sp)
	addu $s2, $t0, $s3
	lw $t1, 0($sp)
	sw $t1, -1524($sp)
	sw $s4, -1520($sp)
	sw $s2, -1516($sp)
	jal _search
	move $s4, $v0
	b label_655
label_655:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	li $t0, 0
	sw $t0, 4($s4)
	mul $s4, $s3, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
	b label_652
label_652:
label_649:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_647
label_650:
	b label_633
label_633:
	b label_592
label_592:
	b label_577
label_577:
label_575:
label_575:
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
label_656:
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
	b label_657
label_657:
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
