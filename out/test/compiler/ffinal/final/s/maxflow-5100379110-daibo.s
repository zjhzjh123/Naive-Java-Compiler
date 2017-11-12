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
label_662:
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
	sw $t1, global_5
	b label_664
label_664:
	lw $t0, global_5
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_667
	b label_665
label_665:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s4)
	lw $t0, global_5
	mul $s3, $t0, $k0
	lw $t0, global_0
	addu $s3, $t0, $s3
	sw $s4, 4($s3)
	li $t1, 0
	sw $t1, global_6
	b label_668
label_668:
	lw $t0, global_6
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_671
	b label_669
label_669:
	lw $t0, global_5
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_6
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, 0
	sw $t0, 4($s4)
label_670:
	lw $t1, global_6
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_6
	b label_668
label_671:
label_666:
	lw $t1, global_5
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_5
	b label_664
label_667:
label_663:
label_663:
	lw $ra, 192($sp)
	lw $s3, 148($sp)
	lw $s4, 152($sp)
	addu $sp, $sp, 200
	jr $ra
_build:
	sub $sp, $sp, 240
	sw $s3, 188($sp)
	sw $s4, 192($sp)
	sw $ra, 232($sp)
label_672:
	li $t1, 1
	sw $t1, global_5
	b label_674
label_674:
	lw $t0, global_5
	li $t1, 49
	sle $s4, $t0, $t1
	beqz $s4, label_677
	b label_675
label_675:
	li $t1, 50
	sw $t1, global_6
	b label_678
label_678:
	li $t1, 98
	move $s4, $t1
	lw $t1, global_5
	sub $s4, $s4, $t1
	addi $s4, $s4, 1
	lw $t0, global_6
	sle $s4, $t0, $s4
	beqz $s4, label_681
	b label_679
label_679:
	lw $t0, global_5
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_6
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	li $t0, 1
	sw $t0, 4($s4)
label_680:
	lw $t1, global_6
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_6
	b label_678
label_681:
label_676:
	lw $t1, global_5
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_5
	b label_674
label_677:
	li $t1, 1
	sw $t1, global_5
	b label_682
label_682:
	lw $t0, global_5
	li $t1, 49
	sle $s4, $t0, $t1
	beqz $s4, label_685
	b label_683
label_683:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_5
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, 1
	sw $t0, 4($s4)
label_684:
	lw $t1, global_5
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_5
	b label_682
label_685:
	li $t1, 50
	sw $t1, global_5
	b label_686
label_686:
	lw $t0, global_5
	li $t1, 98
	sle $s4, $t0, $t1
	beqz $s4, label_689
	b label_687
label_687:
	lw $t0, global_5
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	li $t0, 1
	sw $t0, 4($s4)
label_688:
	lw $t1, global_5
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_5
	b label_686
label_689:
	li $v0, 0
	b label_673
label_673:
	lw $ra, 232($sp)
	lw $s3, 188($sp)
	lw $s4, 192($sp)
	addu $sp, $sp, 240
	jr $ra
_find:
	sub $sp, $sp, 296
	sw $s3, 244($sp)
	sw $s4, 248($sp)
	sw $ra, 288($sp)
label_690:
	li $t1, 0
	sw $t1, global_7
	li $t1, 1
	sw $t1, global_8
	li $t1, 1
	sw $t1, global_5
	b label_692
label_692:
	lw $t0, global_5
	lw $t1, 0($sp)
	sle $s4, $t0, $t1
	beqz $s4, label_695
	b label_693
label_693:
	lw $t0, global_5
	mul $s4, $t0, $k0
	lw $t0, global_2
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
label_694:
	lw $t1, global_5
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_5
	b label_692
label_695:
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	lw $t0, 4($sp)
	sw $t0, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_2
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
	li $t1, 0
	sw $t1, 8($sp)
	b label_696
label_696:
	lw $t0, global_7
	lw $t1, global_8
	slt $s4, $t0, $t1
	beqz $s4, label_701
	b label_699
label_699:
	lw $t0, 8($sp)
	li $t1, 0
	seq $s4, $t0, $t1
	beqz $s4, label_701
	b label_700
label_700:
	li $t1, 1
	move $s4, $t1
	b label_702
label_701:
	li $t1, 0
	move $s4, $t1
	b label_702
label_702:
	beqz $s4, label_698
	b label_697
label_697:
	lw $t1, global_7
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_7
	lw $t0, global_7
	mul $s4, $t0, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	sw $s4, global_5
	li $t1, 1
	sw $t1, global_6
	b label_703
label_703:
	lw $t0, global_6
	lw $t1, 0($sp)
	sle $s4, $t0, $t1
	beqz $s4, label_706
	b label_704
label_704:
	lw $t0, global_5
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_6
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	li $t1, 0
	sgt $s4, $s4, $t1
	beqz $s4, label_711
	b label_709
label_709:
	lw $t0, global_6
	mul $s4, $t0, $k0
	lw $t0, global_2
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	seq $s4, $s4, $t1
	beqz $s4, label_711
	b label_710
label_710:
	li $t1, 1
	move $s4, $t1
	b label_712
label_711:
	li $t1, 0
	move $s4, $t1
	b label_712
label_712:
	beqz $s4, label_708
	b label_707
label_707:
	lw $t0, global_6
	mul $s4, $t0, $k0
	lw $t0, global_2
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	lw $t1, global_8
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_8
	lw $t0, global_8
	mul $s4, $t0, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	lw $t0, global_6
	sw $t0, 4($s4)
	lw $t0, global_6
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $t0, global_5
	sw $t0, 4($s4)
	lw $t0, global_8
	lw $t1, 0($sp)
	seq $s4, $t0, $t1
	beqz $s4, label_714
	b label_713
label_713:
	li $t1, 1
	sw $t1, 8($sp)
	b label_714
label_714:
	b label_708
label_708:
label_705:
	lw $t1, global_6
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_6
	b label_703
label_706:
	b label_696
label_698:
	lw $v0, 8($sp)
	b label_691
label_691:
	lw $ra, 288($sp)
	lw $s3, 244($sp)
	lw $s4, 248($sp)
	addu $sp, $sp, 296
	jr $ra
_improve:
	sub $sp, $sp, 220
	sw $s3, 168($sp)
	sw $s4, 172($sp)
	sw $ra, 212($sp)
label_715:
	lw $t1, 0($sp)
	sw $t1, global_5
	lw $t1, global_1
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_1
	b label_717
label_717:
	lw $t0, global_5
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	sgt $s4, $s4, $t1
	beqz $s4, label_719
	b label_718
label_718:
	lw $t0, global_5
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	sw $s4, global_6
	lw $t0, global_6
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_5
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s3, 4($s4)
	li $t1, 1
	sub $s3, $s3, $t1
	sw $s3, 4($s4)
	lw $t0, global_5
	mul $s4, $t0, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_6
	mul $s3, $t0, $k0
	addu $s3, $s4, $s3
	lw $s4, 4($s3)
	addi $s4, $s4, 1
	sw $s4, 4($s3)
	lw $t1, global_6
	sw $t1, global_5
	b label_717
label_719:
	li $v0, 0
	b label_716
label_716:
	lw $ra, 212($sp)
	lw $s3, 168($sp)
	lw $s4, 172($sp)
	addu $sp, $sp, 220
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 212
	sw $s1, 152($sp)
	sw $s2, 156($sp)
	sw $s3, 160($sp)
	sw $s4, 164($sp)
	sw $ra, 204($sp)
label_720:
	li $t1, 0
	sw $t1, global_1
	li $t0, 110
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 110
	sw $t0, 0($s4)
	sw $s4, global_2
	li $t0, 110
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 110
	sw $t0, 0($s4)
	sw $s4, global_3
	li $t0, 110
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 110
	sw $t0, 0($s4)
	sw $s4, global_4
	li $t1, 110
	sw $t1, -200($sp)
	jal _origin
	li $t1, 0
	move $s4, $t1
	li $t1, 99
	move $s2, $t1
	li $t1, 100
	move $s3, $t1
	li $t1, 0
	move $s1, $t1
	sw $s2, -240($sp)
	sw $s3, -236($sp)
	jal _build
	move $s4, $v0
	b label_722
label_722:
	sw $s3, -296($sp)
	sw $s2, -292($sp)
	sw $s1, -288($sp)
	jal _find
	move $s4, $v0
	li $t1, 0
	sgt $s4, $s4, $t1
	beqz $s4, label_724
	b label_723
label_723:
	sw $s3, -220($sp)
	jal _improve
	move $s4, $v0
	b label_722
label_724:
	lw $a0, global_1
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	li $v0, 0
	b label_721
label_721:
	lw $ra, 204($sp)
	lw $s1, 152($sp)
	lw $s2, 156($sp)
	lw $s3, 160($sp)
	lw $s4, 164($sp)
	addu $sp, $sp, 212
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
global_4:
.space 4
.align 2
global_5:
.space 4
.align 2
global_6:
.space 4
.align 2
global_7:
.space 4
.align 2
global_8:
.space 4
.align 2
