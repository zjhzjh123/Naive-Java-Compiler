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
label_1085:
	li $t1, 0
	sw $t1, global_1
	li $t1, 0
	sw $t1, global_10
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s4)
	sw $s4, global_15
	li $t1, 0
	sw $t1, global_16
	b label_1087
label_1087:
	lw $t0, global_16
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_1090
	b label_1088
label_1088:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s4)
	lw $t0, global_16
	mul $s3, $t0, $k0
	lw $t0, global_15
	addu $s3, $t0, $s3
	sw $s4, 4($s3)
	li $t1, 0
	sw $t1, global_17
	b label_1091
label_1091:
	lw $t0, global_17
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_1094
	b label_1092
label_1092:
	lw $t0, global_16
	mul $s4, $t0, $k0
	lw $t0, global_15
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_17
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, 0
	sw $t0, 4($s4)
label_1093:
	lw $t1, global_17
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_17
	b label_1091
label_1094:
label_1089:
	lw $t1, global_16
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_16
	b label_1087
label_1090:
label_1086:
label_1086:
	lw $ra, 192($sp)
	lw $s3, 148($sp)
	lw $s4, 152($sp)
	addu $sp, $sp, 200
	jr $ra
_check:
	sub $sp, $sp, 144
	sw $s4, 96($sp)
	sw $ra, 136($sp)
label_1095:
	lw $t0, 0($sp)
	lw $t1, global_0
	slt $s4, $t0, $t1
	beqz $s4, label_1099
	b label_1097
label_1097:
	lw $t0, 0($sp)
	li $t1, 0
	sge $s4, $t0, $t1
	beqz $s4, label_1099
	b label_1098
label_1098:
	li $t1, 1
	move $s4, $t1
	b label_1100
label_1099:
	li $t1, 0
	move $s4, $t1
	b label_1100
label_1100:
	move $v0, $s4
	b label_1096
label_1096:
	lw $ra, 136($sp)
	lw $s4, 96($sp)
	addu $sp, $sp, 144
	jr $ra
_addList:
	sub $sp, $sp, 236
	sw $s2, 180($sp)
	sw $s3, 184($sp)
	sw $s4, 188($sp)
	sw $ra, 228($sp)
label_1101:
	lw $t1, 0($sp)
	sw $t1, -144($sp)
	jal _check
	move $s4, $v0
	beqz $s4, label_1107
	b label_1105
label_1105:
	lw $t1, 4($sp)
	sw $t1, -144($sp)
	jal _check
	move $s4, $v0
	beqz $s4, label_1111
	b label_1109
label_1109:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_15
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	li $t1, -1
	seq $s4, $s4, $t1
	beqz $s4, label_1111
	b label_1110
label_1110:
	li $t1, 1
	move $s4, $t1
	b label_1112
label_1111:
	li $t1, 0
	move $s4, $t1
	b label_1112
label_1112:
	beqz $s4, label_1107
	b label_1106
label_1106:
	li $t1, 1
	move $s4, $t1
	b label_1108
label_1107:
	li $t1, 0
	move $s4, $t1
	b label_1108
label_1108:
	beqz $s4, label_1104
	b label_1103
label_1103:
	lw $t1, global_10
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_10
	lw $t0, global_10
	mul $s4, $t0, $k0
	lw $t0, global_8
	addu $s4, $t0, $s4
	lw $t0, 0($sp)
	sw $t0, 4($s4)
	lw $t0, global_10
	mul $s4, $t0, $k0
	lw $t0, global_9
	addu $s4, $t0, $s4
	lw $t0, 4($sp)
	sw $t0, 4($s4)
	lw $t0, global_12
	addi $s2, $t0, 1
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_15
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	sw $s2, 4($s4)
	lw $t0, 0($sp)
	lw $t1, global_4
	seq $s4, $t0, $t1
	beqz $s4, label_1117
	b label_1115
label_1115:
	lw $t0, 4($sp)
	lw $t1, global_5
	seq $s4, $t0, $t1
	beqz $s4, label_1117
	b label_1116
label_1116:
	li $t1, 1
	move $s4, $t1
	b label_1118
label_1117:
	li $t1, 0
	move $s4, $t1
	b label_1118
label_1118:
	beqz $s4, label_1114
	b label_1113
label_1113:
	li $t1, 1
	sw $t1, global_11
	b label_1114
label_1114:
	b label_1104
label_1104:
label_1102:
label_1102:
	lw $ra, 228($sp)
	lw $s2, 180($sp)
	lw $s3, 184($sp)
	lw $s4, 188($sp)
	addu $sp, $sp, 236
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 496
	sw $s3, 444($sp)
	sw $s4, 448($sp)
	sw $ra, 488($sp)
label_1119:
	li $t0, 12000
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 12000
	sw $t0, 0($s4)
	sw $s4, global_8
	li $t0, 12000
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 12000
	sw $t0, 0($s4)
	sw $s4, global_9
	li $t0, 8
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 8
	sw $t0, 0($s4)
	sw $s4, global_13
	li $t0, 9
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 9
	sw $t0, 0($s4)
	sw $s4, global_14
	li $t1, 106
	sw $t1, -200($sp)
	jal _origin
	jal getInt
	move $s4, $v0
	sw $s4, global_0
	lw $t0, global_0
	li $t1, 1
	sub $s4, $t0, $t1
	sw $s4, global_5
	sw $s4, global_4
	li $t1, 0
	sw $t1, global_16
	b label_1121
label_1121:
	lw $t0, global_16
	lw $t1, global_0
	slt $s4, $t0, $t1
	beqz $s4, label_1124
	b label_1122
label_1122:
	li $t1, 0
	sw $t1, global_17
	b label_1125
label_1125:
	lw $t0, global_17
	lw $t1, global_0
	slt $s4, $t0, $t1
	beqz $s4, label_1128
	b label_1126
label_1126:
	lw $t0, global_16
	mul $s4, $t0, $k0
	lw $t0, global_15
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_17
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, -1
	sw $t0, 4($s4)
label_1127:
	lw $t1, global_17
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_17
	b label_1125
label_1128:
label_1123:
	lw $t1, global_16
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_16
	b label_1121
label_1124:
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	li $t0, -2
	sw $t0, 4($s4)
	li $t0, 0
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	li $t0, -1
	sw $t0, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	li $t0, -2
	sw $t0, 4($s4)
	li $t0, 1
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	li $t0, 2
	sw $t0, 4($s4)
	li $t0, 2
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	li $t0, -1
	sw $t0, 4($s4)
	li $t0, 3
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	li $t0, 2
	sw $t0, 4($s4)
	li $t0, 3
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	li $t0, 4
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	li $t0, -1
	sw $t0, 4($s4)
	li $t0, 4
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	li $t0, -2
	sw $t0, 4($s4)
	li $t0, 5
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	li $t0, -1
	sw $t0, 4($s4)
	li $t0, 5
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	li $t0, 2
	sw $t0, 4($s4)
	li $t0, 6
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	li $t0, 6
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	li $t0, -2
	sw $t0, 4($s4)
	li $t0, 7
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	li $t0, 1
	sw $t0, 4($s4)
	li $t0, 7
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	li $t0, 2
	sw $t0, 4($s4)
	b label_1129
label_1129:
	lw $t0, global_1
	lw $t1, global_10
	sle $s4, $t0, $t1
	beqz $s4, label_1131
	b label_1130
label_1130:
	lw $t0, global_1
	mul $s4, $t0, $k0
	lw $t0, global_8
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	sw $s4, global_6
	lw $t0, global_1
	mul $s4, $t0, $k0
	lw $t0, global_9
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	sw $s4, global_7
	lw $t0, global_6
	mul $s4, $t0, $k0
	lw $t0, global_15
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_7
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	sw $s4, global_12
	li $t1, 0
	sw $t1, global_17
	b label_1132
label_1132:
	lw $t0, global_17
	li $t1, 8
	slt $s4, $t0, $t1
	beqz $s4, label_1135
	b label_1133
label_1133:
	lw $t0, global_17
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_6
	addu $s3, $t0, $s4
	lw $t0, global_17
	mul $s4, $t0, $k0
	lw $t0, global_14
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_7
	addu $s4, $t0, $s4
	sw $s3, -236($sp)
	sw $s4, -232($sp)
	jal _addList
label_1134:
	lw $t1, global_17
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_17
	b label_1132
label_1135:
	lw $t0, global_11
	li $t1, 1
	seq $s4, $t0, $t1
	beqz $s4, label_1137
	b label_1136
label_1136:
	b label_1131
label_1137:
	lw $t1, global_1
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_1
	b label_1129
label_1131:
	lw $t0, global_11
	li $t1, 1
	seq $s4, $t0, $t1
	beqz $s4, label_1139
	b label_1138
label_1138:
	lw $t0, global_4
	mul $s4, $t0, $k0
	lw $t0, global_15
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_5
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	b label_1140
label_1139:
	la $a0, string_18
	jal print
	b label_1140
label_1140:
	li $v0, 0
	b label_1120
label_1120:
	lw $ra, 488($sp)
	lw $s3, 444($sp)
	lw $s4, 448($sp)
	addu $sp, $sp, 496
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 13
string_18:
.asciiz "no solution!\n"
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
global_11:
.space 4
.align 2
global_12:
.space 4
.align 2
global_13:
.space 4
.align 2
global_14:
.space 4
.align 2
global_15:
.space 4
.align 2
global_16:
.space 4
.align 2
global_17:
.space 4
.align 2
