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
_qsrt:
	sub $sp, $sp, 284
	sw $s0, 220($sp)
	sw $s1, 224($sp)
	sw $s2, 228($sp)
	sw $s3, 232($sp)
	sw $s4, 236($sp)
	sw $t9, 216($sp)
	sw $ra, 276($sp)
label_845:
	lw $t1, 0($sp)
	move $s4, $t1
	lw $t1, 4($sp)
	move $s3, $t1
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	addu $s2, $t0, $t1
	li $t1, 2
	div $s2, $s2, $t1
	mul $s2, $s2, $k0
	lw $t0, global_0
	addu $s2, $t0, $s2
	lw $s2, 4($s2)
	move $s2, $s2
	b label_847
label_847:
	sle $s1, $s4, $s3
	beqz $s1, label_849
	b label_848
label_848:
	b label_850
label_850:
	mul $s1, $s4, $k0
	lw $t0, global_0
	addu $s1, $t0, $s1
	lw $s1, 4($s1)
	slt $s1, $s1, $s2
	beqz $s1, label_852
	b label_851
label_851:
	move $s4, $s4
	addi $s4, $s4, 1
	b label_850
label_852:
	b label_853
label_853:
	mul $s1, $s3, $k0
	lw $t0, global_0
	addu $s1, $t0, $s1
	lw $s1, 4($s1)
	sgt $s1, $s1, $s2
	beqz $s1, label_855
	b label_854
label_854:
	move $s3, $s3
	li $t1, 1
	sub $s3, $s3, $t1
	b label_853
label_855:
	sle $s1, $s4, $s3
	beqz $s1, label_857
	b label_856
label_856:
	mul $s1, $s4, $k0
	lw $t0, global_0
	addu $s1, $t0, $s1
	lw $s1, 4($s1)
	move $t9, $s1
	mul $s1, $s3, $k0
	lw $t0, global_0
	addu $s1, $t0, $s1
	lw $s0, 4($s1)
	mul $s1, $s4, $k0
	lw $t0, global_0
	addu $s1, $t0, $s1
	sw $s0, 4($s1)
	mul $s1, $s3, $k0
	lw $t0, global_0
	addu $s1, $t0, $s1
	sw $t9, 4($s1)
	move $s4, $s4
	addi $s4, $s4, 1
	move $s3, $s3
	li $t1, 1
	sub $s3, $s3, $t1
	b label_857
label_857:
	b label_847
label_849:
	lw $t0, 0($sp)
	slt $s2, $t0, $s3
	beqz $s2, label_859
	b label_858
label_858:
	lw $t1, 0($sp)
	sw $t1, -284($sp)
	sw $s3, -280($sp)
	jal _qsrt
	move $s3, $v0
	b label_859
label_859:
	lw $t1, 4($sp)
	slt $s3, $s4, $t1
	beqz $s3, label_861
	b label_860
label_860:
	sw $s4, -284($sp)
	lw $t1, 4($sp)
	sw $t1, -280($sp)
	jal _qsrt
	move $s4, $v0
	b label_861
label_861:
	li $v0, 0
	b label_846
label_846:
	lw $ra, 276($sp)
	lw $s0, 220($sp)
	lw $s1, 224($sp)
	lw $s2, 228($sp)
	lw $s3, 232($sp)
	lw $s4, 236($sp)
	lw $t9, 216($sp)
	addu $sp, $sp, 284
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 208
	sw $s2, 152($sp)
	sw $s3, 156($sp)
	sw $s4, 160($sp)
	sw $ra, 200($sp)
label_862:
	li $t0, 10100
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 10100
	sw $t0, 0($s4)
	sw $s4, global_0
	li $t1, 10000
	sw $t1, global_1
	li $t1, 1
	move $s3, $t1
	b label_864
label_864:
	lw $t1, global_1
	sle $s4, $s3, $t1
	beqz $s4, label_867
	b label_865
label_865:
	lw $t0, global_1
	addi $s4, $t0, 1
	sub $s2, $s4, $s3
	mul $s4, $s3, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	sw $s2, 4($s4)
label_866:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_864
label_867:
	li $t1, 1
	sw $t1, -284($sp)
	lw $t1, global_1
	sw $t1, -280($sp)
	jal _qsrt
	move $s4, $v0
	li $t1, 1
	move $s3, $t1
	b label_868
label_868:
	lw $t1, global_1
	sle $s4, $s3, $t1
	beqz $s4, label_871
	b label_869
label_869:
	mul $s4, $s3, $k0
	lw $t0, global_0
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal print
	la $a0, string_2
	jal print
label_870:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_868
label_871:
	la $a0, string_3
	jal print
	li $v0, 0
	b label_863
label_863:
	lw $ra, 200($sp)
	lw $s2, 152($sp)
	lw $s3, 156($sp)
	lw $s4, 160($sp)
	addu $sp, $sp, 208
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 1
string_2:
.asciiz " "
.align 2
.word 1
string_3:
.asciiz "\n"
.align 2
global_0:
.space 4
.align 2
global_1:
.space 4
.align 2
