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
_exchange:
	sub $sp, $sp, 180
	sw $s2, 124($sp)
	sw $s3, 128($sp)
	sw $s4, 132($sp)
	sw $ra, 172($sp)
label_770:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $s3, $s4
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	sw $s2, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
label_771:
label_771:
	lw $ra, 172($sp)
	lw $s2, 124($sp)
	lw $s3, 128($sp)
	lw $s4, 132($sp)
	addu $sp, $sp, 180
	jr $ra
_makeHeap:
	sub $sp, $sp, 256
	sw $s1, 196($sp)
	sw $s2, 200($sp)
	sw $s3, 204($sp)
	sw $s4, 208($sp)
	sw $ra, 248($sp)
label_772:
	lw $t0, global_0
	li $t1, 1
	sub $s4, $t0, $t1
	li $t1, 2
	div $s4, $s4, $t1
	move $s1, $s4
	li $t1, 0
	move $s4, $t1
	li $t1, 0
	move $s4, $t1
	b label_774
label_774:
	li $t1, 0
	sge $s4, $s1, $t1
	beqz $s4, label_776
	b label_775
label_775:
	li $t1, 2
	mul $s4, $s1, $t1
	move $s4, $s4
	li $t1, 2
	mul $s3, $s1, $t1
	addi $s3, $s3, 1
	lw $t1, global_0
	slt $s3, $s3, $t1
	beqz $s3, label_781
	b label_779
label_779:
	li $t1, 2
	mul $s3, $s1, $t1
	mul $s3, $s3, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	li $t1, 2
	mul $s3, $s1, $t1
	addi $s3, $s3, 1
	mul $s3, $s3, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	slt $s3, $s3, $s2
	beqz $s3, label_781
	b label_780
label_780:
	li $t1, 1
	move $s3, $t1
	b label_782
label_781:
	li $t1, 0
	move $s3, $t1
	b label_782
label_782:
	beqz $s3, label_778
	b label_777
label_777:
	li $t1, 2
	mul $s4, $s1, $t1
	addi $s4, $s4, 1
	move $s4, $s4
	b label_778
label_778:
	mul $s3, $s4, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	mul $s3, $s1, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	sgt $s3, $s3, $s2
	beqz $s3, label_784
	b label_783
label_783:
	sw $s1, -180($sp)
	sw $s4, -176($sp)
	jal _exchange
	b label_784
label_784:
	li $t1, 1
	sub $s4, $s1, $t1
	move $s1, $s4
	b label_774
label_776:
	li $v0, 0
	b label_773
label_773:
	lw $ra, 248($sp)
	lw $s1, 196($sp)
	lw $s2, 200($sp)
	lw $s3, 204($sp)
	lw $s4, 208($sp)
	addu $sp, $sp, 256
	jr $ra
_adjustHeap:
	sub $sp, $sp, 292
	sw $s0, 228($sp)
	sw $s1, 232($sp)
	sw $s2, 236($sp)
	sw $s3, 240($sp)
	sw $s4, 244($sp)
	sw $ra, 284($sp)
label_785:
	li $t1, 0
	move $s4, $t1
	li $t1, 0
	move $s2, $t1
	li $t1, 0
	move $s1, $t1
	b label_787
label_787:
	li $t1, 2
	mul $s4, $s1, $t1
	lw $t1, 0($sp)
	slt $s4, $s4, $t1
	beqz $s4, label_789
	b label_788
label_788:
	li $t1, 2
	mul $s4, $s1, $t1
	move $s2, $s4
	li $t1, 2
	mul $s4, $s1, $t1
	addi $s4, $s4, 1
	lw $t1, 0($sp)
	slt $s4, $s4, $t1
	beqz $s4, label_794
	b label_792
label_792:
	li $t1, 2
	mul $s4, $s1, $t1
	mul $s4, $s4, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 2
	mul $s3, $s1, $t1
	addi $s3, $s3, 1
	mul $s3, $s3, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	slt $s4, $s3, $s4
	beqz $s4, label_794
	b label_793
label_793:
	li $t1, 1
	move $s4, $t1
	b label_795
label_794:
	li $t1, 0
	move $s4, $t1
	b label_795
label_795:
	beqz $s4, label_791
	b label_790
label_790:
	li $t1, 2
	mul $s4, $s1, $t1
	addi $s4, $s4, 1
	move $s2, $s4
	b label_791
label_791:
	mul $s4, $s2, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	mul $s3, $s1, $k0
	lw $t0, global_1
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	sgt $s4, $s3, $s4
	beqz $s4, label_797
	b label_796
label_796:
	mul $s4, $s1, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $s0, $s4
	mul $s4, $s2, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	mul $s4, $s1, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	mul $s4, $s2, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	sw $s0, 4($s4)
	move $s1, $s2
	b label_798
label_797:
	b label_789
label_798:
	b label_787
label_789:
	li $v0, 0
	b label_786
label_786:
	lw $ra, 284($sp)
	lw $s0, 228($sp)
	lw $s1, 232($sp)
	lw $s2, 236($sp)
	lw $s3, 240($sp)
	lw $s4, 244($sp)
	addu $sp, $sp, 292
	jr $ra
_heapSort:
	sub $sp, $sp, 212
	sw $s1, 152($sp)
	sw $s2, 156($sp)
	sw $s3, 160($sp)
	sw $s4, 164($sp)
	sw $ra, 204($sp)
label_799:
	li $t1, 0
	move $s3, $t1
	li $t1, 0
	move $s1, $t1
	b label_801
label_801:
	lw $t1, global_0
	slt $s4, $s1, $t1
	beqz $s4, label_804
	b label_802
label_802:
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $s3, $s4
	lw $t0, global_0
	sub $s4, $t0, $s1
	li $t1, 1
	sub $s4, $s4, $t1
	mul $s4, $s4, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t0, 0
	mul $s2, $t0, $k0
	lw $t0, global_1
	addu $s2, $t0, $s2
	sw $s4, 4($s2)
	lw $t0, global_0
	sub $s4, $t0, $s1
	li $t1, 1
	sub $s4, $s4, $t1
	mul $s4, $s4, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	lw $t0, global_0
	sub $s4, $t0, $s1
	li $t1, 1
	sub $s4, $s4, $t1
	sw $s4, -292($sp)
	jal _adjustHeap
	move $s4, $v0
label_803:
	addi $s4, $s1, 1
	move $s1, $s4
	b label_801
label_804:
	li $v0, 0
	b label_800
label_800:
	lw $ra, 204($sp)
	lw $s1, 152($sp)
	lw $s2, 156($sp)
	lw $s3, 160($sp)
	lw $s4, 164($sp)
	addu $sp, $sp, 212
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 224
	sw $s3, 172($sp)
	sw $s4, 176($sp)
	sw $ra, 216($sp)
label_805:
	jal getString
	move $s4, $v0
	move $a0, $s4
	jal parseInt
	move $s4, $v0
	sw $s4, global_0
	lw $t0, global_0
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	lw $t0, global_0
	sw $t0, 0($s4)
	sw $s4, global_1
	li $t1, 0
	move $s3, $t1
	b label_807
label_807:
	lw $a0, global_1
	jal size
	move $s4, $v0
	slt $s4, $s3, $s4
	beqz $s4, label_810
	b label_808
label_808:
	mul $s4, $s3, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
label_809:
	addi $s4, $s3, 1
	move $s3, $s4
	b label_807
label_810:
	jal _makeHeap
	move $s4, $v0
	jal _heapSort
	move $s4, $v0
	li $t1, 0
	move $s3, $t1
	b label_811
label_811:
	lw $a0, global_1
	jal size
	move $s4, $v0
	slt $s4, $s3, $s4
	beqz $s4, label_814
	b label_812
label_812:
	mul $s4, $s3, $k0
	lw $t0, global_1
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	la $a1, string_2
	jal stringAdd
	move $s4, $v0
	move $a0, $s4
	jal print
label_813:
	addi $s4, $s3, 1
	move $s3, $s4
	b label_811
label_814:
	la $a0, string_3
	jal print
	li $v0, 0
	b label_806
label_806:
	lw $ra, 216($sp)
	lw $s3, 172($sp)
	lw $s4, 176($sp)
	addu $sp, $sp, 224
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
