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
label_779:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s4)
	sw $s4, global_10
	li $t1, 0
	sw $t1, global_2
	b label_781
label_781:
	lw $t0, global_2
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_784
	b label_782
label_782:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s4)
	lw $t0, global_2
	mul $s3, $t0, $k0
	lw $t0, global_10
	addu $s3, $t0, $s3
	sw $s4, 4($s3)
	li $t1, 0
	sw $t1, global_3
	b label_785
label_785:
	lw $t0, global_3
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_788
	b label_786
label_786:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_3
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	li $t0, 0
	sw $t0, 4($s4)
label_787:
	lw $t1, global_3
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_3
	b label_785
label_788:
label_783:
	lw $t1, global_2
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_2
	b label_781
label_784:
label_780:
label_780:
	lw $ra, 192($sp)
	lw $s3, 148($sp)
	lw $s4, 152($sp)
	addu $sp, $sp, 200
	jr $ra
_getPrime:
	sub $sp, $sp, 252
	sw $s1, 192($sp)
	sw $s2, 196($sp)
	sw $s3, 200($sp)
	sw $s4, 204($sp)
	sw $ra, 244($sp)
label_789:
	li $t1, 2
	move $s3, $t1
	li $t1, 2
	move $s1, $t1
	b label_791
label_791:
	lw $t1, 0($sp)
	sle $s4, $s1, $t1
	beqz $s4, label_794
	b label_792
label_792:
	mul $s4, $s1, $k0
	lw $t0, global_6
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 1
	seq $s4, $s4, $t1
	beqz $s4, label_796
	b label_795
label_795:
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_9
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	addi $s2, $s4, 1
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_9
	addu $s4, $t0, $s4
	sw $s2, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_9
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	mul $s4, $s4, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	sw $s1, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_9
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	mul $s4, $s1, $k0
	lw $t0, global_8
	addu $s4, $t0, $s4
	sw $s2, 4($s4)
	b label_796
label_796:
	b label_797
label_797:
	mul $s4, $s1, $s3
	lw $t1, 0($sp)
	sle $s4, $s4, $t1
	beqz $s4, label_799
	b label_798
label_798:
	mul $s4, $s1, $s3
	mul $s4, $s4, $k0
	lw $t0, global_6
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
	addi $s4, $s3, 1
	move $s3, $s4
	b label_797
label_799:
	li $t1, 2
	move $s3, $t1
label_793:
	addi $s4, $s1, 1
	move $s1, $s4
	b label_791
label_794:
label_790:
label_790:
	lw $ra, 244($sp)
	lw $s1, 192($sp)
	lw $s2, 196($sp)
	lw $s3, 200($sp)
	lw $s4, 204($sp)
	addu $sp, $sp, 252
	jr $ra
_getResult:
	sub $sp, $sp, 396
	sw $s2, 340($sp)
	sw $s3, 344($sp)
	sw $s4, 348($sp)
	sw $ra, 388($sp)
label_800:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, 8($sp)
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	li $t1, -1
	seq $s4, $s4, $t1
	beqz $s4, label_803
	b label_802
label_802:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 8($sp)
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 2
	mul $s4, $s4, $t1
	sub $s4, $s4, $s3
	lw $t1, 0($sp)
	sle $s4, $s4, $t1
	beqz $s4, label_805
	b label_804
label_804:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 8($sp)
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 2
	mul $s4, $s4, $t1
	sub $s4, $s4, $s3
	mul $s4, $s4, $k0
	lw $t0, global_6
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	sne $s4, $s4, $t1
	beqz $s4, label_807
	b label_806
label_806:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 8($sp)
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 2
	mul $s4, $s4, $t1
	sub $s4, $s4, $s3
	mul $s4, $s4, $k0
	lw $t0, global_8
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t1, 0($sp)
	sw $t1, -396($sp)
	lw $t1, 8($sp)
	sw $t1, -392($sp)
	sw $s4, -388($sp)
	jal _getResult
	move $s4, $v0
	addi $s3, $s4, 1
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	lw $t0, 8($sp)
	mul $s4, $t0, $k0
	addu $s4, $s2, $s4
	sw $s3, 4($s4)
	b label_807
label_807:
	b label_805
label_805:
	b label_803
label_803:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, 8($sp)
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	li $t1, -1
	seq $s4, $s4, $t1
	beqz $s4, label_809
	b label_808
label_808:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 8($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	li $t0, 1
	sw $t0, 4($s4)
	b label_809
label_809:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 8($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	move $v0, $s4
	b label_801
label_801:
	lw $ra, 388($sp)
	lw $s2, 340($sp)
	lw $s3, 344($sp)
	lw $s4, 348($sp)
	addu $sp, $sp, 396
	jr $ra
_printF:
	sub $sp, $sp, 188
	sw $s4, 140($sp)
	sw $ra, 180($sp)
label_810:
	lw $a0, 0($sp)
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal print
	b label_812
label_812:
	lw $t0, 8($sp)
	li $t1, 0
	sgt $s4, $t0, $t1
	beqz $s4, label_814
	b label_813
label_813:
	la $a0, string_11
	jal print
	lw $a0, 4($sp)
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal print
	lw $t0, 4($sp)
	li $t1, 2
	mul $s4, $t0, $t1
	lw $t1, 0($sp)
	sub $s4, $s4, $t1
	sw $s4, 4($sp)
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	addu $s4, $t0, $t1
	li $t1, 2
	div $s4, $s4, $t1
	sw $s4, 0($sp)
	lw $t0, 8($sp)
	li $t1, 1
	sub $s4, $t0, $t1
	sw $s4, 8($sp)
	b label_812
label_814:
	la $a0, string_12
	jal print
label_811:
label_811:
	lw $ra, 180($sp)
	lw $s4, 140($sp)
	addu $sp, $sp, 188
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 460
	sw $s1, 400($sp)
	sw $s2, 404($sp)
	sw $s3, 408($sp)
	sw $s4, 412($sp)
	sw $ra, 452($sp)
label_815:
	li $t0, 1001
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 1001
	sw $t0, 0($s4)
	sw $s4, global_6
	li $t0, 170
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 170
	sw $t0, 0($s4)
	sw $s4, global_7
	li $t0, 1001
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 1001
	sw $t0, 0($s4)
	sw $s4, global_8
	li $t0, 1
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 1
	sw $t0, 0($s4)
	sw $s4, global_9
	li $t1, 170
	sw $t1, -200($sp)
	jal _origin
	li $t1, 1000
	sw $t1, global_0
	jal getInt
	move $s4, $v0
	sw $s4, global_1
	li $t1, 0
	sw $t1, global_4
	li $t1, 0
	sw $t1, global_5
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_9
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
	li $t1, 0
	sw $t1, global_2
	b label_817
label_817:
	lw $t0, global_0
	addi $s4, $t0, 1
	lw $t0, global_2
	slt $s4, $t0, $s4
	beqz $s4, label_820
	b label_818
label_818:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_6
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_8
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
label_819:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_2
	b label_817
label_820:
	li $t1, 0
	sw $t1, global_2
	b label_821
label_821:
	lw $t0, global_1
	addi $s4, $t0, 1
	lw $t0, global_2
	slt $s4, $t0, $s4
	beqz $s4, label_824
	b label_822
label_822:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
label_823:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_2
	b label_821
label_824:
	li $t1, 0
	sw $t1, global_2
	b label_825
label_825:
	lw $t0, global_2
	lw $t1, global_1
	sle $s4, $t0, $t1
	beqz $s4, label_828
	b label_826
label_826:
	li $t1, 0
	sw $t1, global_3
	b label_829
label_829:
	lw $t0, global_3
	lw $t1, global_1
	sle $s4, $t0, $t1
	beqz $s4, label_832
	b label_830
label_830:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_3
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	li $t0, -1
	sw $t0, 4($s4)
label_831:
	lw $t0, global_3
	addi $s4, $t0, 1
	sw $s4, global_3
	b label_829
label_832:
label_827:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_2
	b label_825
label_828:
	lw $t1, global_0
	sw $t1, -252($sp)
	jal _getPrime
	move $s4, $v0
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_9
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	sw $s4, global_4
	li $t1, 1
	sw $t1, global_2
	b label_833
label_833:
	lw $t0, global_2
	lw $t1, global_4
	slt $s4, $t0, $t1
	beqz $s4, label_836
	b label_834
label_834:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_3
	b label_837
label_837:
	lw $t0, global_3
	lw $t1, global_4
	sle $s4, $t0, $t1
	beqz $s4, label_840
	b label_838
label_838:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_3
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	li $t1, -1
	seq $s4, $s4, $t1
	beqz $s4, label_842
	b label_841
label_841:
	lw $t1, global_0
	sw $t1, -396($sp)
	lw $t1, global_2
	sw $t1, -392($sp)
	lw $t1, global_3
	sw $t1, -388($sp)
	jal _getResult
	move $s2, $v0
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_3
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	sw $s2, 4($s4)
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_3
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	li $t1, 1
	sgt $s4, $s4, $t1
	beqz $s4, label_844
	b label_843
label_843:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	lw $t0, global_3
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_2
	mul $s3, $t0, $k0
	lw $t0, global_10
	addu $s3, $t0, $s3
	lw $s1, 4($s3)
	lw $t0, global_3
	mul $s3, $t0, $k0
	addu $s3, $s1, $s3
	lw $s3, 4($s3)
	sw $s2, -188($sp)
	sw $s4, -184($sp)
	sw $s3, -180($sp)
	jal _printF
	move $s4, $v0
	lw $t0, global_5
	addi $s4, $t0, 1
	sw $s4, global_5
	b label_844
label_844:
	b label_842
label_842:
label_839:
	lw $t0, global_3
	addi $s4, $t0, 1
	sw $s4, global_3
	b label_837
label_840:
label_835:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_2
	b label_833
label_836:
	la $a0, string_13
	jal print
	lw $a0, global_5
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	li $v0, 0
	b label_816
label_816:
	lw $ra, 452($sp)
	lw $s1, 400($sp)
	lw $s2, 404($sp)
	lw $s3, 408($sp)
	lw $s4, 412($sp)
	addu $sp, $sp, 460
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 1
string_11:
.asciiz " "
.align 2
.word 1
string_12:
.asciiz "\n"
.align 2
.word 7
string_13:
.asciiz "Total: "
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
global_9:
.space 4
.align 2
global_10:
.space 4
.align 2
