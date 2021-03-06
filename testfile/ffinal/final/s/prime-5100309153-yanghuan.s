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
label_1010:
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
	b label_1012
label_1012:
	lw $t0, global_2
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_1015
	b label_1013
label_1013:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s3, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s3)
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	li $t1, 0
	sw $t1, global_3
	b label_1016
label_1016:
	lw $t0, global_3
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_1019
	b label_1017
label_1017:
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
label_1018:
	lw $t1, global_3
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_3
	b label_1016
label_1019:
label_1014:
	lw $t1, global_2
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_2
	b label_1012
label_1015:
label_1011:
label_1011:
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
label_1020:
	li $t1, 2
	move $s1, $t1
	li $t1, 2
	move $s4, $t1
	b label_1022
label_1022:
	lw $t1, 0($sp)
	sle $s3, $s4, $t1
	beqz $s3, label_1025
	b label_1023
label_1023:
	mul $s3, $s4, $k0
	lw $t0, global_6
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t1, 1
	seq $s3, $s3, $t1
	beqz $s3, label_1027
	b label_1026
label_1026:
	li $t0, 0
	mul $s3, $t0, $k0
	lw $t0, global_9
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	addi $s3, $s3, 1
	li $t0, 0
	mul $s2, $t0, $k0
	lw $t0, global_9
	addu $s2, $t0, $s2
	sw $s3, 4($s2)
	li $t0, 0
	mul $s3, $t0, $k0
	lw $t0, global_9
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	mul $s3, $s3, $k0
	lw $t0, global_7
	addu $s3, $t0, $s3
	sw $s4, 4($s3)
	li $t0, 0
	mul $s3, $t0, $k0
	lw $t0, global_9
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	mul $s3, $s4, $k0
	lw $t0, global_8
	addu $s3, $t0, $s3
	sw $s2, 4($s3)
	b label_1027
label_1027:
	b label_1028
label_1028:
	mul $s3, $s4, $s1
	lw $t1, 0($sp)
	sle $s3, $s3, $t1
	beqz $s3, label_1030
	b label_1029
label_1029:
	mul $s3, $s4, $s1
	mul $s3, $s3, $k0
	lw $t0, global_6
	addu $s3, $t0, $s3
	li $t0, 0
	sw $t0, 4($s3)
	addi $s3, $s1, 1
	move $s1, $s3
	b label_1028
label_1030:
	li $t1, 2
	move $s1, $t1
label_1024:
	addi $s4, $s4, 1
	move $s4, $s4
	b label_1022
label_1025:
label_1021:
label_1021:
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
label_1031:
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
	beqz $s4, label_1034
	b label_1033
label_1033:
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
	beqz $s4, label_1036
	b label_1035
label_1035:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, 8($sp)
	mul $s3, $t0, $k0
	lw $t0, global_7
	addu $s3, $t0, $s3
	lw $s3, 4($s3)
	li $t1, 2
	mul $s3, $s3, $t1
	sub $s4, $s3, $s4
	mul $s4, $s4, $k0
	lw $t0, global_6
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	sne $s4, $s4, $t1
	beqz $s4, label_1038
	b label_1037
label_1037:
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
	b label_1038
label_1038:
	b label_1036
label_1036:
	b label_1034
label_1034:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 8($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	li $t1, -1
	seq $s4, $s4, $t1
	beqz $s4, label_1040
	b label_1039
label_1039:
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
	b label_1040
label_1040:
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
	b label_1032
label_1032:
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
label_1041:
	lw $a0, 0($sp)
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal print
	b label_1043
label_1043:
	lw $t0, 8($sp)
	li $t1, 0
	sgt $s4, $t0, $t1
	beqz $s4, label_1045
	b label_1044
label_1044:
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
	b label_1043
label_1045:
	la $a0, string_12
	jal print
label_1042:
label_1042:
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
label_1046:
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
	b label_1048
label_1048:
	lw $t0, global_0
	addi $s4, $t0, 1
	lw $t0, global_2
	slt $s4, $t0, $s4
	beqz $s4, label_1051
	b label_1049
label_1049:
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
label_1050:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_2
	b label_1048
label_1051:
	li $t1, 0
	sw $t1, global_2
	b label_1052
label_1052:
	lw $t0, global_1
	addi $s4, $t0, 1
	lw $t0, global_2
	slt $s4, $t0, $s4
	beqz $s4, label_1055
	b label_1053
label_1053:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
label_1054:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_2
	b label_1052
label_1055:
	li $t1, 0
	sw $t1, global_2
	b label_1056
label_1056:
	lw $t0, global_2
	lw $t1, global_1
	sle $s4, $t0, $t1
	beqz $s4, label_1059
	b label_1057
label_1057:
	li $t1, 0
	sw $t1, global_3
	b label_1060
label_1060:
	lw $t0, global_3
	lw $t1, global_1
	sle $s4, $t0, $t1
	beqz $s4, label_1063
	b label_1061
label_1061:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_3
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, -1
	sw $t0, 4($s4)
label_1062:
	lw $t0, global_3
	addi $s4, $t0, 1
	sw $s4, global_3
	b label_1060
label_1063:
label_1058:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_2
	b label_1056
label_1059:
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
	b label_1064
label_1064:
	lw $t0, global_2
	lw $t1, global_4
	slt $s4, $t0, $t1
	beqz $s4, label_1067
	b label_1065
label_1065:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_3
	b label_1068
label_1068:
	lw $t0, global_3
	lw $t1, global_4
	sle $s4, $t0, $t1
	beqz $s4, label_1071
	b label_1069
label_1069:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_3
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	li $t1, -1
	seq $s4, $s4, $t1
	beqz $s4, label_1073
	b label_1072
label_1072:
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
	lw $s3, 4($s4)
	lw $t0, global_3
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	li $t1, 1
	sgt $s4, $s4, $t1
	beqz $s4, label_1075
	b label_1074
label_1074:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_3
	mul $s4, $t0, $k0
	lw $t0, global_7
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_10
	addu $s4, $t0, $s4
	lw $s1, 4($s4)
	lw $t0, global_3
	mul $s4, $t0, $k0
	addu $s4, $s1, $s4
	lw $s4, 4($s4)
	sw $s3, -188($sp)
	sw $s2, -184($sp)
	sw $s4, -180($sp)
	jal _printF
	move $s4, $v0
	lw $t0, global_5
	addi $s4, $t0, 1
	sw $s4, global_5
	b label_1075
label_1075:
	b label_1073
label_1073:
label_1070:
	lw $t0, global_3
	addi $s4, $t0, 1
	sw $s4, global_3
	b label_1068
label_1071:
label_1066:
	lw $t0, global_2
	addi $s4, $t0, 1
	sw $s4, global_2
	b label_1064
label_1067:
	la $a0, string_13
	jal print
	lw $a0, global_5
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	li $v0, 0
	b label_1047
label_1047:
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
