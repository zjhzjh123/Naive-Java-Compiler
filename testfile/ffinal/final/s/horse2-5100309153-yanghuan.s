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
_check:
	sub $sp, $sp, 148
	sw $s4, 100($sp)
	sw $ra, 140($sp)
label_565:
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_569
	b label_567
label_567:
	lw $t0, 0($sp)
	li $t1, 0
	sge $s4, $t0, $t1
	beqz $s4, label_569
	b label_568
label_568:
	li $t1, 1
	move $s4, $t1
	b label_570
label_569:
	li $t1, 0
	move $s4, $t1
	b label_570
label_570:
	move $v0, $s4
	b label_566
label_566:
	lw $ra, 140($sp)
	lw $s4, 100($sp)
	addu $sp, $sp, 148
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 1540
	sw $s6, 1436($sp)
	sw $s7, 1440($sp)
	sw $t2, 1444($sp)
	sw $t3, 1448($sp)
	sw $t4, 1452($sp)
	sw $t5, 1456($sp)
	sw $t6, 1460($sp)
	sw $t7, 1464($sp)
	sw $t8, 1468($sp)
	sw $t9, 1472($sp)
	sw $s0, 1476($sp)
	sw $s1, 1480($sp)
	sw $s2, 1484($sp)
	sw $s3, 1488($sp)
	sw $s4, 1492($sp)
	sw $ra, 1532($sp)
label_571:
	jal getInt
	move $s4, $v0
	move $s1, $s4
	li $t1, 0
	move $t2, $t1
	li $t1, 0
	move $t8, $t1
	li $t1, 0
	move $s3, $t1
	li $t1, 0
	move $t4, $t1
	li $t1, 1
	sub $s4, $s1, $t1
	move $s0, $s4
	move $s4, $s4
	li $t1, 0
	move $s7, $t1
	li $t1, 0
	move $t3, $t1
	li $t1, 0
	move $s2, $t1
	li $t1, 0
	move $t7, $t1
	mul $t7, $s1, $s1
	addi $t9, $t7, 1
	mul $t9, $t9, $k0
	move $a0, $t9
	li $v0, 9
	syscall
	move $t9, $v0
	sw $t7, 0($t9)
	move $t6, $t9
	li $t1, 0
	move $t7, $t1
	b label_573
label_573:
	mul $t9, $s1, $s1
	slt $t9, $t7, $t9
	beqz $t9, label_576
	b label_574
label_574:
	mul $t9, $t7, $k0
	addu $t9, $t6, $t9
	li $t0, 0
	sw $t0, 4($t9)
label_575:
	move $t9, $t7
	addi $t7, $t9, 1
	b label_573
label_576:
	mul $t7, $s1, $s1
	addi $t9, $t7, 1
	mul $t9, $t9, $k0
	move $a0, $t9
	li $v0, 9
	syscall
	move $t9, $v0
	sw $t7, 0($t9)
	move $t5, $t9
	li $t1, 0
	move $t7, $t1
	b label_577
label_577:
	mul $t9, $s1, $s1
	slt $t9, $t7, $t9
	beqz $t9, label_580
	b label_578
label_578:
	mul $t9, $t7, $k0
	addu $t9, $t5, $t9
	li $t0, 0
	sw $t0, 4($t9)
label_579:
	move $t9, $t7
	addi $t7, $t9, 1
	b label_577
label_580:
	addi $t9, $s1, 1
	mul $t9, $t9, $k0
	move $a0, $t9
	li $v0, 9
	syscall
	move $t9, $v0
	sw $s1, 0($t9)
	move $t9, $t9
	li $t1, 0
	move $t7, $t1
	b label_581
label_581:
	slt $t3, $t7, $s1
	beqz $t3, label_584
	b label_582
label_582:
	addi $t3, $s1, 1
	mul $t3, $t3, $k0
	move $a0, $t3
	li $v0, 9
	syscall
	move $s7, $v0
	sw $s1, 0($s7)
	mul $t3, $t7, $k0
	addu $t3, $t9, $t3
	sw $s7, 4($t3)
	li $t1, 0
	move $s7, $t1
	b label_585
label_585:
	slt $t3, $s7, $s1
	beqz $t3, label_588
	b label_586
label_586:
	mul $t3, $t7, $k0
	addu $t3, $t9, $t3
	lw $t3, 4($t3)
	mul $s6, $s7, $k0
	addu $t3, $t3, $s6
	li $t0, -1
	sw $t0, 4($t3)
label_587:
	move $t3, $s7
	addi $s7, $t3, 1
	b label_585
label_588:
label_583:
	move $t7, $t7
	addi $t7, $t7, 1
	b label_581
label_584:
	li $t0, 0
	mul $t7, $t0, $k0
	addu $t7, $t6, $t7
	sw $t8, 4($t7)
	li $t0, 0
	mul $t7, $t0, $k0
	addu $t7, $t5, $t7
	sw $t2, 4($t7)
	mul $t8, $t8, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $t7, $t2, $k0
	addu $t8, $t8, $t7
	lw $t8, 4($t8)
	li $t1, 0
	seq $t8, $t8, $t1
	b label_589
label_589:
	sle $t8, $t4, $s3
	beqz $t8, label_591
	b label_590
label_590:
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	mul $t8, $t8, $k0
	addu $t8, $t9, $t8
	lw $t7, 4($t8)
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	mul $t8, $t8, $k0
	addu $t8, $t7, $t8
	lw $t8, 4($t8)
	move $t7, $t8
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	li $t1, 1
	sub $t8, $t8, $t1
	move $t3, $t8
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	li $t1, 2
	sub $t8, $t8, $t1
	move $s7, $t8
	sw $t3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_596
	b label_594
label_594:
	sw $s7, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_600
	b label_598
label_598:
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $t2, $s7, $k0
	addu $t8, $t8, $t2
	lw $t8, 4($t8)
	li $t1, -1
	seq $t8, $t8, $t1
	beqz $t8, label_600
	b label_599
label_599:
	li $t1, 1
	move $t8, $t1
	b label_601
label_600:
	li $t1, 0
	move $t8, $t1
	b label_601
label_601:
	beqz $t8, label_596
	b label_595
label_595:
	li $t1, 1
	move $t8, $t1
	b label_597
label_596:
	li $t1, 0
	move $t8, $t1
	b label_597
label_597:
	beqz $t8, label_593
	b label_592
label_592:
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t8, $s3, $k0
	addu $t8, $t6, $t8
	sw $t3, 4($t8)
	mul $t8, $s3, $k0
	addu $t8, $t5, $t8
	sw $s7, 4($t8)
	addi $t2, $t7, 1
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $s6, 4($t8)
	mul $t8, $s7, $k0
	addu $t8, $s6, $t8
	sw $t2, 4($t8)
	seq $t8, $t3, $s4
	beqz $t8, label_606
	b label_604
label_604:
	seq $t8, $s7, $s0
	beqz $t8, label_606
	b label_605
label_605:
	li $t1, 1
	move $t8, $t1
	b label_607
label_606:
	li $t1, 0
	move $t8, $t1
	b label_607
label_607:
	beqz $t8, label_603
	b label_602
label_602:
	li $t1, 1
	move $s2, $t1
	b label_603
label_603:
	b label_593
label_593:
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	li $t1, 1
	sub $t8, $t8, $t1
	move $t3, $t8
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	addi $t8, $t8, 2
	move $s7, $t8
	sw $t3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_612
	b label_610
label_610:
	sw $s7, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_616
	b label_614
label_614:
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $t2, $s7, $k0
	addu $t8, $t8, $t2
	lw $t8, 4($t8)
	li $t1, -1
	seq $t8, $t8, $t1
	beqz $t8, label_616
	b label_615
label_615:
	li $t1, 1
	move $t8, $t1
	b label_617
label_616:
	li $t1, 0
	move $t8, $t1
	b label_617
label_617:
	beqz $t8, label_612
	b label_611
label_611:
	li $t1, 1
	move $t8, $t1
	b label_613
label_612:
	li $t1, 0
	move $t8, $t1
	b label_613
label_613:
	beqz $t8, label_609
	b label_608
label_608:
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t8, $s3, $k0
	addu $t8, $t6, $t8
	sw $t3, 4($t8)
	mul $t8, $s3, $k0
	addu $t8, $t5, $t8
	sw $s7, 4($t8)
	addi $t8, $t7, 1
	mul $t2, $t3, $k0
	addu $t2, $t9, $t2
	lw $t2, 4($t2)
	mul $s6, $s7, $k0
	addu $t2, $t2, $s6
	sw $t8, 4($t2)
	seq $t8, $t3, $s4
	beqz $t8, label_622
	b label_620
label_620:
	seq $t8, $s7, $s0
	beqz $t8, label_622
	b label_621
label_621:
	li $t1, 1
	move $t8, $t1
	b label_623
label_622:
	li $t1, 0
	move $t8, $t1
	b label_623
label_623:
	beqz $t8, label_619
	b label_618
label_618:
	li $t1, 1
	move $s2, $t1
	b label_619
label_619:
	b label_609
label_609:
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	addi $t8, $t8, 1
	move $t3, $t8
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	li $t1, 2
	sub $t8, $t8, $t1
	move $s7, $t8
	sw $t3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_628
	b label_626
label_626:
	sw $s7, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_632
	b label_630
label_630:
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $t2, $s7, $k0
	addu $t8, $t8, $t2
	lw $t8, 4($t8)
	li $t1, -1
	seq $t8, $t8, $t1
	beqz $t8, label_632
	b label_631
label_631:
	li $t1, 1
	move $t8, $t1
	b label_633
label_632:
	li $t1, 0
	move $t8, $t1
	b label_633
label_633:
	beqz $t8, label_628
	b label_627
label_627:
	li $t1, 1
	move $t8, $t1
	b label_629
label_628:
	li $t1, 0
	move $t8, $t1
	b label_629
label_629:
	beqz $t8, label_625
	b label_624
label_624:
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t8, $s3, $k0
	addu $t8, $t6, $t8
	sw $t3, 4($t8)
	mul $t8, $s3, $k0
	addu $t8, $t5, $t8
	sw $s7, 4($t8)
	addi $s6, $t7, 1
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t2, 4($t8)
	mul $t8, $s7, $k0
	addu $t8, $t2, $t8
	sw $s6, 4($t8)
	seq $t8, $t3, $s4
	beqz $t8, label_638
	b label_636
label_636:
	seq $t8, $s7, $s0
	beqz $t8, label_638
	b label_637
label_637:
	li $t1, 1
	move $t8, $t1
	b label_639
label_638:
	li $t1, 0
	move $t8, $t1
	b label_639
label_639:
	beqz $t8, label_635
	b label_634
label_634:
	li $t1, 1
	move $s2, $t1
	b label_635
label_635:
	b label_625
label_625:
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	addi $t8, $t8, 1
	move $t3, $t8
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	addi $t8, $t8, 2
	move $s7, $t8
	sw $t3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_644
	b label_642
label_642:
	sw $s7, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_648
	b label_646
label_646:
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t2, 4($t8)
	mul $t8, $s7, $k0
	addu $t8, $t2, $t8
	lw $t8, 4($t8)
	li $t1, -1
	seq $t8, $t8, $t1
	beqz $t8, label_648
	b label_647
label_647:
	li $t1, 1
	move $t8, $t1
	b label_649
label_648:
	li $t1, 0
	move $t8, $t1
	b label_649
label_649:
	beqz $t8, label_644
	b label_643
label_643:
	li $t1, 1
	move $t8, $t1
	b label_645
label_644:
	li $t1, 0
	move $t8, $t1
	b label_645
label_645:
	beqz $t8, label_641
	b label_640
label_640:
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t8, $s3, $k0
	addu $t8, $t6, $t8
	sw $t3, 4($t8)
	mul $t8, $s3, $k0
	addu $t8, $t5, $t8
	sw $s7, 4($t8)
	addi $s6, $t7, 1
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $t2, $s7, $k0
	addu $t8, $t8, $t2
	sw $s6, 4($t8)
	seq $t8, $t3, $s4
	beqz $t8, label_654
	b label_652
label_652:
	seq $t8, $s7, $s0
	beqz $t8, label_654
	b label_653
label_653:
	li $t1, 1
	move $t8, $t1
	b label_655
label_654:
	li $t1, 0
	move $t8, $t1
	b label_655
label_655:
	beqz $t8, label_651
	b label_650
label_650:
	li $t1, 1
	move $s2, $t1
	b label_651
label_651:
	b label_641
label_641:
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	li $t1, 2
	sub $t8, $t8, $t1
	move $t3, $t8
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	li $t1, 1
	sub $t8, $t8, $t1
	move $s7, $t8
	sw $t3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_660
	b label_658
label_658:
	sw $s7, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_664
	b label_662
label_662:
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $t2, $s7, $k0
	addu $t8, $t8, $t2
	lw $t8, 4($t8)
	li $t1, -1
	seq $t8, $t8, $t1
	beqz $t8, label_664
	b label_663
label_663:
	li $t1, 1
	move $t8, $t1
	b label_665
label_664:
	li $t1, 0
	move $t8, $t1
	b label_665
label_665:
	beqz $t8, label_660
	b label_659
label_659:
	li $t1, 1
	move $t8, $t1
	b label_661
label_660:
	li $t1, 0
	move $t8, $t1
	b label_661
label_661:
	beqz $t8, label_657
	b label_656
label_656:
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t8, $s3, $k0
	addu $t8, $t6, $t8
	sw $t3, 4($t8)
	mul $t8, $s3, $k0
	addu $t8, $t5, $t8
	sw $s7, 4($t8)
	addi $t2, $t7, 1
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $s6, 4($t8)
	mul $t8, $s7, $k0
	addu $t8, $s6, $t8
	sw $t2, 4($t8)
	seq $t8, $t3, $s4
	beqz $t8, label_670
	b label_668
label_668:
	seq $t8, $s7, $s0
	beqz $t8, label_670
	b label_669
label_669:
	li $t1, 1
	move $t8, $t1
	b label_671
label_670:
	li $t1, 0
	move $t8, $t1
	b label_671
label_671:
	beqz $t8, label_667
	b label_666
label_666:
	li $t1, 1
	move $s2, $t1
	b label_667
label_667:
	b label_657
label_657:
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	li $t1, 2
	sub $t8, $t8, $t1
	move $t3, $t8
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	addi $t8, $t8, 1
	move $s7, $t8
	sw $t3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_676
	b label_674
label_674:
	sw $s7, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_680
	b label_678
label_678:
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $t2, $s7, $k0
	addu $t8, $t8, $t2
	lw $t8, 4($t8)
	li $t1, -1
	seq $t8, $t8, $t1
	beqz $t8, label_680
	b label_679
label_679:
	li $t1, 1
	move $t8, $t1
	b label_681
label_680:
	li $t1, 0
	move $t8, $t1
	b label_681
label_681:
	beqz $t8, label_676
	b label_675
label_675:
	li $t1, 1
	move $t8, $t1
	b label_677
label_676:
	li $t1, 0
	move $t8, $t1
	b label_677
label_677:
	beqz $t8, label_673
	b label_672
label_672:
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t8, $s3, $k0
	addu $t8, $t6, $t8
	sw $t3, 4($t8)
	mul $t8, $s3, $k0
	addu $t8, $t5, $t8
	sw $s7, 4($t8)
	addi $s6, $t7, 1
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t2, 4($t8)
	mul $t8, $s7, $k0
	addu $t8, $t2, $t8
	sw $s6, 4($t8)
	seq $t8, $t3, $s4
	beqz $t8, label_686
	b label_684
label_684:
	seq $t8, $s7, $s0
	beqz $t8, label_686
	b label_685
label_685:
	li $t1, 1
	move $t8, $t1
	b label_687
label_686:
	li $t1, 0
	move $t8, $t1
	b label_687
label_687:
	beqz $t8, label_683
	b label_682
label_682:
	li $t1, 1
	move $s2, $t1
	b label_683
label_683:
	b label_673
label_673:
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	addi $t8, $t8, 2
	move $t3, $t8
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	li $t1, 1
	sub $t8, $t8, $t1
	move $s7, $t8
	sw $t3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_692
	b label_690
label_690:
	sw $s7, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_696
	b label_694
label_694:
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $t2, $s7, $k0
	addu $t8, $t8, $t2
	lw $t8, 4($t8)
	li $t1, -1
	seq $t8, $t8, $t1
	beqz $t8, label_696
	b label_695
label_695:
	li $t1, 1
	move $t8, $t1
	b label_697
label_696:
	li $t1, 0
	move $t8, $t1
	b label_697
label_697:
	beqz $t8, label_692
	b label_691
label_691:
	li $t1, 1
	move $t8, $t1
	b label_693
label_692:
	li $t1, 0
	move $t8, $t1
	b label_693
label_693:
	beqz $t8, label_689
	b label_688
label_688:
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t8, $s3, $k0
	addu $t8, $t6, $t8
	sw $t3, 4($t8)
	mul $t8, $s3, $k0
	addu $t8, $t5, $t8
	sw $s7, 4($t8)
	addi $t2, $t7, 1
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t8, 4($t8)
	mul $s6, $s7, $k0
	addu $t8, $t8, $s6
	sw $t2, 4($t8)
	seq $t8, $t3, $s4
	beqz $t8, label_702
	b label_700
label_700:
	seq $t8, $s7, $s0
	beqz $t8, label_702
	b label_701
label_701:
	li $t1, 1
	move $t8, $t1
	b label_703
label_702:
	li $t1, 0
	move $t8, $t1
	b label_703
label_703:
	beqz $t8, label_699
	b label_698
label_698:
	li $t1, 1
	move $s2, $t1
	b label_699
label_699:
	b label_689
label_689:
	mul $t8, $t4, $k0
	addu $t8, $t6, $t8
	lw $t8, 4($t8)
	addi $t8, $t8, 2
	move $t3, $t8
	mul $t8, $t4, $k0
	addu $t8, $t5, $t8
	lw $t8, 4($t8)
	addi $t8, $t8, 1
	move $s7, $t8
	sw $t3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_708
	b label_706
label_706:
	sw $s7, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t8, $v0
	beqz $t8, label_712
	b label_710
label_710:
	mul $t8, $t3, $k0
	addu $t8, $t9, $t8
	lw $t2, 4($t8)
	mul $t8, $s7, $k0
	addu $t8, $t2, $t8
	lw $t8, 4($t8)
	li $t1, -1
	seq $t8, $t8, $t1
	beqz $t8, label_712
	b label_711
label_711:
	li $t1, 1
	move $t8, $t1
	b label_713
label_712:
	li $t1, 0
	move $t8, $t1
	b label_713
label_713:
	beqz $t8, label_708
	b label_707
label_707:
	li $t1, 1
	move $t8, $t1
	b label_709
label_708:
	li $t1, 0
	move $t8, $t1
	b label_709
label_709:
	beqz $t8, label_705
	b label_704
label_704:
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t8, $s3, $k0
	addu $t8, $t6, $t8
	sw $t3, 4($t8)
	mul $t8, $s3, $k0
	addu $t8, $t5, $t8
	sw $s7, 4($t8)
	addi $t8, $t7, 1
	mul $t7, $t3, $k0
	addu $t7, $t9, $t7
	lw $t2, 4($t7)
	mul $t7, $s7, $k0
	addu $t7, $t2, $t7
	sw $t8, 4($t7)
	seq $t8, $t3, $s4
	beqz $t8, label_718
	b label_716
label_716:
	seq $t8, $s7, $s0
	beqz $t8, label_718
	b label_717
label_717:
	li $t1, 1
	move $t8, $t1
	b label_719
label_718:
	li $t1, 0
	move $t8, $t1
	b label_719
label_719:
	beqz $t8, label_715
	b label_714
label_714:
	li $t1, 1
	move $s2, $t1
	b label_715
label_715:
	b label_705
label_705:
	li $t1, 1
	seq $t8, $s2, $t1
	beqz $t8, label_721
	b label_720
label_720:
	b label_591
label_721:
	addi $t8, $t4, 1
	move $t4, $t8
	b label_589
label_591:
	li $t1, 1
	seq $s3, $s2, $t1
	beqz $s3, label_723
	b label_722
label_722:
	mul $s4, $s4, $k0
	addu $s4, $t9, $s4
	lw $s3, 4($s4)
	mul $s4, $s0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	b label_724
label_723:
	la $a0, string_0
	jal print
	b label_724
label_724:
	li $v0, 0
	b label_572
label_572:
	lw $ra, 1532($sp)
	lw $s6, 1436($sp)
	lw $s7, 1440($sp)
	lw $t2, 1444($sp)
	lw $t3, 1448($sp)
	lw $t4, 1452($sp)
	lw $t5, 1456($sp)
	lw $t6, 1460($sp)
	lw $t7, 1464($sp)
	lw $t8, 1468($sp)
	lw $t9, 1472($sp)
	lw $s0, 1476($sp)
	lw $s1, 1480($sp)
	lw $s2, 1484($sp)
	lw $s3, 1488($sp)
	lw $s4, 1492($sp)
	addu $sp, $sp, 1540
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 13
string_0:
.asciiz "no solution!\n"
.align 2
