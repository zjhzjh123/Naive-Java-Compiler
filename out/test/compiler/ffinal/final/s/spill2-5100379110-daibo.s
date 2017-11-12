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
_getcount:
	sub $sp, $sp, 144
	sw $ra, 136($sp)
label_910:
	li $t0, 0
	mul $t1, $t0, $k0
	sw $t1, 4($sp)
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	addu $t1, $t0, $t1
	sw $t1, 8($sp)
	lw $t0, 8($sp)
	lw $t1, 4($t0)
	sw $t1, 12($sp)
	lw $t0, 12($sp)
	addi $t1, $t0, 1
	sw $t1, 12($sp)
	lw $t0, 12($sp)
	lw $t1, 8($sp)
	sw $t0, 4($t1)
	lw $v0, 12($sp)
	b label_911
label_911:
	lw $ra, 136($sp)
	addu $sp, $sp, 144
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 10396
	sw $ra, 10388($sp)
label_912:
	li $t0, 1
	addi $t1, $t0, 1
	sw $t1, 1024($sp)
	lw $t0, 1024($sp)
	mul $t1, $t0, $k0
	sw $t1, 1028($sp)
	lw $a0, 1028($sp)
	li $v0, 9
	syscall
	sw $v0, 1032($sp)
	li $t0, 1
	lw $t1, 1032($sp)
	sw $t0, 0($t1)
	lw $t1, 1032($sp)
	sw $t1, global_0
	li $t0, 0
	mul $t1, $t0, $k0
	sw $t1, 1036($sp)
	lw $t0, global_0
	lw $t1, 1036($sp)
	addu $t1, $t0, $t1
	sw $t1, 1040($sp)
	li $t0, 0
	lw $t1, 1040($sp)
	sw $t0, 4($t1)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1044($sp)
	lw $t1, 1044($sp)
	sw $t1, 0($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1048($sp)
	lw $t1, 1048($sp)
	sw $t1, 4($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1052($sp)
	lw $t1, 1052($sp)
	sw $t1, 8($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1056($sp)
	lw $t1, 1056($sp)
	sw $t1, 12($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1060($sp)
	lw $t1, 1060($sp)
	sw $t1, 16($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1064($sp)
	lw $t1, 1064($sp)
	sw $t1, 20($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1068($sp)
	lw $t1, 1068($sp)
	sw $t1, 24($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1072($sp)
	lw $t1, 1072($sp)
	sw $t1, 28($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1076($sp)
	lw $t1, 1076($sp)
	sw $t1, 32($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1080($sp)
	lw $t1, 1080($sp)
	sw $t1, 36($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1084($sp)
	lw $t1, 1084($sp)
	sw $t1, 40($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1088($sp)
	lw $t1, 1088($sp)
	sw $t1, 44($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1092($sp)
	lw $t1, 1092($sp)
	sw $t1, 48($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1096($sp)
	lw $t1, 1096($sp)
	sw $t1, 52($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1100($sp)
	lw $t1, 1100($sp)
	sw $t1, 56($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1104($sp)
	lw $t1, 1104($sp)
	sw $t1, 60($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1108($sp)
	lw $t1, 1108($sp)
	sw $t1, 64($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1112($sp)
	lw $t1, 1112($sp)
	sw $t1, 68($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1116($sp)
	lw $t1, 1116($sp)
	sw $t1, 72($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1120($sp)
	lw $t1, 1120($sp)
	sw $t1, 76($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1124($sp)
	lw $t1, 1124($sp)
	sw $t1, 80($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1128($sp)
	lw $t1, 1128($sp)
	sw $t1, 84($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1132($sp)
	lw $t1, 1132($sp)
	sw $t1, 88($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1136($sp)
	lw $t1, 1136($sp)
	sw $t1, 92($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1140($sp)
	lw $t1, 1140($sp)
	sw $t1, 96($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1144($sp)
	lw $t1, 1144($sp)
	sw $t1, 100($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1148($sp)
	lw $t1, 1148($sp)
	sw $t1, 104($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1152($sp)
	lw $t1, 1152($sp)
	sw $t1, 108($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1156($sp)
	lw $t1, 1156($sp)
	sw $t1, 112($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1160($sp)
	lw $t1, 1160($sp)
	sw $t1, 116($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1164($sp)
	lw $t1, 1164($sp)
	sw $t1, 120($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1168($sp)
	lw $t1, 1168($sp)
	sw $t1, 124($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1172($sp)
	lw $t1, 1172($sp)
	sw $t1, 128($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1176($sp)
	lw $t1, 1176($sp)
	sw $t1, 132($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1180($sp)
	lw $t1, 1180($sp)
	sw $t1, 136($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1184($sp)
	lw $t1, 1184($sp)
	sw $t1, 140($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1188($sp)
	lw $t1, 1188($sp)
	sw $t1, 144($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1192($sp)
	lw $t1, 1192($sp)
	sw $t1, 148($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1196($sp)
	lw $t1, 1196($sp)
	sw $t1, 152($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1200($sp)
	lw $t1, 1200($sp)
	sw $t1, 156($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1204($sp)
	lw $t1, 1204($sp)
	sw $t1, 160($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1208($sp)
	lw $t1, 1208($sp)
	sw $t1, 164($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1212($sp)
	lw $t1, 1212($sp)
	sw $t1, 168($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1216($sp)
	lw $t1, 1216($sp)
	sw $t1, 172($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1220($sp)
	lw $t1, 1220($sp)
	sw $t1, 176($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1224($sp)
	lw $t1, 1224($sp)
	sw $t1, 180($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1228($sp)
	lw $t1, 1228($sp)
	sw $t1, 184($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1232($sp)
	lw $t1, 1232($sp)
	sw $t1, 188($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1236($sp)
	lw $t1, 1236($sp)
	sw $t1, 192($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1240($sp)
	lw $t1, 1240($sp)
	sw $t1, 196($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1244($sp)
	lw $t1, 1244($sp)
	sw $t1, 200($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1248($sp)
	lw $t1, 1248($sp)
	sw $t1, 204($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1252($sp)
	lw $t1, 1252($sp)
	sw $t1, 208($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1256($sp)
	lw $t1, 1256($sp)
	sw $t1, 212($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1260($sp)
	lw $t1, 1260($sp)
	sw $t1, 216($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1264($sp)
	lw $t1, 1264($sp)
	sw $t1, 220($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1268($sp)
	lw $t1, 1268($sp)
	sw $t1, 224($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1272($sp)
	lw $t1, 1272($sp)
	sw $t1, 228($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1276($sp)
	lw $t1, 1276($sp)
	sw $t1, 232($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1280($sp)
	lw $t1, 1280($sp)
	sw $t1, 236($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1284($sp)
	lw $t1, 1284($sp)
	sw $t1, 240($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1288($sp)
	lw $t1, 1288($sp)
	sw $t1, 244($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1292($sp)
	lw $t1, 1292($sp)
	sw $t1, 248($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1296($sp)
	lw $t1, 1296($sp)
	sw $t1, 252($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1300($sp)
	lw $t1, 1300($sp)
	sw $t1, 256($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1304($sp)
	lw $t1, 1304($sp)
	sw $t1, 260($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1308($sp)
	lw $t1, 1308($sp)
	sw $t1, 264($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1312($sp)
	lw $t1, 1312($sp)
	sw $t1, 268($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1316($sp)
	lw $t1, 1316($sp)
	sw $t1, 272($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1320($sp)
	lw $t1, 1320($sp)
	sw $t1, 276($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1324($sp)
	lw $t1, 1324($sp)
	sw $t1, 280($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1328($sp)
	lw $t1, 1328($sp)
	sw $t1, 284($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1332($sp)
	lw $t1, 1332($sp)
	sw $t1, 288($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1336($sp)
	lw $t1, 1336($sp)
	sw $t1, 292($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1340($sp)
	lw $t1, 1340($sp)
	sw $t1, 296($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1344($sp)
	lw $t1, 1344($sp)
	sw $t1, 300($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1348($sp)
	lw $t1, 1348($sp)
	sw $t1, 304($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1352($sp)
	lw $t1, 1352($sp)
	sw $t1, 308($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1356($sp)
	lw $t1, 1356($sp)
	sw $t1, 312($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1360($sp)
	lw $t1, 1360($sp)
	sw $t1, 316($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1364($sp)
	lw $t1, 1364($sp)
	sw $t1, 320($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1368($sp)
	lw $t1, 1368($sp)
	sw $t1, 324($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1372($sp)
	lw $t1, 1372($sp)
	sw $t1, 328($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1376($sp)
	lw $t1, 1376($sp)
	sw $t1, 332($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1380($sp)
	lw $t1, 1380($sp)
	sw $t1, 336($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1384($sp)
	lw $t1, 1384($sp)
	sw $t1, 340($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1388($sp)
	lw $t1, 1388($sp)
	sw $t1, 344($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1392($sp)
	lw $t1, 1392($sp)
	sw $t1, 348($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1396($sp)
	lw $t1, 1396($sp)
	sw $t1, 352($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1400($sp)
	lw $t1, 1400($sp)
	sw $t1, 356($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1404($sp)
	lw $t1, 1404($sp)
	sw $t1, 360($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1408($sp)
	lw $t1, 1408($sp)
	sw $t1, 364($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1412($sp)
	lw $t1, 1412($sp)
	sw $t1, 368($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1416($sp)
	lw $t1, 1416($sp)
	sw $t1, 372($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1420($sp)
	lw $t1, 1420($sp)
	sw $t1, 376($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1424($sp)
	lw $t1, 1424($sp)
	sw $t1, 380($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1428($sp)
	lw $t1, 1428($sp)
	sw $t1, 384($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1432($sp)
	lw $t1, 1432($sp)
	sw $t1, 388($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1436($sp)
	lw $t1, 1436($sp)
	sw $t1, 392($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1440($sp)
	lw $t1, 1440($sp)
	sw $t1, 396($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1444($sp)
	lw $t1, 1444($sp)
	sw $t1, 400($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1448($sp)
	lw $t1, 1448($sp)
	sw $t1, 404($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1452($sp)
	lw $t1, 1452($sp)
	sw $t1, 408($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1456($sp)
	lw $t1, 1456($sp)
	sw $t1, 412($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1460($sp)
	lw $t1, 1460($sp)
	sw $t1, 416($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1464($sp)
	lw $t1, 1464($sp)
	sw $t1, 420($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1468($sp)
	lw $t1, 1468($sp)
	sw $t1, 424($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1472($sp)
	lw $t1, 1472($sp)
	sw $t1, 428($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1476($sp)
	lw $t1, 1476($sp)
	sw $t1, 432($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1480($sp)
	lw $t1, 1480($sp)
	sw $t1, 436($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1484($sp)
	lw $t1, 1484($sp)
	sw $t1, 440($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1488($sp)
	lw $t1, 1488($sp)
	sw $t1, 444($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1492($sp)
	lw $t1, 1492($sp)
	sw $t1, 448($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1496($sp)
	lw $t1, 1496($sp)
	sw $t1, 452($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1500($sp)
	lw $t1, 1500($sp)
	sw $t1, 456($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1504($sp)
	lw $t1, 1504($sp)
	sw $t1, 460($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1508($sp)
	lw $t1, 1508($sp)
	sw $t1, 464($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1512($sp)
	lw $t1, 1512($sp)
	sw $t1, 468($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1516($sp)
	lw $t1, 1516($sp)
	sw $t1, 472($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1520($sp)
	lw $t1, 1520($sp)
	sw $t1, 476($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1524($sp)
	lw $t1, 1524($sp)
	sw $t1, 480($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1528($sp)
	lw $t1, 1528($sp)
	sw $t1, 484($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1532($sp)
	lw $t1, 1532($sp)
	sw $t1, 488($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1536($sp)
	lw $t1, 1536($sp)
	sw $t1, 492($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1540($sp)
	lw $t1, 1540($sp)
	sw $t1, 496($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1544($sp)
	lw $t1, 1544($sp)
	sw $t1, 500($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1548($sp)
	lw $t1, 1548($sp)
	sw $t1, 504($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1552($sp)
	lw $t1, 1552($sp)
	sw $t1, 508($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1556($sp)
	lw $t1, 1556($sp)
	sw $t1, 512($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1560($sp)
	lw $t1, 1560($sp)
	sw $t1, 516($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1564($sp)
	lw $t1, 1564($sp)
	sw $t1, 520($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1568($sp)
	lw $t1, 1568($sp)
	sw $t1, 524($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1572($sp)
	lw $t1, 1572($sp)
	sw $t1, 528($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1576($sp)
	lw $t1, 1576($sp)
	sw $t1, 532($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1580($sp)
	lw $t1, 1580($sp)
	sw $t1, 536($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1584($sp)
	lw $t1, 1584($sp)
	sw $t1, 540($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1588($sp)
	lw $t1, 1588($sp)
	sw $t1, 544($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1592($sp)
	lw $t1, 1592($sp)
	sw $t1, 548($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1596($sp)
	lw $t1, 1596($sp)
	sw $t1, 552($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1600($sp)
	lw $t1, 1600($sp)
	sw $t1, 556($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1604($sp)
	lw $t1, 1604($sp)
	sw $t1, 560($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1608($sp)
	lw $t1, 1608($sp)
	sw $t1, 564($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1612($sp)
	lw $t1, 1612($sp)
	sw $t1, 568($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1616($sp)
	lw $t1, 1616($sp)
	sw $t1, 572($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1620($sp)
	lw $t1, 1620($sp)
	sw $t1, 576($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1624($sp)
	lw $t1, 1624($sp)
	sw $t1, 580($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1628($sp)
	lw $t1, 1628($sp)
	sw $t1, 584($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1632($sp)
	lw $t1, 1632($sp)
	sw $t1, 588($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1636($sp)
	lw $t1, 1636($sp)
	sw $t1, 592($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1640($sp)
	lw $t1, 1640($sp)
	sw $t1, 596($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1644($sp)
	lw $t1, 1644($sp)
	sw $t1, 600($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1648($sp)
	lw $t1, 1648($sp)
	sw $t1, 604($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1652($sp)
	lw $t1, 1652($sp)
	sw $t1, 608($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1656($sp)
	lw $t1, 1656($sp)
	sw $t1, 612($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1660($sp)
	lw $t1, 1660($sp)
	sw $t1, 616($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1664($sp)
	lw $t1, 1664($sp)
	sw $t1, 620($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1668($sp)
	lw $t1, 1668($sp)
	sw $t1, 624($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1672($sp)
	lw $t1, 1672($sp)
	sw $t1, 628($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1676($sp)
	lw $t1, 1676($sp)
	sw $t1, 632($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1680($sp)
	lw $t1, 1680($sp)
	sw $t1, 636($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1684($sp)
	lw $t1, 1684($sp)
	sw $t1, 640($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1688($sp)
	lw $t1, 1688($sp)
	sw $t1, 644($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1692($sp)
	lw $t1, 1692($sp)
	sw $t1, 648($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1696($sp)
	lw $t1, 1696($sp)
	sw $t1, 652($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1700($sp)
	lw $t1, 1700($sp)
	sw $t1, 656($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1704($sp)
	lw $t1, 1704($sp)
	sw $t1, 660($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1708($sp)
	lw $t1, 1708($sp)
	sw $t1, 664($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1712($sp)
	lw $t1, 1712($sp)
	sw $t1, 668($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1716($sp)
	lw $t1, 1716($sp)
	sw $t1, 672($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1720($sp)
	lw $t1, 1720($sp)
	sw $t1, 676($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1724($sp)
	lw $t1, 1724($sp)
	sw $t1, 680($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1728($sp)
	lw $t1, 1728($sp)
	sw $t1, 684($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1732($sp)
	lw $t1, 1732($sp)
	sw $t1, 688($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1736($sp)
	lw $t1, 1736($sp)
	sw $t1, 692($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1740($sp)
	lw $t1, 1740($sp)
	sw $t1, 696($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1744($sp)
	lw $t1, 1744($sp)
	sw $t1, 700($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1748($sp)
	lw $t1, 1748($sp)
	sw $t1, 704($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1752($sp)
	lw $t1, 1752($sp)
	sw $t1, 708($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1756($sp)
	lw $t1, 1756($sp)
	sw $t1, 712($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1760($sp)
	lw $t1, 1760($sp)
	sw $t1, 716($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1764($sp)
	lw $t1, 1764($sp)
	sw $t1, 720($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1768($sp)
	lw $t1, 1768($sp)
	sw $t1, 724($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1772($sp)
	lw $t1, 1772($sp)
	sw $t1, 728($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1776($sp)
	lw $t1, 1776($sp)
	sw $t1, 732($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1780($sp)
	lw $t1, 1780($sp)
	sw $t1, 736($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1784($sp)
	lw $t1, 1784($sp)
	sw $t1, 740($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1788($sp)
	lw $t1, 1788($sp)
	sw $t1, 744($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1792($sp)
	lw $t1, 1792($sp)
	sw $t1, 748($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1796($sp)
	lw $t1, 1796($sp)
	sw $t1, 752($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1800($sp)
	lw $t1, 1800($sp)
	sw $t1, 756($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1804($sp)
	lw $t1, 1804($sp)
	sw $t1, 760($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1808($sp)
	lw $t1, 1808($sp)
	sw $t1, 764($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1812($sp)
	lw $t1, 1812($sp)
	sw $t1, 768($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1816($sp)
	lw $t1, 1816($sp)
	sw $t1, 772($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1820($sp)
	lw $t1, 1820($sp)
	sw $t1, 776($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1824($sp)
	lw $t1, 1824($sp)
	sw $t1, 780($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1828($sp)
	lw $t1, 1828($sp)
	sw $t1, 784($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1832($sp)
	lw $t1, 1832($sp)
	sw $t1, 788($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1836($sp)
	lw $t1, 1836($sp)
	sw $t1, 792($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1840($sp)
	lw $t1, 1840($sp)
	sw $t1, 796($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1844($sp)
	lw $t1, 1844($sp)
	sw $t1, 800($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1848($sp)
	lw $t1, 1848($sp)
	sw $t1, 804($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1852($sp)
	lw $t1, 1852($sp)
	sw $t1, 808($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1856($sp)
	lw $t1, 1856($sp)
	sw $t1, 812($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1860($sp)
	lw $t1, 1860($sp)
	sw $t1, 816($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1864($sp)
	lw $t1, 1864($sp)
	sw $t1, 820($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1868($sp)
	lw $t1, 1868($sp)
	sw $t1, 824($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1872($sp)
	lw $t1, 1872($sp)
	sw $t1, 828($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1876($sp)
	lw $t1, 1876($sp)
	sw $t1, 832($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1880($sp)
	lw $t1, 1880($sp)
	sw $t1, 836($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1884($sp)
	lw $t1, 1884($sp)
	sw $t1, 840($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1888($sp)
	lw $t1, 1888($sp)
	sw $t1, 844($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1892($sp)
	lw $t1, 1892($sp)
	sw $t1, 848($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1896($sp)
	lw $t1, 1896($sp)
	sw $t1, 852($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1900($sp)
	lw $t1, 1900($sp)
	sw $t1, 856($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1904($sp)
	lw $t1, 1904($sp)
	sw $t1, 860($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1908($sp)
	lw $t1, 1908($sp)
	sw $t1, 864($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1912($sp)
	lw $t1, 1912($sp)
	sw $t1, 868($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1916($sp)
	lw $t1, 1916($sp)
	sw $t1, 872($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1920($sp)
	lw $t1, 1920($sp)
	sw $t1, 876($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1924($sp)
	lw $t1, 1924($sp)
	sw $t1, 880($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1928($sp)
	lw $t1, 1928($sp)
	sw $t1, 884($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1932($sp)
	lw $t1, 1932($sp)
	sw $t1, 888($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1936($sp)
	lw $t1, 1936($sp)
	sw $t1, 892($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1940($sp)
	lw $t1, 1940($sp)
	sw $t1, 896($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1944($sp)
	lw $t1, 1944($sp)
	sw $t1, 900($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1948($sp)
	lw $t1, 1948($sp)
	sw $t1, 904($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1952($sp)
	lw $t1, 1952($sp)
	sw $t1, 908($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1956($sp)
	lw $t1, 1956($sp)
	sw $t1, 912($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1960($sp)
	lw $t1, 1960($sp)
	sw $t1, 916($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1964($sp)
	lw $t1, 1964($sp)
	sw $t1, 920($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1968($sp)
	lw $t1, 1968($sp)
	sw $t1, 924($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1972($sp)
	lw $t1, 1972($sp)
	sw $t1, 928($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1976($sp)
	lw $t1, 1976($sp)
	sw $t1, 932($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1980($sp)
	lw $t1, 1980($sp)
	sw $t1, 936($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1984($sp)
	lw $t1, 1984($sp)
	sw $t1, 940($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1988($sp)
	lw $t1, 1988($sp)
	sw $t1, 944($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1992($sp)
	lw $t1, 1992($sp)
	sw $t1, 948($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 1996($sp)
	lw $t1, 1996($sp)
	sw $t1, 952($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2000($sp)
	lw $t1, 2000($sp)
	sw $t1, 956($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2004($sp)
	lw $t1, 2004($sp)
	sw $t1, 960($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2008($sp)
	lw $t1, 2008($sp)
	sw $t1, 964($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2012($sp)
	lw $t1, 2012($sp)
	sw $t1, 968($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2016($sp)
	lw $t1, 2016($sp)
	sw $t1, 972($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2020($sp)
	lw $t1, 2020($sp)
	sw $t1, 976($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2024($sp)
	lw $t1, 2024($sp)
	sw $t1, 980($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2028($sp)
	lw $t1, 2028($sp)
	sw $t1, 984($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2032($sp)
	lw $t1, 2032($sp)
	sw $t1, 988($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2036($sp)
	lw $t1, 2036($sp)
	sw $t1, 992($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2040($sp)
	lw $t1, 2040($sp)
	sw $t1, 996($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2044($sp)
	lw $t1, 2044($sp)
	sw $t1, 1000($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2048($sp)
	lw $t1, 2048($sp)
	sw $t1, 1004($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2052($sp)
	lw $t1, 2052($sp)
	sw $t1, 1008($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2056($sp)
	lw $t1, 2056($sp)
	sw $t1, 1012($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2060($sp)
	lw $t1, 2060($sp)
	sw $t1, 1016($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _getcount
	sw $v0, 2064($sp)
	lw $t1, 2064($sp)
	sw $t1, 1020($sp)
	lw $a0, 0($sp)
	jal toString
	sw $v0, 2072($sp)
	lw $a0, 2072($sp)
	la $a1, string_1
	jal stringAdd
	sw $v0, 2080($sp)
	lw $a0, 2080($sp)
	jal print
	lw $a0, 4($sp)
	jal toString
	sw $v0, 2088($sp)
	lw $a0, 2088($sp)
	la $a1, string_2
	jal stringAdd
	sw $v0, 2096($sp)
	lw $a0, 2096($sp)
	jal print
	lw $a0, 8($sp)
	jal toString
	sw $v0, 2104($sp)
	lw $a0, 2104($sp)
	la $a1, string_3
	jal stringAdd
	sw $v0, 2112($sp)
	lw $a0, 2112($sp)
	jal print
	lw $a0, 12($sp)
	jal toString
	sw $v0, 2120($sp)
	lw $a0, 2120($sp)
	la $a1, string_4
	jal stringAdd
	sw $v0, 2128($sp)
	lw $a0, 2128($sp)
	jal print
	lw $a0, 16($sp)
	jal toString
	sw $v0, 2136($sp)
	lw $a0, 2136($sp)
	la $a1, string_5
	jal stringAdd
	sw $v0, 2144($sp)
	lw $a0, 2144($sp)
	jal print
	lw $a0, 20($sp)
	jal toString
	sw $v0, 2152($sp)
	lw $a0, 2152($sp)
	la $a1, string_6
	jal stringAdd
	sw $v0, 2160($sp)
	lw $a0, 2160($sp)
	jal print
	lw $a0, 24($sp)
	jal toString
	sw $v0, 2168($sp)
	lw $a0, 2168($sp)
	la $a1, string_7
	jal stringAdd
	sw $v0, 2176($sp)
	lw $a0, 2176($sp)
	jal print
	lw $a0, 28($sp)
	jal toString
	sw $v0, 2184($sp)
	lw $a0, 2184($sp)
	la $a1, string_8
	jal stringAdd
	sw $v0, 2192($sp)
	lw $a0, 2192($sp)
	jal print
	lw $a0, 32($sp)
	jal toString
	sw $v0, 2200($sp)
	lw $a0, 2200($sp)
	la $a1, string_9
	jal stringAdd
	sw $v0, 2208($sp)
	lw $a0, 2208($sp)
	jal print
	lw $a0, 36($sp)
	jal toString
	sw $v0, 2216($sp)
	lw $a0, 2216($sp)
	la $a1, string_10
	jal stringAdd
	sw $v0, 2224($sp)
	lw $a0, 2224($sp)
	jal print
	lw $a0, 40($sp)
	jal toString
	sw $v0, 2232($sp)
	lw $a0, 2232($sp)
	la $a1, string_11
	jal stringAdd
	sw $v0, 2240($sp)
	lw $a0, 2240($sp)
	jal print
	lw $a0, 44($sp)
	jal toString
	sw $v0, 2248($sp)
	lw $a0, 2248($sp)
	la $a1, string_12
	jal stringAdd
	sw $v0, 2256($sp)
	lw $a0, 2256($sp)
	jal print
	lw $a0, 48($sp)
	jal toString
	sw $v0, 2264($sp)
	lw $a0, 2264($sp)
	la $a1, string_13
	jal stringAdd
	sw $v0, 2272($sp)
	lw $a0, 2272($sp)
	jal print
	lw $a0, 52($sp)
	jal toString
	sw $v0, 2280($sp)
	lw $a0, 2280($sp)
	la $a1, string_14
	jal stringAdd
	sw $v0, 2288($sp)
	lw $a0, 2288($sp)
	jal print
	lw $a0, 56($sp)
	jal toString
	sw $v0, 2296($sp)
	lw $a0, 2296($sp)
	la $a1, string_15
	jal stringAdd
	sw $v0, 2304($sp)
	lw $a0, 2304($sp)
	jal print
	lw $a0, 60($sp)
	jal toString
	sw $v0, 2312($sp)
	lw $a0, 2312($sp)
	la $a1, string_16
	jal stringAdd
	sw $v0, 2320($sp)
	lw $a0, 2320($sp)
	jal print
	lw $a0, 64($sp)
	jal toString
	sw $v0, 2328($sp)
	lw $a0, 2328($sp)
	la $a1, string_17
	jal stringAdd
	sw $v0, 2336($sp)
	lw $a0, 2336($sp)
	jal print
	lw $a0, 68($sp)
	jal toString
	sw $v0, 2344($sp)
	lw $a0, 2344($sp)
	la $a1, string_18
	jal stringAdd
	sw $v0, 2352($sp)
	lw $a0, 2352($sp)
	jal print
	lw $a0, 72($sp)
	jal toString
	sw $v0, 2360($sp)
	lw $a0, 2360($sp)
	la $a1, string_19
	jal stringAdd
	sw $v0, 2368($sp)
	lw $a0, 2368($sp)
	jal print
	lw $a0, 76($sp)
	jal toString
	sw $v0, 2376($sp)
	lw $a0, 2376($sp)
	la $a1, string_20
	jal stringAdd
	sw $v0, 2384($sp)
	lw $a0, 2384($sp)
	jal print
	lw $a0, 80($sp)
	jal toString
	sw $v0, 2392($sp)
	lw $a0, 2392($sp)
	la $a1, string_21
	jal stringAdd
	sw $v0, 2400($sp)
	lw $a0, 2400($sp)
	jal print
	lw $a0, 84($sp)
	jal toString
	sw $v0, 2408($sp)
	lw $a0, 2408($sp)
	la $a1, string_22
	jal stringAdd
	sw $v0, 2416($sp)
	lw $a0, 2416($sp)
	jal print
	lw $a0, 88($sp)
	jal toString
	sw $v0, 2424($sp)
	lw $a0, 2424($sp)
	la $a1, string_23
	jal stringAdd
	sw $v0, 2432($sp)
	lw $a0, 2432($sp)
	jal print
	lw $a0, 92($sp)
	jal toString
	sw $v0, 2440($sp)
	lw $a0, 2440($sp)
	la $a1, string_24
	jal stringAdd
	sw $v0, 2448($sp)
	lw $a0, 2448($sp)
	jal print
	lw $a0, 96($sp)
	jal toString
	sw $v0, 2456($sp)
	lw $a0, 2456($sp)
	la $a1, string_25
	jal stringAdd
	sw $v0, 2464($sp)
	lw $a0, 2464($sp)
	jal print
	lw $a0, 100($sp)
	jal toString
	sw $v0, 2472($sp)
	lw $a0, 2472($sp)
	la $a1, string_26
	jal stringAdd
	sw $v0, 2480($sp)
	lw $a0, 2480($sp)
	jal print
	lw $a0, 104($sp)
	jal toString
	sw $v0, 2488($sp)
	lw $a0, 2488($sp)
	la $a1, string_27
	jal stringAdd
	sw $v0, 2496($sp)
	lw $a0, 2496($sp)
	jal print
	lw $a0, 108($sp)
	jal toString
	sw $v0, 2504($sp)
	lw $a0, 2504($sp)
	la $a1, string_28
	jal stringAdd
	sw $v0, 2512($sp)
	lw $a0, 2512($sp)
	jal print
	lw $a0, 112($sp)
	jal toString
	sw $v0, 2520($sp)
	lw $a0, 2520($sp)
	la $a1, string_29
	jal stringAdd
	sw $v0, 2528($sp)
	lw $a0, 2528($sp)
	jal print
	lw $a0, 116($sp)
	jal toString
	sw $v0, 2536($sp)
	lw $a0, 2536($sp)
	la $a1, string_30
	jal stringAdd
	sw $v0, 2544($sp)
	lw $a0, 2544($sp)
	jal print
	lw $a0, 120($sp)
	jal toString
	sw $v0, 2552($sp)
	lw $a0, 2552($sp)
	la $a1, string_31
	jal stringAdd
	sw $v0, 2560($sp)
	lw $a0, 2560($sp)
	jal print
	lw $a0, 124($sp)
	jal toString
	sw $v0, 2568($sp)
	lw $a0, 2568($sp)
	la $a1, string_32
	jal stringAdd
	sw $v0, 2576($sp)
	lw $a0, 2576($sp)
	jal print
	lw $a0, 128($sp)
	jal toString
	sw $v0, 2584($sp)
	lw $a0, 2584($sp)
	la $a1, string_33
	jal stringAdd
	sw $v0, 2592($sp)
	lw $a0, 2592($sp)
	jal print
	lw $a0, 132($sp)
	jal toString
	sw $v0, 2600($sp)
	lw $a0, 2600($sp)
	la $a1, string_34
	jal stringAdd
	sw $v0, 2608($sp)
	lw $a0, 2608($sp)
	jal print
	lw $a0, 136($sp)
	jal toString
	sw $v0, 2616($sp)
	lw $a0, 2616($sp)
	la $a1, string_35
	jal stringAdd
	sw $v0, 2624($sp)
	lw $a0, 2624($sp)
	jal print
	lw $a0, 140($sp)
	jal toString
	sw $v0, 2632($sp)
	lw $a0, 2632($sp)
	la $a1, string_36
	jal stringAdd
	sw $v0, 2640($sp)
	lw $a0, 2640($sp)
	jal print
	lw $a0, 144($sp)
	jal toString
	sw $v0, 2648($sp)
	lw $a0, 2648($sp)
	la $a1, string_37
	jal stringAdd
	sw $v0, 2656($sp)
	lw $a0, 2656($sp)
	jal print
	lw $a0, 148($sp)
	jal toString
	sw $v0, 2664($sp)
	lw $a0, 2664($sp)
	la $a1, string_38
	jal stringAdd
	sw $v0, 2672($sp)
	lw $a0, 2672($sp)
	jal print
	lw $a0, 152($sp)
	jal toString
	sw $v0, 2680($sp)
	lw $a0, 2680($sp)
	la $a1, string_39
	jal stringAdd
	sw $v0, 2688($sp)
	lw $a0, 2688($sp)
	jal print
	lw $a0, 156($sp)
	jal toString
	sw $v0, 2696($sp)
	lw $a0, 2696($sp)
	la $a1, string_40
	jal stringAdd
	sw $v0, 2704($sp)
	lw $a0, 2704($sp)
	jal print
	lw $a0, 160($sp)
	jal toString
	sw $v0, 2712($sp)
	lw $a0, 2712($sp)
	la $a1, string_41
	jal stringAdd
	sw $v0, 2720($sp)
	lw $a0, 2720($sp)
	jal print
	lw $a0, 164($sp)
	jal toString
	sw $v0, 2728($sp)
	lw $a0, 2728($sp)
	la $a1, string_42
	jal stringAdd
	sw $v0, 2736($sp)
	lw $a0, 2736($sp)
	jal print
	lw $a0, 168($sp)
	jal toString
	sw $v0, 2744($sp)
	lw $a0, 2744($sp)
	la $a1, string_43
	jal stringAdd
	sw $v0, 2752($sp)
	lw $a0, 2752($sp)
	jal print
	lw $a0, 172($sp)
	jal toString
	sw $v0, 2760($sp)
	lw $a0, 2760($sp)
	la $a1, string_44
	jal stringAdd
	sw $v0, 2768($sp)
	lw $a0, 2768($sp)
	jal print
	lw $a0, 176($sp)
	jal toString
	sw $v0, 2776($sp)
	lw $a0, 2776($sp)
	la $a1, string_45
	jal stringAdd
	sw $v0, 2784($sp)
	lw $a0, 2784($sp)
	jal print
	lw $a0, 180($sp)
	jal toString
	sw $v0, 2792($sp)
	lw $a0, 2792($sp)
	la $a1, string_46
	jal stringAdd
	sw $v0, 2800($sp)
	lw $a0, 2800($sp)
	jal print
	lw $a0, 184($sp)
	jal toString
	sw $v0, 2808($sp)
	lw $a0, 2808($sp)
	la $a1, string_47
	jal stringAdd
	sw $v0, 2816($sp)
	lw $a0, 2816($sp)
	jal print
	lw $a0, 188($sp)
	jal toString
	sw $v0, 2824($sp)
	lw $a0, 2824($sp)
	la $a1, string_48
	jal stringAdd
	sw $v0, 2832($sp)
	lw $a0, 2832($sp)
	jal print
	lw $a0, 192($sp)
	jal toString
	sw $v0, 2840($sp)
	lw $a0, 2840($sp)
	la $a1, string_49
	jal stringAdd
	sw $v0, 2848($sp)
	lw $a0, 2848($sp)
	jal print
	lw $a0, 196($sp)
	jal toString
	sw $v0, 2856($sp)
	lw $a0, 2856($sp)
	la $a1, string_50
	jal stringAdd
	sw $v0, 2864($sp)
	lw $a0, 2864($sp)
	jal print
	lw $a0, 200($sp)
	jal toString
	sw $v0, 2872($sp)
	lw $a0, 2872($sp)
	la $a1, string_51
	jal stringAdd
	sw $v0, 2880($sp)
	lw $a0, 2880($sp)
	jal print
	lw $a0, 204($sp)
	jal toString
	sw $v0, 2888($sp)
	lw $a0, 2888($sp)
	la $a1, string_52
	jal stringAdd
	sw $v0, 2896($sp)
	lw $a0, 2896($sp)
	jal print
	lw $a0, 208($sp)
	jal toString
	sw $v0, 2904($sp)
	lw $a0, 2904($sp)
	la $a1, string_53
	jal stringAdd
	sw $v0, 2912($sp)
	lw $a0, 2912($sp)
	jal print
	lw $a0, 212($sp)
	jal toString
	sw $v0, 2920($sp)
	lw $a0, 2920($sp)
	la $a1, string_54
	jal stringAdd
	sw $v0, 2928($sp)
	lw $a0, 2928($sp)
	jal print
	lw $a0, 216($sp)
	jal toString
	sw $v0, 2936($sp)
	lw $a0, 2936($sp)
	la $a1, string_55
	jal stringAdd
	sw $v0, 2944($sp)
	lw $a0, 2944($sp)
	jal print
	lw $a0, 220($sp)
	jal toString
	sw $v0, 2952($sp)
	lw $a0, 2952($sp)
	la $a1, string_56
	jal stringAdd
	sw $v0, 2960($sp)
	lw $a0, 2960($sp)
	jal print
	lw $a0, 224($sp)
	jal toString
	sw $v0, 2968($sp)
	lw $a0, 2968($sp)
	la $a1, string_57
	jal stringAdd
	sw $v0, 2976($sp)
	lw $a0, 2976($sp)
	jal print
	lw $a0, 228($sp)
	jal toString
	sw $v0, 2984($sp)
	lw $a0, 2984($sp)
	la $a1, string_58
	jal stringAdd
	sw $v0, 2992($sp)
	lw $a0, 2992($sp)
	jal print
	lw $a0, 232($sp)
	jal toString
	sw $v0, 3000($sp)
	lw $a0, 3000($sp)
	la $a1, string_59
	jal stringAdd
	sw $v0, 3008($sp)
	lw $a0, 3008($sp)
	jal print
	lw $a0, 236($sp)
	jal toString
	sw $v0, 3016($sp)
	lw $a0, 3016($sp)
	la $a1, string_60
	jal stringAdd
	sw $v0, 3024($sp)
	lw $a0, 3024($sp)
	jal print
	lw $a0, 240($sp)
	jal toString
	sw $v0, 3032($sp)
	lw $a0, 3032($sp)
	la $a1, string_61
	jal stringAdd
	sw $v0, 3040($sp)
	lw $a0, 3040($sp)
	jal print
	lw $a0, 244($sp)
	jal toString
	sw $v0, 3048($sp)
	lw $a0, 3048($sp)
	la $a1, string_62
	jal stringAdd
	sw $v0, 3056($sp)
	lw $a0, 3056($sp)
	jal print
	lw $a0, 248($sp)
	jal toString
	sw $v0, 3064($sp)
	lw $a0, 3064($sp)
	la $a1, string_63
	jal stringAdd
	sw $v0, 3072($sp)
	lw $a0, 3072($sp)
	jal print
	lw $a0, 252($sp)
	jal toString
	sw $v0, 3080($sp)
	lw $a0, 3080($sp)
	la $a1, string_64
	jal stringAdd
	sw $v0, 3088($sp)
	lw $a0, 3088($sp)
	jal print
	lw $a0, 256($sp)
	jal toString
	sw $v0, 3096($sp)
	lw $a0, 3096($sp)
	la $a1, string_65
	jal stringAdd
	sw $v0, 3104($sp)
	lw $a0, 3104($sp)
	jal print
	lw $a0, 260($sp)
	jal toString
	sw $v0, 3112($sp)
	lw $a0, 3112($sp)
	la $a1, string_66
	jal stringAdd
	sw $v0, 3120($sp)
	lw $a0, 3120($sp)
	jal print
	lw $a0, 264($sp)
	jal toString
	sw $v0, 3128($sp)
	lw $a0, 3128($sp)
	la $a1, string_67
	jal stringAdd
	sw $v0, 3136($sp)
	lw $a0, 3136($sp)
	jal print
	lw $a0, 268($sp)
	jal toString
	sw $v0, 3144($sp)
	lw $a0, 3144($sp)
	la $a1, string_68
	jal stringAdd
	sw $v0, 3152($sp)
	lw $a0, 3152($sp)
	jal print
	lw $a0, 272($sp)
	jal toString
	sw $v0, 3160($sp)
	lw $a0, 3160($sp)
	la $a1, string_69
	jal stringAdd
	sw $v0, 3168($sp)
	lw $a0, 3168($sp)
	jal print
	lw $a0, 276($sp)
	jal toString
	sw $v0, 3176($sp)
	lw $a0, 3176($sp)
	la $a1, string_70
	jal stringAdd
	sw $v0, 3184($sp)
	lw $a0, 3184($sp)
	jal print
	lw $a0, 280($sp)
	jal toString
	sw $v0, 3192($sp)
	lw $a0, 3192($sp)
	la $a1, string_71
	jal stringAdd
	sw $v0, 3200($sp)
	lw $a0, 3200($sp)
	jal print
	lw $a0, 284($sp)
	jal toString
	sw $v0, 3208($sp)
	lw $a0, 3208($sp)
	la $a1, string_72
	jal stringAdd
	sw $v0, 3216($sp)
	lw $a0, 3216($sp)
	jal print
	lw $a0, 288($sp)
	jal toString
	sw $v0, 3224($sp)
	lw $a0, 3224($sp)
	la $a1, string_73
	jal stringAdd
	sw $v0, 3232($sp)
	lw $a0, 3232($sp)
	jal print
	lw $a0, 292($sp)
	jal toString
	sw $v0, 3240($sp)
	lw $a0, 3240($sp)
	la $a1, string_74
	jal stringAdd
	sw $v0, 3248($sp)
	lw $a0, 3248($sp)
	jal print
	lw $a0, 296($sp)
	jal toString
	sw $v0, 3256($sp)
	lw $a0, 3256($sp)
	la $a1, string_75
	jal stringAdd
	sw $v0, 3264($sp)
	lw $a0, 3264($sp)
	jal print
	lw $a0, 300($sp)
	jal toString
	sw $v0, 3272($sp)
	lw $a0, 3272($sp)
	la $a1, string_76
	jal stringAdd
	sw $v0, 3280($sp)
	lw $a0, 3280($sp)
	jal print
	lw $a0, 304($sp)
	jal toString
	sw $v0, 3288($sp)
	lw $a0, 3288($sp)
	la $a1, string_77
	jal stringAdd
	sw $v0, 3296($sp)
	lw $a0, 3296($sp)
	jal print
	lw $a0, 308($sp)
	jal toString
	sw $v0, 3304($sp)
	lw $a0, 3304($sp)
	la $a1, string_78
	jal stringAdd
	sw $v0, 3312($sp)
	lw $a0, 3312($sp)
	jal print
	lw $a0, 312($sp)
	jal toString
	sw $v0, 3320($sp)
	lw $a0, 3320($sp)
	la $a1, string_79
	jal stringAdd
	sw $v0, 3328($sp)
	lw $a0, 3328($sp)
	jal print
	lw $a0, 316($sp)
	jal toString
	sw $v0, 3336($sp)
	lw $a0, 3336($sp)
	la $a1, string_80
	jal stringAdd
	sw $v0, 3344($sp)
	lw $a0, 3344($sp)
	jal print
	lw $a0, 320($sp)
	jal toString
	sw $v0, 3352($sp)
	lw $a0, 3352($sp)
	la $a1, string_81
	jal stringAdd
	sw $v0, 3360($sp)
	lw $a0, 3360($sp)
	jal print
	lw $a0, 324($sp)
	jal toString
	sw $v0, 3368($sp)
	lw $a0, 3368($sp)
	la $a1, string_82
	jal stringAdd
	sw $v0, 3376($sp)
	lw $a0, 3376($sp)
	jal print
	lw $a0, 328($sp)
	jal toString
	sw $v0, 3384($sp)
	lw $a0, 3384($sp)
	la $a1, string_83
	jal stringAdd
	sw $v0, 3392($sp)
	lw $a0, 3392($sp)
	jal print
	lw $a0, 332($sp)
	jal toString
	sw $v0, 3400($sp)
	lw $a0, 3400($sp)
	la $a1, string_84
	jal stringAdd
	sw $v0, 3408($sp)
	lw $a0, 3408($sp)
	jal print
	lw $a0, 336($sp)
	jal toString
	sw $v0, 3416($sp)
	lw $a0, 3416($sp)
	la $a1, string_85
	jal stringAdd
	sw $v0, 3424($sp)
	lw $a0, 3424($sp)
	jal print
	lw $a0, 340($sp)
	jal toString
	sw $v0, 3432($sp)
	lw $a0, 3432($sp)
	la $a1, string_86
	jal stringAdd
	sw $v0, 3440($sp)
	lw $a0, 3440($sp)
	jal print
	lw $a0, 344($sp)
	jal toString
	sw $v0, 3448($sp)
	lw $a0, 3448($sp)
	la $a1, string_87
	jal stringAdd
	sw $v0, 3456($sp)
	lw $a0, 3456($sp)
	jal print
	lw $a0, 348($sp)
	jal toString
	sw $v0, 3464($sp)
	lw $a0, 3464($sp)
	la $a1, string_88
	jal stringAdd
	sw $v0, 3472($sp)
	lw $a0, 3472($sp)
	jal print
	lw $a0, 352($sp)
	jal toString
	sw $v0, 3480($sp)
	lw $a0, 3480($sp)
	la $a1, string_89
	jal stringAdd
	sw $v0, 3488($sp)
	lw $a0, 3488($sp)
	jal print
	lw $a0, 356($sp)
	jal toString
	sw $v0, 3496($sp)
	lw $a0, 3496($sp)
	la $a1, string_90
	jal stringAdd
	sw $v0, 3504($sp)
	lw $a0, 3504($sp)
	jal print
	lw $a0, 360($sp)
	jal toString
	sw $v0, 3512($sp)
	lw $a0, 3512($sp)
	la $a1, string_91
	jal stringAdd
	sw $v0, 3520($sp)
	lw $a0, 3520($sp)
	jal print
	lw $a0, 364($sp)
	jal toString
	sw $v0, 3528($sp)
	lw $a0, 3528($sp)
	la $a1, string_92
	jal stringAdd
	sw $v0, 3536($sp)
	lw $a0, 3536($sp)
	jal print
	lw $a0, 368($sp)
	jal toString
	sw $v0, 3544($sp)
	lw $a0, 3544($sp)
	la $a1, string_93
	jal stringAdd
	sw $v0, 3552($sp)
	lw $a0, 3552($sp)
	jal print
	lw $a0, 372($sp)
	jal toString
	sw $v0, 3560($sp)
	lw $a0, 3560($sp)
	la $a1, string_94
	jal stringAdd
	sw $v0, 3568($sp)
	lw $a0, 3568($sp)
	jal print
	lw $a0, 376($sp)
	jal toString
	sw $v0, 3576($sp)
	lw $a0, 3576($sp)
	la $a1, string_95
	jal stringAdd
	sw $v0, 3584($sp)
	lw $a0, 3584($sp)
	jal print
	lw $a0, 380($sp)
	jal toString
	sw $v0, 3592($sp)
	lw $a0, 3592($sp)
	la $a1, string_96
	jal stringAdd
	sw $v0, 3600($sp)
	lw $a0, 3600($sp)
	jal print
	lw $a0, 384($sp)
	jal toString
	sw $v0, 3608($sp)
	lw $a0, 3608($sp)
	la $a1, string_97
	jal stringAdd
	sw $v0, 3616($sp)
	lw $a0, 3616($sp)
	jal print
	lw $a0, 388($sp)
	jal toString
	sw $v0, 3624($sp)
	lw $a0, 3624($sp)
	la $a1, string_98
	jal stringAdd
	sw $v0, 3632($sp)
	lw $a0, 3632($sp)
	jal print
	lw $a0, 392($sp)
	jal toString
	sw $v0, 3640($sp)
	lw $a0, 3640($sp)
	la $a1, string_99
	jal stringAdd
	sw $v0, 3648($sp)
	lw $a0, 3648($sp)
	jal print
	lw $a0, 396($sp)
	jal toString
	sw $v0, 3656($sp)
	lw $a0, 3656($sp)
	la $a1, string_100
	jal stringAdd
	sw $v0, 3664($sp)
	lw $a0, 3664($sp)
	jal print
	lw $a0, 400($sp)
	jal toString
	sw $v0, 3672($sp)
	lw $a0, 3672($sp)
	la $a1, string_101
	jal stringAdd
	sw $v0, 3680($sp)
	lw $a0, 3680($sp)
	jal print
	lw $a0, 404($sp)
	jal toString
	sw $v0, 3688($sp)
	lw $a0, 3688($sp)
	la $a1, string_102
	jal stringAdd
	sw $v0, 3696($sp)
	lw $a0, 3696($sp)
	jal print
	lw $a0, 408($sp)
	jal toString
	sw $v0, 3704($sp)
	lw $a0, 3704($sp)
	la $a1, string_103
	jal stringAdd
	sw $v0, 3712($sp)
	lw $a0, 3712($sp)
	jal print
	lw $a0, 412($sp)
	jal toString
	sw $v0, 3720($sp)
	lw $a0, 3720($sp)
	la $a1, string_104
	jal stringAdd
	sw $v0, 3728($sp)
	lw $a0, 3728($sp)
	jal print
	lw $a0, 416($sp)
	jal toString
	sw $v0, 3736($sp)
	lw $a0, 3736($sp)
	la $a1, string_105
	jal stringAdd
	sw $v0, 3744($sp)
	lw $a0, 3744($sp)
	jal print
	lw $a0, 420($sp)
	jal toString
	sw $v0, 3752($sp)
	lw $a0, 3752($sp)
	la $a1, string_106
	jal stringAdd
	sw $v0, 3760($sp)
	lw $a0, 3760($sp)
	jal print
	lw $a0, 424($sp)
	jal toString
	sw $v0, 3768($sp)
	lw $a0, 3768($sp)
	la $a1, string_107
	jal stringAdd
	sw $v0, 3776($sp)
	lw $a0, 3776($sp)
	jal print
	lw $a0, 428($sp)
	jal toString
	sw $v0, 3784($sp)
	lw $a0, 3784($sp)
	la $a1, string_108
	jal stringAdd
	sw $v0, 3792($sp)
	lw $a0, 3792($sp)
	jal print
	lw $a0, 432($sp)
	jal toString
	sw $v0, 3800($sp)
	lw $a0, 3800($sp)
	la $a1, string_109
	jal stringAdd
	sw $v0, 3808($sp)
	lw $a0, 3808($sp)
	jal print
	lw $a0, 436($sp)
	jal toString
	sw $v0, 3816($sp)
	lw $a0, 3816($sp)
	la $a1, string_110
	jal stringAdd
	sw $v0, 3824($sp)
	lw $a0, 3824($sp)
	jal print
	lw $a0, 440($sp)
	jal toString
	sw $v0, 3832($sp)
	lw $a0, 3832($sp)
	la $a1, string_111
	jal stringAdd
	sw $v0, 3840($sp)
	lw $a0, 3840($sp)
	jal print
	lw $a0, 444($sp)
	jal toString
	sw $v0, 3848($sp)
	lw $a0, 3848($sp)
	la $a1, string_112
	jal stringAdd
	sw $v0, 3856($sp)
	lw $a0, 3856($sp)
	jal print
	lw $a0, 448($sp)
	jal toString
	sw $v0, 3864($sp)
	lw $a0, 3864($sp)
	la $a1, string_113
	jal stringAdd
	sw $v0, 3872($sp)
	lw $a0, 3872($sp)
	jal print
	lw $a0, 452($sp)
	jal toString
	sw $v0, 3880($sp)
	lw $a0, 3880($sp)
	la $a1, string_114
	jal stringAdd
	sw $v0, 3888($sp)
	lw $a0, 3888($sp)
	jal print
	lw $a0, 456($sp)
	jal toString
	sw $v0, 3896($sp)
	lw $a0, 3896($sp)
	la $a1, string_115
	jal stringAdd
	sw $v0, 3904($sp)
	lw $a0, 3904($sp)
	jal print
	lw $a0, 460($sp)
	jal toString
	sw $v0, 3912($sp)
	lw $a0, 3912($sp)
	la $a1, string_116
	jal stringAdd
	sw $v0, 3920($sp)
	lw $a0, 3920($sp)
	jal print
	lw $a0, 464($sp)
	jal toString
	sw $v0, 3928($sp)
	lw $a0, 3928($sp)
	la $a1, string_117
	jal stringAdd
	sw $v0, 3936($sp)
	lw $a0, 3936($sp)
	jal print
	lw $a0, 468($sp)
	jal toString
	sw $v0, 3944($sp)
	lw $a0, 3944($sp)
	la $a1, string_118
	jal stringAdd
	sw $v0, 3952($sp)
	lw $a0, 3952($sp)
	jal print
	lw $a0, 472($sp)
	jal toString
	sw $v0, 3960($sp)
	lw $a0, 3960($sp)
	la $a1, string_119
	jal stringAdd
	sw $v0, 3968($sp)
	lw $a0, 3968($sp)
	jal print
	lw $a0, 476($sp)
	jal toString
	sw $v0, 3976($sp)
	lw $a0, 3976($sp)
	la $a1, string_120
	jal stringAdd
	sw $v0, 3984($sp)
	lw $a0, 3984($sp)
	jal print
	lw $a0, 480($sp)
	jal toString
	sw $v0, 3992($sp)
	lw $a0, 3992($sp)
	la $a1, string_121
	jal stringAdd
	sw $v0, 4000($sp)
	lw $a0, 4000($sp)
	jal print
	lw $a0, 484($sp)
	jal toString
	sw $v0, 4008($sp)
	lw $a0, 4008($sp)
	la $a1, string_122
	jal stringAdd
	sw $v0, 4016($sp)
	lw $a0, 4016($sp)
	jal print
	lw $a0, 488($sp)
	jal toString
	sw $v0, 4024($sp)
	lw $a0, 4024($sp)
	la $a1, string_123
	jal stringAdd
	sw $v0, 4032($sp)
	lw $a0, 4032($sp)
	jal print
	lw $a0, 492($sp)
	jal toString
	sw $v0, 4040($sp)
	lw $a0, 4040($sp)
	la $a1, string_124
	jal stringAdd
	sw $v0, 4048($sp)
	lw $a0, 4048($sp)
	jal print
	lw $a0, 496($sp)
	jal toString
	sw $v0, 4056($sp)
	lw $a0, 4056($sp)
	la $a1, string_125
	jal stringAdd
	sw $v0, 4064($sp)
	lw $a0, 4064($sp)
	jal print
	lw $a0, 500($sp)
	jal toString
	sw $v0, 4072($sp)
	lw $a0, 4072($sp)
	la $a1, string_126
	jal stringAdd
	sw $v0, 4080($sp)
	lw $a0, 4080($sp)
	jal print
	lw $a0, 504($sp)
	jal toString
	sw $v0, 4088($sp)
	lw $a0, 4088($sp)
	la $a1, string_127
	jal stringAdd
	sw $v0, 4096($sp)
	lw $a0, 4096($sp)
	jal print
	lw $a0, 508($sp)
	jal toString
	sw $v0, 4104($sp)
	lw $a0, 4104($sp)
	la $a1, string_128
	jal stringAdd
	sw $v0, 4112($sp)
	lw $a0, 4112($sp)
	jal print
	lw $a0, 512($sp)
	jal toString
	sw $v0, 4120($sp)
	lw $a0, 4120($sp)
	la $a1, string_129
	jal stringAdd
	sw $v0, 4128($sp)
	lw $a0, 4128($sp)
	jal print
	lw $a0, 516($sp)
	jal toString
	sw $v0, 4136($sp)
	lw $a0, 4136($sp)
	la $a1, string_130
	jal stringAdd
	sw $v0, 4144($sp)
	lw $a0, 4144($sp)
	jal print
	lw $a0, 520($sp)
	jal toString
	sw $v0, 4152($sp)
	lw $a0, 4152($sp)
	la $a1, string_131
	jal stringAdd
	sw $v0, 4160($sp)
	lw $a0, 4160($sp)
	jal print
	lw $a0, 524($sp)
	jal toString
	sw $v0, 4168($sp)
	lw $a0, 4168($sp)
	la $a1, string_132
	jal stringAdd
	sw $v0, 4176($sp)
	lw $a0, 4176($sp)
	jal print
	lw $a0, 528($sp)
	jal toString
	sw $v0, 4184($sp)
	lw $a0, 4184($sp)
	la $a1, string_133
	jal stringAdd
	sw $v0, 4192($sp)
	lw $a0, 4192($sp)
	jal print
	lw $a0, 532($sp)
	jal toString
	sw $v0, 4200($sp)
	lw $a0, 4200($sp)
	la $a1, string_134
	jal stringAdd
	sw $v0, 4208($sp)
	lw $a0, 4208($sp)
	jal print
	lw $a0, 536($sp)
	jal toString
	sw $v0, 4216($sp)
	lw $a0, 4216($sp)
	la $a1, string_135
	jal stringAdd
	sw $v0, 4224($sp)
	lw $a0, 4224($sp)
	jal print
	lw $a0, 540($sp)
	jal toString
	sw $v0, 4232($sp)
	lw $a0, 4232($sp)
	la $a1, string_136
	jal stringAdd
	sw $v0, 4240($sp)
	lw $a0, 4240($sp)
	jal print
	lw $a0, 544($sp)
	jal toString
	sw $v0, 4248($sp)
	lw $a0, 4248($sp)
	la $a1, string_137
	jal stringAdd
	sw $v0, 4256($sp)
	lw $a0, 4256($sp)
	jal print
	lw $a0, 548($sp)
	jal toString
	sw $v0, 4264($sp)
	lw $a0, 4264($sp)
	la $a1, string_138
	jal stringAdd
	sw $v0, 4272($sp)
	lw $a0, 4272($sp)
	jal print
	lw $a0, 552($sp)
	jal toString
	sw $v0, 4280($sp)
	lw $a0, 4280($sp)
	la $a1, string_139
	jal stringAdd
	sw $v0, 4288($sp)
	lw $a0, 4288($sp)
	jal print
	lw $a0, 556($sp)
	jal toString
	sw $v0, 4296($sp)
	lw $a0, 4296($sp)
	la $a1, string_140
	jal stringAdd
	sw $v0, 4304($sp)
	lw $a0, 4304($sp)
	jal print
	lw $a0, 560($sp)
	jal toString
	sw $v0, 4312($sp)
	lw $a0, 4312($sp)
	la $a1, string_141
	jal stringAdd
	sw $v0, 4320($sp)
	lw $a0, 4320($sp)
	jal print
	lw $a0, 564($sp)
	jal toString
	sw $v0, 4328($sp)
	lw $a0, 4328($sp)
	la $a1, string_142
	jal stringAdd
	sw $v0, 4336($sp)
	lw $a0, 4336($sp)
	jal print
	lw $a0, 568($sp)
	jal toString
	sw $v0, 4344($sp)
	lw $a0, 4344($sp)
	la $a1, string_143
	jal stringAdd
	sw $v0, 4352($sp)
	lw $a0, 4352($sp)
	jal print
	lw $a0, 572($sp)
	jal toString
	sw $v0, 4360($sp)
	lw $a0, 4360($sp)
	la $a1, string_144
	jal stringAdd
	sw $v0, 4368($sp)
	lw $a0, 4368($sp)
	jal print
	lw $a0, 576($sp)
	jal toString
	sw $v0, 4376($sp)
	lw $a0, 4376($sp)
	la $a1, string_145
	jal stringAdd
	sw $v0, 4384($sp)
	lw $a0, 4384($sp)
	jal print
	lw $a0, 580($sp)
	jal toString
	sw $v0, 4392($sp)
	lw $a0, 4392($sp)
	la $a1, string_146
	jal stringAdd
	sw $v0, 4400($sp)
	lw $a0, 4400($sp)
	jal print
	lw $a0, 584($sp)
	jal toString
	sw $v0, 4408($sp)
	lw $a0, 4408($sp)
	la $a1, string_147
	jal stringAdd
	sw $v0, 4416($sp)
	lw $a0, 4416($sp)
	jal print
	lw $a0, 588($sp)
	jal toString
	sw $v0, 4424($sp)
	lw $a0, 4424($sp)
	la $a1, string_148
	jal stringAdd
	sw $v0, 4432($sp)
	lw $a0, 4432($sp)
	jal print
	lw $a0, 592($sp)
	jal toString
	sw $v0, 4440($sp)
	lw $a0, 4440($sp)
	la $a1, string_149
	jal stringAdd
	sw $v0, 4448($sp)
	lw $a0, 4448($sp)
	jal print
	lw $a0, 596($sp)
	jal toString
	sw $v0, 4456($sp)
	lw $a0, 4456($sp)
	la $a1, string_150
	jal stringAdd
	sw $v0, 4464($sp)
	lw $a0, 4464($sp)
	jal print
	lw $a0, 600($sp)
	jal toString
	sw $v0, 4472($sp)
	lw $a0, 4472($sp)
	la $a1, string_151
	jal stringAdd
	sw $v0, 4480($sp)
	lw $a0, 4480($sp)
	jal print
	lw $a0, 604($sp)
	jal toString
	sw $v0, 4488($sp)
	lw $a0, 4488($sp)
	la $a1, string_152
	jal stringAdd
	sw $v0, 4496($sp)
	lw $a0, 4496($sp)
	jal print
	lw $a0, 608($sp)
	jal toString
	sw $v0, 4504($sp)
	lw $a0, 4504($sp)
	la $a1, string_153
	jal stringAdd
	sw $v0, 4512($sp)
	lw $a0, 4512($sp)
	jal print
	lw $a0, 612($sp)
	jal toString
	sw $v0, 4520($sp)
	lw $a0, 4520($sp)
	la $a1, string_154
	jal stringAdd
	sw $v0, 4528($sp)
	lw $a0, 4528($sp)
	jal print
	lw $a0, 616($sp)
	jal toString
	sw $v0, 4536($sp)
	lw $a0, 4536($sp)
	la $a1, string_155
	jal stringAdd
	sw $v0, 4544($sp)
	lw $a0, 4544($sp)
	jal print
	lw $a0, 620($sp)
	jal toString
	sw $v0, 4552($sp)
	lw $a0, 4552($sp)
	la $a1, string_156
	jal stringAdd
	sw $v0, 4560($sp)
	lw $a0, 4560($sp)
	jal print
	lw $a0, 624($sp)
	jal toString
	sw $v0, 4568($sp)
	lw $a0, 4568($sp)
	la $a1, string_157
	jal stringAdd
	sw $v0, 4576($sp)
	lw $a0, 4576($sp)
	jal print
	lw $a0, 628($sp)
	jal toString
	sw $v0, 4584($sp)
	lw $a0, 4584($sp)
	la $a1, string_158
	jal stringAdd
	sw $v0, 4592($sp)
	lw $a0, 4592($sp)
	jal print
	lw $a0, 632($sp)
	jal toString
	sw $v0, 4600($sp)
	lw $a0, 4600($sp)
	la $a1, string_159
	jal stringAdd
	sw $v0, 4608($sp)
	lw $a0, 4608($sp)
	jal print
	lw $a0, 636($sp)
	jal toString
	sw $v0, 4616($sp)
	lw $a0, 4616($sp)
	la $a1, string_160
	jal stringAdd
	sw $v0, 4624($sp)
	lw $a0, 4624($sp)
	jal print
	lw $a0, 640($sp)
	jal toString
	sw $v0, 4632($sp)
	lw $a0, 4632($sp)
	la $a1, string_161
	jal stringAdd
	sw $v0, 4640($sp)
	lw $a0, 4640($sp)
	jal print
	lw $a0, 644($sp)
	jal toString
	sw $v0, 4648($sp)
	lw $a0, 4648($sp)
	la $a1, string_162
	jal stringAdd
	sw $v0, 4656($sp)
	lw $a0, 4656($sp)
	jal print
	lw $a0, 648($sp)
	jal toString
	sw $v0, 4664($sp)
	lw $a0, 4664($sp)
	la $a1, string_163
	jal stringAdd
	sw $v0, 4672($sp)
	lw $a0, 4672($sp)
	jal print
	lw $a0, 652($sp)
	jal toString
	sw $v0, 4680($sp)
	lw $a0, 4680($sp)
	la $a1, string_164
	jal stringAdd
	sw $v0, 4688($sp)
	lw $a0, 4688($sp)
	jal print
	lw $a0, 656($sp)
	jal toString
	sw $v0, 4696($sp)
	lw $a0, 4696($sp)
	la $a1, string_165
	jal stringAdd
	sw $v0, 4704($sp)
	lw $a0, 4704($sp)
	jal print
	lw $a0, 660($sp)
	jal toString
	sw $v0, 4712($sp)
	lw $a0, 4712($sp)
	la $a1, string_166
	jal stringAdd
	sw $v0, 4720($sp)
	lw $a0, 4720($sp)
	jal print
	lw $a0, 664($sp)
	jal toString
	sw $v0, 4728($sp)
	lw $a0, 4728($sp)
	la $a1, string_167
	jal stringAdd
	sw $v0, 4736($sp)
	lw $a0, 4736($sp)
	jal print
	lw $a0, 668($sp)
	jal toString
	sw $v0, 4744($sp)
	lw $a0, 4744($sp)
	la $a1, string_168
	jal stringAdd
	sw $v0, 4752($sp)
	lw $a0, 4752($sp)
	jal print
	lw $a0, 672($sp)
	jal toString
	sw $v0, 4760($sp)
	lw $a0, 4760($sp)
	la $a1, string_169
	jal stringAdd
	sw $v0, 4768($sp)
	lw $a0, 4768($sp)
	jal print
	lw $a0, 676($sp)
	jal toString
	sw $v0, 4776($sp)
	lw $a0, 4776($sp)
	la $a1, string_170
	jal stringAdd
	sw $v0, 4784($sp)
	lw $a0, 4784($sp)
	jal print
	lw $a0, 680($sp)
	jal toString
	sw $v0, 4792($sp)
	lw $a0, 4792($sp)
	la $a1, string_171
	jal stringAdd
	sw $v0, 4800($sp)
	lw $a0, 4800($sp)
	jal print
	lw $a0, 684($sp)
	jal toString
	sw $v0, 4808($sp)
	lw $a0, 4808($sp)
	la $a1, string_172
	jal stringAdd
	sw $v0, 4816($sp)
	lw $a0, 4816($sp)
	jal print
	lw $a0, 688($sp)
	jal toString
	sw $v0, 4824($sp)
	lw $a0, 4824($sp)
	la $a1, string_173
	jal stringAdd
	sw $v0, 4832($sp)
	lw $a0, 4832($sp)
	jal print
	lw $a0, 692($sp)
	jal toString
	sw $v0, 4840($sp)
	lw $a0, 4840($sp)
	la $a1, string_174
	jal stringAdd
	sw $v0, 4848($sp)
	lw $a0, 4848($sp)
	jal print
	lw $a0, 696($sp)
	jal toString
	sw $v0, 4856($sp)
	lw $a0, 4856($sp)
	la $a1, string_175
	jal stringAdd
	sw $v0, 4864($sp)
	lw $a0, 4864($sp)
	jal print
	lw $a0, 700($sp)
	jal toString
	sw $v0, 4872($sp)
	lw $a0, 4872($sp)
	la $a1, string_176
	jal stringAdd
	sw $v0, 4880($sp)
	lw $a0, 4880($sp)
	jal print
	lw $a0, 704($sp)
	jal toString
	sw $v0, 4888($sp)
	lw $a0, 4888($sp)
	la $a1, string_177
	jal stringAdd
	sw $v0, 4896($sp)
	lw $a0, 4896($sp)
	jal print
	lw $a0, 708($sp)
	jal toString
	sw $v0, 4904($sp)
	lw $a0, 4904($sp)
	la $a1, string_178
	jal stringAdd
	sw $v0, 4912($sp)
	lw $a0, 4912($sp)
	jal print
	lw $a0, 712($sp)
	jal toString
	sw $v0, 4920($sp)
	lw $a0, 4920($sp)
	la $a1, string_179
	jal stringAdd
	sw $v0, 4928($sp)
	lw $a0, 4928($sp)
	jal print
	lw $a0, 716($sp)
	jal toString
	sw $v0, 4936($sp)
	lw $a0, 4936($sp)
	la $a1, string_180
	jal stringAdd
	sw $v0, 4944($sp)
	lw $a0, 4944($sp)
	jal print
	lw $a0, 720($sp)
	jal toString
	sw $v0, 4952($sp)
	lw $a0, 4952($sp)
	la $a1, string_181
	jal stringAdd
	sw $v0, 4960($sp)
	lw $a0, 4960($sp)
	jal print
	lw $a0, 724($sp)
	jal toString
	sw $v0, 4968($sp)
	lw $a0, 4968($sp)
	la $a1, string_182
	jal stringAdd
	sw $v0, 4976($sp)
	lw $a0, 4976($sp)
	jal print
	lw $a0, 728($sp)
	jal toString
	sw $v0, 4984($sp)
	lw $a0, 4984($sp)
	la $a1, string_183
	jal stringAdd
	sw $v0, 4992($sp)
	lw $a0, 4992($sp)
	jal print
	lw $a0, 732($sp)
	jal toString
	sw $v0, 5000($sp)
	lw $a0, 5000($sp)
	la $a1, string_184
	jal stringAdd
	sw $v0, 5008($sp)
	lw $a0, 5008($sp)
	jal print
	lw $a0, 736($sp)
	jal toString
	sw $v0, 5016($sp)
	lw $a0, 5016($sp)
	la $a1, string_185
	jal stringAdd
	sw $v0, 5024($sp)
	lw $a0, 5024($sp)
	jal print
	lw $a0, 740($sp)
	jal toString
	sw $v0, 5032($sp)
	lw $a0, 5032($sp)
	la $a1, string_186
	jal stringAdd
	sw $v0, 5040($sp)
	lw $a0, 5040($sp)
	jal print
	lw $a0, 744($sp)
	jal toString
	sw $v0, 5048($sp)
	lw $a0, 5048($sp)
	la $a1, string_187
	jal stringAdd
	sw $v0, 5056($sp)
	lw $a0, 5056($sp)
	jal print
	lw $a0, 748($sp)
	jal toString
	sw $v0, 5064($sp)
	lw $a0, 5064($sp)
	la $a1, string_188
	jal stringAdd
	sw $v0, 5072($sp)
	lw $a0, 5072($sp)
	jal print
	lw $a0, 752($sp)
	jal toString
	sw $v0, 5080($sp)
	lw $a0, 5080($sp)
	la $a1, string_189
	jal stringAdd
	sw $v0, 5088($sp)
	lw $a0, 5088($sp)
	jal print
	lw $a0, 756($sp)
	jal toString
	sw $v0, 5096($sp)
	lw $a0, 5096($sp)
	la $a1, string_190
	jal stringAdd
	sw $v0, 5104($sp)
	lw $a0, 5104($sp)
	jal print
	lw $a0, 760($sp)
	jal toString
	sw $v0, 5112($sp)
	lw $a0, 5112($sp)
	la $a1, string_191
	jal stringAdd
	sw $v0, 5120($sp)
	lw $a0, 5120($sp)
	jal print
	lw $a0, 764($sp)
	jal toString
	sw $v0, 5128($sp)
	lw $a0, 5128($sp)
	la $a1, string_192
	jal stringAdd
	sw $v0, 5136($sp)
	lw $a0, 5136($sp)
	jal print
	lw $a0, 768($sp)
	jal toString
	sw $v0, 5144($sp)
	lw $a0, 5144($sp)
	la $a1, string_193
	jal stringAdd
	sw $v0, 5152($sp)
	lw $a0, 5152($sp)
	jal print
	lw $a0, 772($sp)
	jal toString
	sw $v0, 5160($sp)
	lw $a0, 5160($sp)
	la $a1, string_194
	jal stringAdd
	sw $v0, 5168($sp)
	lw $a0, 5168($sp)
	jal print
	lw $a0, 776($sp)
	jal toString
	sw $v0, 5176($sp)
	lw $a0, 5176($sp)
	la $a1, string_195
	jal stringAdd
	sw $v0, 5184($sp)
	lw $a0, 5184($sp)
	jal print
	lw $a0, 780($sp)
	jal toString
	sw $v0, 5192($sp)
	lw $a0, 5192($sp)
	la $a1, string_196
	jal stringAdd
	sw $v0, 5200($sp)
	lw $a0, 5200($sp)
	jal print
	lw $a0, 784($sp)
	jal toString
	sw $v0, 5208($sp)
	lw $a0, 5208($sp)
	la $a1, string_197
	jal stringAdd
	sw $v0, 5216($sp)
	lw $a0, 5216($sp)
	jal print
	lw $a0, 788($sp)
	jal toString
	sw $v0, 5224($sp)
	lw $a0, 5224($sp)
	la $a1, string_198
	jal stringAdd
	sw $v0, 5232($sp)
	lw $a0, 5232($sp)
	jal print
	lw $a0, 792($sp)
	jal toString
	sw $v0, 5240($sp)
	lw $a0, 5240($sp)
	la $a1, string_199
	jal stringAdd
	sw $v0, 5248($sp)
	lw $a0, 5248($sp)
	jal print
	lw $a0, 796($sp)
	jal toString
	sw $v0, 5256($sp)
	lw $a0, 5256($sp)
	la $a1, string_200
	jal stringAdd
	sw $v0, 5264($sp)
	lw $a0, 5264($sp)
	jal print
	lw $a0, 800($sp)
	jal toString
	sw $v0, 5272($sp)
	lw $a0, 5272($sp)
	la $a1, string_201
	jal stringAdd
	sw $v0, 5280($sp)
	lw $a0, 5280($sp)
	jal print
	lw $a0, 804($sp)
	jal toString
	sw $v0, 5288($sp)
	lw $a0, 5288($sp)
	la $a1, string_202
	jal stringAdd
	sw $v0, 5296($sp)
	lw $a0, 5296($sp)
	jal print
	lw $a0, 808($sp)
	jal toString
	sw $v0, 5304($sp)
	lw $a0, 5304($sp)
	la $a1, string_203
	jal stringAdd
	sw $v0, 5312($sp)
	lw $a0, 5312($sp)
	jal print
	lw $a0, 812($sp)
	jal toString
	sw $v0, 5320($sp)
	lw $a0, 5320($sp)
	la $a1, string_204
	jal stringAdd
	sw $v0, 5328($sp)
	lw $a0, 5328($sp)
	jal print
	lw $a0, 816($sp)
	jal toString
	sw $v0, 5336($sp)
	lw $a0, 5336($sp)
	la $a1, string_205
	jal stringAdd
	sw $v0, 5344($sp)
	lw $a0, 5344($sp)
	jal print
	lw $a0, 820($sp)
	jal toString
	sw $v0, 5352($sp)
	lw $a0, 5352($sp)
	la $a1, string_206
	jal stringAdd
	sw $v0, 5360($sp)
	lw $a0, 5360($sp)
	jal print
	lw $a0, 824($sp)
	jal toString
	sw $v0, 5368($sp)
	lw $a0, 5368($sp)
	la $a1, string_207
	jal stringAdd
	sw $v0, 5376($sp)
	lw $a0, 5376($sp)
	jal print
	lw $a0, 828($sp)
	jal toString
	sw $v0, 5384($sp)
	lw $a0, 5384($sp)
	la $a1, string_208
	jal stringAdd
	sw $v0, 5392($sp)
	lw $a0, 5392($sp)
	jal print
	lw $a0, 832($sp)
	jal toString
	sw $v0, 5400($sp)
	lw $a0, 5400($sp)
	la $a1, string_209
	jal stringAdd
	sw $v0, 5408($sp)
	lw $a0, 5408($sp)
	jal print
	lw $a0, 836($sp)
	jal toString
	sw $v0, 5416($sp)
	lw $a0, 5416($sp)
	la $a1, string_210
	jal stringAdd
	sw $v0, 5424($sp)
	lw $a0, 5424($sp)
	jal print
	lw $a0, 840($sp)
	jal toString
	sw $v0, 5432($sp)
	lw $a0, 5432($sp)
	la $a1, string_211
	jal stringAdd
	sw $v0, 5440($sp)
	lw $a0, 5440($sp)
	jal print
	lw $a0, 844($sp)
	jal toString
	sw $v0, 5448($sp)
	lw $a0, 5448($sp)
	la $a1, string_212
	jal stringAdd
	sw $v0, 5456($sp)
	lw $a0, 5456($sp)
	jal print
	lw $a0, 848($sp)
	jal toString
	sw $v0, 5464($sp)
	lw $a0, 5464($sp)
	la $a1, string_213
	jal stringAdd
	sw $v0, 5472($sp)
	lw $a0, 5472($sp)
	jal print
	lw $a0, 852($sp)
	jal toString
	sw $v0, 5480($sp)
	lw $a0, 5480($sp)
	la $a1, string_214
	jal stringAdd
	sw $v0, 5488($sp)
	lw $a0, 5488($sp)
	jal print
	lw $a0, 856($sp)
	jal toString
	sw $v0, 5496($sp)
	lw $a0, 5496($sp)
	la $a1, string_215
	jal stringAdd
	sw $v0, 5504($sp)
	lw $a0, 5504($sp)
	jal print
	lw $a0, 860($sp)
	jal toString
	sw $v0, 5512($sp)
	lw $a0, 5512($sp)
	la $a1, string_216
	jal stringAdd
	sw $v0, 5520($sp)
	lw $a0, 5520($sp)
	jal print
	lw $a0, 864($sp)
	jal toString
	sw $v0, 5528($sp)
	lw $a0, 5528($sp)
	la $a1, string_217
	jal stringAdd
	sw $v0, 5536($sp)
	lw $a0, 5536($sp)
	jal print
	lw $a0, 868($sp)
	jal toString
	sw $v0, 5544($sp)
	lw $a0, 5544($sp)
	la $a1, string_218
	jal stringAdd
	sw $v0, 5552($sp)
	lw $a0, 5552($sp)
	jal print
	lw $a0, 872($sp)
	jal toString
	sw $v0, 5560($sp)
	lw $a0, 5560($sp)
	la $a1, string_219
	jal stringAdd
	sw $v0, 5568($sp)
	lw $a0, 5568($sp)
	jal print
	lw $a0, 876($sp)
	jal toString
	sw $v0, 5576($sp)
	lw $a0, 5576($sp)
	la $a1, string_220
	jal stringAdd
	sw $v0, 5584($sp)
	lw $a0, 5584($sp)
	jal print
	lw $a0, 880($sp)
	jal toString
	sw $v0, 5592($sp)
	lw $a0, 5592($sp)
	la $a1, string_221
	jal stringAdd
	sw $v0, 5600($sp)
	lw $a0, 5600($sp)
	jal print
	lw $a0, 884($sp)
	jal toString
	sw $v0, 5608($sp)
	lw $a0, 5608($sp)
	la $a1, string_222
	jal stringAdd
	sw $v0, 5616($sp)
	lw $a0, 5616($sp)
	jal print
	lw $a0, 888($sp)
	jal toString
	sw $v0, 5624($sp)
	lw $a0, 5624($sp)
	la $a1, string_223
	jal stringAdd
	sw $v0, 5632($sp)
	lw $a0, 5632($sp)
	jal print
	lw $a0, 892($sp)
	jal toString
	sw $v0, 5640($sp)
	lw $a0, 5640($sp)
	la $a1, string_224
	jal stringAdd
	sw $v0, 5648($sp)
	lw $a0, 5648($sp)
	jal print
	lw $a0, 896($sp)
	jal toString
	sw $v0, 5656($sp)
	lw $a0, 5656($sp)
	la $a1, string_225
	jal stringAdd
	sw $v0, 5664($sp)
	lw $a0, 5664($sp)
	jal print
	lw $a0, 900($sp)
	jal toString
	sw $v0, 5672($sp)
	lw $a0, 5672($sp)
	la $a1, string_226
	jal stringAdd
	sw $v0, 5680($sp)
	lw $a0, 5680($sp)
	jal print
	lw $a0, 904($sp)
	jal toString
	sw $v0, 5688($sp)
	lw $a0, 5688($sp)
	la $a1, string_227
	jal stringAdd
	sw $v0, 5696($sp)
	lw $a0, 5696($sp)
	jal print
	lw $a0, 908($sp)
	jal toString
	sw $v0, 5704($sp)
	lw $a0, 5704($sp)
	la $a1, string_228
	jal stringAdd
	sw $v0, 5712($sp)
	lw $a0, 5712($sp)
	jal print
	lw $a0, 912($sp)
	jal toString
	sw $v0, 5720($sp)
	lw $a0, 5720($sp)
	la $a1, string_229
	jal stringAdd
	sw $v0, 5728($sp)
	lw $a0, 5728($sp)
	jal print
	lw $a0, 916($sp)
	jal toString
	sw $v0, 5736($sp)
	lw $a0, 5736($sp)
	la $a1, string_230
	jal stringAdd
	sw $v0, 5744($sp)
	lw $a0, 5744($sp)
	jal print
	lw $a0, 920($sp)
	jal toString
	sw $v0, 5752($sp)
	lw $a0, 5752($sp)
	la $a1, string_231
	jal stringAdd
	sw $v0, 5760($sp)
	lw $a0, 5760($sp)
	jal print
	lw $a0, 924($sp)
	jal toString
	sw $v0, 5768($sp)
	lw $a0, 5768($sp)
	la $a1, string_232
	jal stringAdd
	sw $v0, 5776($sp)
	lw $a0, 5776($sp)
	jal print
	lw $a0, 928($sp)
	jal toString
	sw $v0, 5784($sp)
	lw $a0, 5784($sp)
	la $a1, string_233
	jal stringAdd
	sw $v0, 5792($sp)
	lw $a0, 5792($sp)
	jal print
	lw $a0, 932($sp)
	jal toString
	sw $v0, 5800($sp)
	lw $a0, 5800($sp)
	la $a1, string_234
	jal stringAdd
	sw $v0, 5808($sp)
	lw $a0, 5808($sp)
	jal print
	lw $a0, 936($sp)
	jal toString
	sw $v0, 5816($sp)
	lw $a0, 5816($sp)
	la $a1, string_235
	jal stringAdd
	sw $v0, 5824($sp)
	lw $a0, 5824($sp)
	jal print
	lw $a0, 940($sp)
	jal toString
	sw $v0, 5832($sp)
	lw $a0, 5832($sp)
	la $a1, string_236
	jal stringAdd
	sw $v0, 5840($sp)
	lw $a0, 5840($sp)
	jal print
	lw $a0, 944($sp)
	jal toString
	sw $v0, 5848($sp)
	lw $a0, 5848($sp)
	la $a1, string_237
	jal stringAdd
	sw $v0, 5856($sp)
	lw $a0, 5856($sp)
	jal print
	lw $a0, 948($sp)
	jal toString
	sw $v0, 5864($sp)
	lw $a0, 5864($sp)
	la $a1, string_238
	jal stringAdd
	sw $v0, 5872($sp)
	lw $a0, 5872($sp)
	jal print
	lw $a0, 952($sp)
	jal toString
	sw $v0, 5880($sp)
	lw $a0, 5880($sp)
	la $a1, string_239
	jal stringAdd
	sw $v0, 5888($sp)
	lw $a0, 5888($sp)
	jal print
	lw $a0, 956($sp)
	jal toString
	sw $v0, 5896($sp)
	lw $a0, 5896($sp)
	la $a1, string_240
	jal stringAdd
	sw $v0, 5904($sp)
	lw $a0, 5904($sp)
	jal print
	lw $a0, 960($sp)
	jal toString
	sw $v0, 5912($sp)
	lw $a0, 5912($sp)
	la $a1, string_241
	jal stringAdd
	sw $v0, 5920($sp)
	lw $a0, 5920($sp)
	jal print
	lw $a0, 964($sp)
	jal toString
	sw $v0, 5928($sp)
	lw $a0, 5928($sp)
	la $a1, string_242
	jal stringAdd
	sw $v0, 5936($sp)
	lw $a0, 5936($sp)
	jal print
	lw $a0, 968($sp)
	jal toString
	sw $v0, 5944($sp)
	lw $a0, 5944($sp)
	la $a1, string_243
	jal stringAdd
	sw $v0, 5952($sp)
	lw $a0, 5952($sp)
	jal print
	lw $a0, 972($sp)
	jal toString
	sw $v0, 5960($sp)
	lw $a0, 5960($sp)
	la $a1, string_244
	jal stringAdd
	sw $v0, 5968($sp)
	lw $a0, 5968($sp)
	jal print
	lw $a0, 976($sp)
	jal toString
	sw $v0, 5976($sp)
	lw $a0, 5976($sp)
	la $a1, string_245
	jal stringAdd
	sw $v0, 5984($sp)
	lw $a0, 5984($sp)
	jal print
	lw $a0, 980($sp)
	jal toString
	sw $v0, 5992($sp)
	lw $a0, 5992($sp)
	la $a1, string_246
	jal stringAdd
	sw $v0, 6000($sp)
	lw $a0, 6000($sp)
	jal print
	lw $a0, 984($sp)
	jal toString
	sw $v0, 6008($sp)
	lw $a0, 6008($sp)
	la $a1, string_247
	jal stringAdd
	sw $v0, 6016($sp)
	lw $a0, 6016($sp)
	jal print
	lw $a0, 988($sp)
	jal toString
	sw $v0, 6024($sp)
	lw $a0, 6024($sp)
	la $a1, string_248
	jal stringAdd
	sw $v0, 6032($sp)
	lw $a0, 6032($sp)
	jal print
	lw $a0, 992($sp)
	jal toString
	sw $v0, 6040($sp)
	lw $a0, 6040($sp)
	la $a1, string_249
	jal stringAdd
	sw $v0, 6048($sp)
	lw $a0, 6048($sp)
	jal print
	lw $a0, 996($sp)
	jal toString
	sw $v0, 6056($sp)
	lw $a0, 6056($sp)
	la $a1, string_250
	jal stringAdd
	sw $v0, 6064($sp)
	lw $a0, 6064($sp)
	jal print
	lw $a0, 1000($sp)
	jal toString
	sw $v0, 6072($sp)
	lw $a0, 6072($sp)
	la $a1, string_251
	jal stringAdd
	sw $v0, 6080($sp)
	lw $a0, 6080($sp)
	jal print
	lw $a0, 1004($sp)
	jal toString
	sw $v0, 6088($sp)
	lw $a0, 6088($sp)
	la $a1, string_252
	jal stringAdd
	sw $v0, 6096($sp)
	lw $a0, 6096($sp)
	jal print
	lw $a0, 1008($sp)
	jal toString
	sw $v0, 6104($sp)
	lw $a0, 6104($sp)
	la $a1, string_253
	jal stringAdd
	sw $v0, 6112($sp)
	lw $a0, 6112($sp)
	jal print
	lw $a0, 1012($sp)
	jal toString
	sw $v0, 6120($sp)
	lw $a0, 6120($sp)
	la $a1, string_254
	jal stringAdd
	sw $v0, 6128($sp)
	lw $a0, 6128($sp)
	jal print
	lw $a0, 1016($sp)
	jal toString
	sw $v0, 6136($sp)
	lw $a0, 6136($sp)
	la $a1, string_255
	jal stringAdd
	sw $v0, 6144($sp)
	lw $a0, 6144($sp)
	jal print
	lw $a0, 1020($sp)
	jal toString
	sw $v0, 6152($sp)
	lw $a0, 6152($sp)
	la $a1, string_256
	jal stringAdd
	sw $v0, 6160($sp)
	lw $a0, 6160($sp)
	jal print
	la $a0, string_257
	jal println
	lw $a0, 0($sp)
	jal toString
	sw $v0, 6172($sp)
	lw $a0, 6172($sp)
	la $a1, string_258
	jal stringAdd
	sw $v0, 6180($sp)
	lw $a0, 6180($sp)
	jal print
	lw $a0, 4($sp)
	jal toString
	sw $v0, 6188($sp)
	lw $a0, 6188($sp)
	la $a1, string_259
	jal stringAdd
	sw $v0, 6196($sp)
	lw $a0, 6196($sp)
	jal print
	lw $a0, 8($sp)
	jal toString
	sw $v0, 6204($sp)
	lw $a0, 6204($sp)
	la $a1, string_260
	jal stringAdd
	sw $v0, 6212($sp)
	lw $a0, 6212($sp)
	jal print
	lw $a0, 12($sp)
	jal toString
	sw $v0, 6220($sp)
	lw $a0, 6220($sp)
	la $a1, string_261
	jal stringAdd
	sw $v0, 6228($sp)
	lw $a0, 6228($sp)
	jal print
	lw $a0, 16($sp)
	jal toString
	sw $v0, 6236($sp)
	lw $a0, 6236($sp)
	la $a1, string_262
	jal stringAdd
	sw $v0, 6244($sp)
	lw $a0, 6244($sp)
	jal print
	lw $a0, 20($sp)
	jal toString
	sw $v0, 6252($sp)
	lw $a0, 6252($sp)
	la $a1, string_263
	jal stringAdd
	sw $v0, 6260($sp)
	lw $a0, 6260($sp)
	jal print
	lw $a0, 24($sp)
	jal toString
	sw $v0, 6268($sp)
	lw $a0, 6268($sp)
	la $a1, string_264
	jal stringAdd
	sw $v0, 6276($sp)
	lw $a0, 6276($sp)
	jal print
	lw $a0, 28($sp)
	jal toString
	sw $v0, 6284($sp)
	lw $a0, 6284($sp)
	la $a1, string_265
	jal stringAdd
	sw $v0, 6292($sp)
	lw $a0, 6292($sp)
	jal print
	lw $a0, 32($sp)
	jal toString
	sw $v0, 6300($sp)
	lw $a0, 6300($sp)
	la $a1, string_266
	jal stringAdd
	sw $v0, 6308($sp)
	lw $a0, 6308($sp)
	jal print
	lw $a0, 36($sp)
	jal toString
	sw $v0, 6316($sp)
	lw $a0, 6316($sp)
	la $a1, string_267
	jal stringAdd
	sw $v0, 6324($sp)
	lw $a0, 6324($sp)
	jal print
	lw $a0, 40($sp)
	jal toString
	sw $v0, 6332($sp)
	lw $a0, 6332($sp)
	la $a1, string_268
	jal stringAdd
	sw $v0, 6340($sp)
	lw $a0, 6340($sp)
	jal print
	lw $a0, 44($sp)
	jal toString
	sw $v0, 6348($sp)
	lw $a0, 6348($sp)
	la $a1, string_269
	jal stringAdd
	sw $v0, 6356($sp)
	lw $a0, 6356($sp)
	jal print
	lw $a0, 48($sp)
	jal toString
	sw $v0, 6364($sp)
	lw $a0, 6364($sp)
	la $a1, string_270
	jal stringAdd
	sw $v0, 6372($sp)
	lw $a0, 6372($sp)
	jal print
	lw $a0, 52($sp)
	jal toString
	sw $v0, 6380($sp)
	lw $a0, 6380($sp)
	la $a1, string_271
	jal stringAdd
	sw $v0, 6388($sp)
	lw $a0, 6388($sp)
	jal print
	lw $a0, 56($sp)
	jal toString
	sw $v0, 6396($sp)
	lw $a0, 6396($sp)
	la $a1, string_272
	jal stringAdd
	sw $v0, 6404($sp)
	lw $a0, 6404($sp)
	jal print
	lw $a0, 60($sp)
	jal toString
	sw $v0, 6412($sp)
	lw $a0, 6412($sp)
	la $a1, string_273
	jal stringAdd
	sw $v0, 6420($sp)
	lw $a0, 6420($sp)
	jal print
	lw $a0, 64($sp)
	jal toString
	sw $v0, 6428($sp)
	lw $a0, 6428($sp)
	la $a1, string_274
	jal stringAdd
	sw $v0, 6436($sp)
	lw $a0, 6436($sp)
	jal print
	lw $a0, 68($sp)
	jal toString
	sw $v0, 6444($sp)
	lw $a0, 6444($sp)
	la $a1, string_275
	jal stringAdd
	sw $v0, 6452($sp)
	lw $a0, 6452($sp)
	jal print
	lw $a0, 72($sp)
	jal toString
	sw $v0, 6460($sp)
	lw $a0, 6460($sp)
	la $a1, string_276
	jal stringAdd
	sw $v0, 6468($sp)
	lw $a0, 6468($sp)
	jal print
	lw $a0, 76($sp)
	jal toString
	sw $v0, 6476($sp)
	lw $a0, 6476($sp)
	la $a1, string_277
	jal stringAdd
	sw $v0, 6484($sp)
	lw $a0, 6484($sp)
	jal print
	lw $a0, 80($sp)
	jal toString
	sw $v0, 6492($sp)
	lw $a0, 6492($sp)
	la $a1, string_278
	jal stringAdd
	sw $v0, 6500($sp)
	lw $a0, 6500($sp)
	jal print
	lw $a0, 84($sp)
	jal toString
	sw $v0, 6508($sp)
	lw $a0, 6508($sp)
	la $a1, string_279
	jal stringAdd
	sw $v0, 6516($sp)
	lw $a0, 6516($sp)
	jal print
	lw $a0, 88($sp)
	jal toString
	sw $v0, 6524($sp)
	lw $a0, 6524($sp)
	la $a1, string_280
	jal stringAdd
	sw $v0, 6532($sp)
	lw $a0, 6532($sp)
	jal print
	lw $a0, 92($sp)
	jal toString
	sw $v0, 6540($sp)
	lw $a0, 6540($sp)
	la $a1, string_281
	jal stringAdd
	sw $v0, 6548($sp)
	lw $a0, 6548($sp)
	jal print
	lw $a0, 96($sp)
	jal toString
	sw $v0, 6556($sp)
	lw $a0, 6556($sp)
	la $a1, string_282
	jal stringAdd
	sw $v0, 6564($sp)
	lw $a0, 6564($sp)
	jal print
	lw $a0, 100($sp)
	jal toString
	sw $v0, 6572($sp)
	lw $a0, 6572($sp)
	la $a1, string_283
	jal stringAdd
	sw $v0, 6580($sp)
	lw $a0, 6580($sp)
	jal print
	lw $a0, 104($sp)
	jal toString
	sw $v0, 6588($sp)
	lw $a0, 6588($sp)
	la $a1, string_284
	jal stringAdd
	sw $v0, 6596($sp)
	lw $a0, 6596($sp)
	jal print
	lw $a0, 108($sp)
	jal toString
	sw $v0, 6604($sp)
	lw $a0, 6604($sp)
	la $a1, string_285
	jal stringAdd
	sw $v0, 6612($sp)
	lw $a0, 6612($sp)
	jal print
	lw $a0, 112($sp)
	jal toString
	sw $v0, 6620($sp)
	lw $a0, 6620($sp)
	la $a1, string_286
	jal stringAdd
	sw $v0, 6628($sp)
	lw $a0, 6628($sp)
	jal print
	lw $a0, 116($sp)
	jal toString
	sw $v0, 6636($sp)
	lw $a0, 6636($sp)
	la $a1, string_287
	jal stringAdd
	sw $v0, 6644($sp)
	lw $a0, 6644($sp)
	jal print
	lw $a0, 120($sp)
	jal toString
	sw $v0, 6652($sp)
	lw $a0, 6652($sp)
	la $a1, string_288
	jal stringAdd
	sw $v0, 6660($sp)
	lw $a0, 6660($sp)
	jal print
	lw $a0, 124($sp)
	jal toString
	sw $v0, 6668($sp)
	lw $a0, 6668($sp)
	la $a1, string_289
	jal stringAdd
	sw $v0, 6676($sp)
	lw $a0, 6676($sp)
	jal print
	lw $a0, 128($sp)
	jal toString
	sw $v0, 6684($sp)
	lw $a0, 6684($sp)
	la $a1, string_290
	jal stringAdd
	sw $v0, 6692($sp)
	lw $a0, 6692($sp)
	jal print
	lw $a0, 132($sp)
	jal toString
	sw $v0, 6700($sp)
	lw $a0, 6700($sp)
	la $a1, string_291
	jal stringAdd
	sw $v0, 6708($sp)
	lw $a0, 6708($sp)
	jal print
	lw $a0, 136($sp)
	jal toString
	sw $v0, 6716($sp)
	lw $a0, 6716($sp)
	la $a1, string_292
	jal stringAdd
	sw $v0, 6724($sp)
	lw $a0, 6724($sp)
	jal print
	lw $a0, 140($sp)
	jal toString
	sw $v0, 6732($sp)
	lw $a0, 6732($sp)
	la $a1, string_293
	jal stringAdd
	sw $v0, 6740($sp)
	lw $a0, 6740($sp)
	jal print
	lw $a0, 144($sp)
	jal toString
	sw $v0, 6748($sp)
	lw $a0, 6748($sp)
	la $a1, string_294
	jal stringAdd
	sw $v0, 6756($sp)
	lw $a0, 6756($sp)
	jal print
	lw $a0, 148($sp)
	jal toString
	sw $v0, 6764($sp)
	lw $a0, 6764($sp)
	la $a1, string_295
	jal stringAdd
	sw $v0, 6772($sp)
	lw $a0, 6772($sp)
	jal print
	lw $a0, 152($sp)
	jal toString
	sw $v0, 6780($sp)
	lw $a0, 6780($sp)
	la $a1, string_296
	jal stringAdd
	sw $v0, 6788($sp)
	lw $a0, 6788($sp)
	jal print
	lw $a0, 156($sp)
	jal toString
	sw $v0, 6796($sp)
	lw $a0, 6796($sp)
	la $a1, string_297
	jal stringAdd
	sw $v0, 6804($sp)
	lw $a0, 6804($sp)
	jal print
	lw $a0, 160($sp)
	jal toString
	sw $v0, 6812($sp)
	lw $a0, 6812($sp)
	la $a1, string_298
	jal stringAdd
	sw $v0, 6820($sp)
	lw $a0, 6820($sp)
	jal print
	lw $a0, 164($sp)
	jal toString
	sw $v0, 6828($sp)
	lw $a0, 6828($sp)
	la $a1, string_299
	jal stringAdd
	sw $v0, 6836($sp)
	lw $a0, 6836($sp)
	jal print
	lw $a0, 168($sp)
	jal toString
	sw $v0, 6844($sp)
	lw $a0, 6844($sp)
	la $a1, string_300
	jal stringAdd
	sw $v0, 6852($sp)
	lw $a0, 6852($sp)
	jal print
	lw $a0, 172($sp)
	jal toString
	sw $v0, 6860($sp)
	lw $a0, 6860($sp)
	la $a1, string_301
	jal stringAdd
	sw $v0, 6868($sp)
	lw $a0, 6868($sp)
	jal print
	lw $a0, 176($sp)
	jal toString
	sw $v0, 6876($sp)
	lw $a0, 6876($sp)
	la $a1, string_302
	jal stringAdd
	sw $v0, 6884($sp)
	lw $a0, 6884($sp)
	jal print
	lw $a0, 180($sp)
	jal toString
	sw $v0, 6892($sp)
	lw $a0, 6892($sp)
	la $a1, string_303
	jal stringAdd
	sw $v0, 6900($sp)
	lw $a0, 6900($sp)
	jal print
	lw $a0, 184($sp)
	jal toString
	sw $v0, 6908($sp)
	lw $a0, 6908($sp)
	la $a1, string_304
	jal stringAdd
	sw $v0, 6916($sp)
	lw $a0, 6916($sp)
	jal print
	lw $a0, 188($sp)
	jal toString
	sw $v0, 6924($sp)
	lw $a0, 6924($sp)
	la $a1, string_305
	jal stringAdd
	sw $v0, 6932($sp)
	lw $a0, 6932($sp)
	jal print
	lw $a0, 192($sp)
	jal toString
	sw $v0, 6940($sp)
	lw $a0, 6940($sp)
	la $a1, string_306
	jal stringAdd
	sw $v0, 6948($sp)
	lw $a0, 6948($sp)
	jal print
	lw $a0, 196($sp)
	jal toString
	sw $v0, 6956($sp)
	lw $a0, 6956($sp)
	la $a1, string_307
	jal stringAdd
	sw $v0, 6964($sp)
	lw $a0, 6964($sp)
	jal print
	lw $a0, 200($sp)
	jal toString
	sw $v0, 6972($sp)
	lw $a0, 6972($sp)
	la $a1, string_308
	jal stringAdd
	sw $v0, 6980($sp)
	lw $a0, 6980($sp)
	jal print
	lw $a0, 204($sp)
	jal toString
	sw $v0, 6988($sp)
	lw $a0, 6988($sp)
	la $a1, string_309
	jal stringAdd
	sw $v0, 6996($sp)
	lw $a0, 6996($sp)
	jal print
	lw $a0, 208($sp)
	jal toString
	sw $v0, 7004($sp)
	lw $a0, 7004($sp)
	la $a1, string_310
	jal stringAdd
	sw $v0, 7012($sp)
	lw $a0, 7012($sp)
	jal print
	lw $a0, 212($sp)
	jal toString
	sw $v0, 7020($sp)
	lw $a0, 7020($sp)
	la $a1, string_311
	jal stringAdd
	sw $v0, 7028($sp)
	lw $a0, 7028($sp)
	jal print
	lw $a0, 216($sp)
	jal toString
	sw $v0, 7036($sp)
	lw $a0, 7036($sp)
	la $a1, string_312
	jal stringAdd
	sw $v0, 7044($sp)
	lw $a0, 7044($sp)
	jal print
	lw $a0, 220($sp)
	jal toString
	sw $v0, 7052($sp)
	lw $a0, 7052($sp)
	la $a1, string_313
	jal stringAdd
	sw $v0, 7060($sp)
	lw $a0, 7060($sp)
	jal print
	lw $a0, 224($sp)
	jal toString
	sw $v0, 7068($sp)
	lw $a0, 7068($sp)
	la $a1, string_314
	jal stringAdd
	sw $v0, 7076($sp)
	lw $a0, 7076($sp)
	jal print
	lw $a0, 228($sp)
	jal toString
	sw $v0, 7084($sp)
	lw $a0, 7084($sp)
	la $a1, string_315
	jal stringAdd
	sw $v0, 7092($sp)
	lw $a0, 7092($sp)
	jal print
	lw $a0, 232($sp)
	jal toString
	sw $v0, 7100($sp)
	lw $a0, 7100($sp)
	la $a1, string_316
	jal stringAdd
	sw $v0, 7108($sp)
	lw $a0, 7108($sp)
	jal print
	lw $a0, 236($sp)
	jal toString
	sw $v0, 7116($sp)
	lw $a0, 7116($sp)
	la $a1, string_317
	jal stringAdd
	sw $v0, 7124($sp)
	lw $a0, 7124($sp)
	jal print
	lw $a0, 240($sp)
	jal toString
	sw $v0, 7132($sp)
	lw $a0, 7132($sp)
	la $a1, string_318
	jal stringAdd
	sw $v0, 7140($sp)
	lw $a0, 7140($sp)
	jal print
	lw $a0, 244($sp)
	jal toString
	sw $v0, 7148($sp)
	lw $a0, 7148($sp)
	la $a1, string_319
	jal stringAdd
	sw $v0, 7156($sp)
	lw $a0, 7156($sp)
	jal print
	lw $a0, 248($sp)
	jal toString
	sw $v0, 7164($sp)
	lw $a0, 7164($sp)
	la $a1, string_320
	jal stringAdd
	sw $v0, 7172($sp)
	lw $a0, 7172($sp)
	jal print
	lw $a0, 252($sp)
	jal toString
	sw $v0, 7180($sp)
	lw $a0, 7180($sp)
	la $a1, string_321
	jal stringAdd
	sw $v0, 7188($sp)
	lw $a0, 7188($sp)
	jal print
	lw $a0, 256($sp)
	jal toString
	sw $v0, 7196($sp)
	lw $a0, 7196($sp)
	la $a1, string_322
	jal stringAdd
	sw $v0, 7204($sp)
	lw $a0, 7204($sp)
	jal print
	lw $a0, 260($sp)
	jal toString
	sw $v0, 7212($sp)
	lw $a0, 7212($sp)
	la $a1, string_323
	jal stringAdd
	sw $v0, 7220($sp)
	lw $a0, 7220($sp)
	jal print
	lw $a0, 264($sp)
	jal toString
	sw $v0, 7228($sp)
	lw $a0, 7228($sp)
	la $a1, string_324
	jal stringAdd
	sw $v0, 7236($sp)
	lw $a0, 7236($sp)
	jal print
	lw $a0, 268($sp)
	jal toString
	sw $v0, 7244($sp)
	lw $a0, 7244($sp)
	la $a1, string_325
	jal stringAdd
	sw $v0, 7252($sp)
	lw $a0, 7252($sp)
	jal print
	lw $a0, 272($sp)
	jal toString
	sw $v0, 7260($sp)
	lw $a0, 7260($sp)
	la $a1, string_326
	jal stringAdd
	sw $v0, 7268($sp)
	lw $a0, 7268($sp)
	jal print
	lw $a0, 276($sp)
	jal toString
	sw $v0, 7276($sp)
	lw $a0, 7276($sp)
	la $a1, string_327
	jal stringAdd
	sw $v0, 7284($sp)
	lw $a0, 7284($sp)
	jal print
	lw $a0, 280($sp)
	jal toString
	sw $v0, 7292($sp)
	lw $a0, 7292($sp)
	la $a1, string_328
	jal stringAdd
	sw $v0, 7300($sp)
	lw $a0, 7300($sp)
	jal print
	lw $a0, 284($sp)
	jal toString
	sw $v0, 7308($sp)
	lw $a0, 7308($sp)
	la $a1, string_329
	jal stringAdd
	sw $v0, 7316($sp)
	lw $a0, 7316($sp)
	jal print
	lw $a0, 288($sp)
	jal toString
	sw $v0, 7324($sp)
	lw $a0, 7324($sp)
	la $a1, string_330
	jal stringAdd
	sw $v0, 7332($sp)
	lw $a0, 7332($sp)
	jal print
	lw $a0, 292($sp)
	jal toString
	sw $v0, 7340($sp)
	lw $a0, 7340($sp)
	la $a1, string_331
	jal stringAdd
	sw $v0, 7348($sp)
	lw $a0, 7348($sp)
	jal print
	lw $a0, 296($sp)
	jal toString
	sw $v0, 7356($sp)
	lw $a0, 7356($sp)
	la $a1, string_332
	jal stringAdd
	sw $v0, 7364($sp)
	lw $a0, 7364($sp)
	jal print
	lw $a0, 300($sp)
	jal toString
	sw $v0, 7372($sp)
	lw $a0, 7372($sp)
	la $a1, string_333
	jal stringAdd
	sw $v0, 7380($sp)
	lw $a0, 7380($sp)
	jal print
	lw $a0, 304($sp)
	jal toString
	sw $v0, 7388($sp)
	lw $a0, 7388($sp)
	la $a1, string_334
	jal stringAdd
	sw $v0, 7396($sp)
	lw $a0, 7396($sp)
	jal print
	lw $a0, 308($sp)
	jal toString
	sw $v0, 7404($sp)
	lw $a0, 7404($sp)
	la $a1, string_335
	jal stringAdd
	sw $v0, 7412($sp)
	lw $a0, 7412($sp)
	jal print
	lw $a0, 312($sp)
	jal toString
	sw $v0, 7420($sp)
	lw $a0, 7420($sp)
	la $a1, string_336
	jal stringAdd
	sw $v0, 7428($sp)
	lw $a0, 7428($sp)
	jal print
	lw $a0, 316($sp)
	jal toString
	sw $v0, 7436($sp)
	lw $a0, 7436($sp)
	la $a1, string_337
	jal stringAdd
	sw $v0, 7444($sp)
	lw $a0, 7444($sp)
	jal print
	lw $a0, 320($sp)
	jal toString
	sw $v0, 7452($sp)
	lw $a0, 7452($sp)
	la $a1, string_338
	jal stringAdd
	sw $v0, 7460($sp)
	lw $a0, 7460($sp)
	jal print
	lw $a0, 324($sp)
	jal toString
	sw $v0, 7468($sp)
	lw $a0, 7468($sp)
	la $a1, string_339
	jal stringAdd
	sw $v0, 7476($sp)
	lw $a0, 7476($sp)
	jal print
	lw $a0, 328($sp)
	jal toString
	sw $v0, 7484($sp)
	lw $a0, 7484($sp)
	la $a1, string_340
	jal stringAdd
	sw $v0, 7492($sp)
	lw $a0, 7492($sp)
	jal print
	lw $a0, 332($sp)
	jal toString
	sw $v0, 7500($sp)
	lw $a0, 7500($sp)
	la $a1, string_341
	jal stringAdd
	sw $v0, 7508($sp)
	lw $a0, 7508($sp)
	jal print
	lw $a0, 336($sp)
	jal toString
	sw $v0, 7516($sp)
	lw $a0, 7516($sp)
	la $a1, string_342
	jal stringAdd
	sw $v0, 7524($sp)
	lw $a0, 7524($sp)
	jal print
	lw $a0, 340($sp)
	jal toString
	sw $v0, 7532($sp)
	lw $a0, 7532($sp)
	la $a1, string_343
	jal stringAdd
	sw $v0, 7540($sp)
	lw $a0, 7540($sp)
	jal print
	lw $a0, 344($sp)
	jal toString
	sw $v0, 7548($sp)
	lw $a0, 7548($sp)
	la $a1, string_344
	jal stringAdd
	sw $v0, 7556($sp)
	lw $a0, 7556($sp)
	jal print
	lw $a0, 348($sp)
	jal toString
	sw $v0, 7564($sp)
	lw $a0, 7564($sp)
	la $a1, string_345
	jal stringAdd
	sw $v0, 7572($sp)
	lw $a0, 7572($sp)
	jal print
	lw $a0, 352($sp)
	jal toString
	sw $v0, 7580($sp)
	lw $a0, 7580($sp)
	la $a1, string_346
	jal stringAdd
	sw $v0, 7588($sp)
	lw $a0, 7588($sp)
	jal print
	lw $a0, 356($sp)
	jal toString
	sw $v0, 7596($sp)
	lw $a0, 7596($sp)
	la $a1, string_347
	jal stringAdd
	sw $v0, 7604($sp)
	lw $a0, 7604($sp)
	jal print
	lw $a0, 360($sp)
	jal toString
	sw $v0, 7612($sp)
	lw $a0, 7612($sp)
	la $a1, string_348
	jal stringAdd
	sw $v0, 7620($sp)
	lw $a0, 7620($sp)
	jal print
	lw $a0, 364($sp)
	jal toString
	sw $v0, 7628($sp)
	lw $a0, 7628($sp)
	la $a1, string_349
	jal stringAdd
	sw $v0, 7636($sp)
	lw $a0, 7636($sp)
	jal print
	lw $a0, 368($sp)
	jal toString
	sw $v0, 7644($sp)
	lw $a0, 7644($sp)
	la $a1, string_350
	jal stringAdd
	sw $v0, 7652($sp)
	lw $a0, 7652($sp)
	jal print
	lw $a0, 372($sp)
	jal toString
	sw $v0, 7660($sp)
	lw $a0, 7660($sp)
	la $a1, string_351
	jal stringAdd
	sw $v0, 7668($sp)
	lw $a0, 7668($sp)
	jal print
	lw $a0, 376($sp)
	jal toString
	sw $v0, 7676($sp)
	lw $a0, 7676($sp)
	la $a1, string_352
	jal stringAdd
	sw $v0, 7684($sp)
	lw $a0, 7684($sp)
	jal print
	lw $a0, 380($sp)
	jal toString
	sw $v0, 7692($sp)
	lw $a0, 7692($sp)
	la $a1, string_353
	jal stringAdd
	sw $v0, 7700($sp)
	lw $a0, 7700($sp)
	jal print
	lw $a0, 384($sp)
	jal toString
	sw $v0, 7708($sp)
	lw $a0, 7708($sp)
	la $a1, string_354
	jal stringAdd
	sw $v0, 7716($sp)
	lw $a0, 7716($sp)
	jal print
	lw $a0, 388($sp)
	jal toString
	sw $v0, 7724($sp)
	lw $a0, 7724($sp)
	la $a1, string_355
	jal stringAdd
	sw $v0, 7732($sp)
	lw $a0, 7732($sp)
	jal print
	lw $a0, 392($sp)
	jal toString
	sw $v0, 7740($sp)
	lw $a0, 7740($sp)
	la $a1, string_356
	jal stringAdd
	sw $v0, 7748($sp)
	lw $a0, 7748($sp)
	jal print
	lw $a0, 396($sp)
	jal toString
	sw $v0, 7756($sp)
	lw $a0, 7756($sp)
	la $a1, string_357
	jal stringAdd
	sw $v0, 7764($sp)
	lw $a0, 7764($sp)
	jal print
	lw $a0, 400($sp)
	jal toString
	sw $v0, 7772($sp)
	lw $a0, 7772($sp)
	la $a1, string_358
	jal stringAdd
	sw $v0, 7780($sp)
	lw $a0, 7780($sp)
	jal print
	lw $a0, 404($sp)
	jal toString
	sw $v0, 7788($sp)
	lw $a0, 7788($sp)
	la $a1, string_359
	jal stringAdd
	sw $v0, 7796($sp)
	lw $a0, 7796($sp)
	jal print
	lw $a0, 408($sp)
	jal toString
	sw $v0, 7804($sp)
	lw $a0, 7804($sp)
	la $a1, string_360
	jal stringAdd
	sw $v0, 7812($sp)
	lw $a0, 7812($sp)
	jal print
	lw $a0, 412($sp)
	jal toString
	sw $v0, 7820($sp)
	lw $a0, 7820($sp)
	la $a1, string_361
	jal stringAdd
	sw $v0, 7828($sp)
	lw $a0, 7828($sp)
	jal print
	lw $a0, 416($sp)
	jal toString
	sw $v0, 7836($sp)
	lw $a0, 7836($sp)
	la $a1, string_362
	jal stringAdd
	sw $v0, 7844($sp)
	lw $a0, 7844($sp)
	jal print
	lw $a0, 420($sp)
	jal toString
	sw $v0, 7852($sp)
	lw $a0, 7852($sp)
	la $a1, string_363
	jal stringAdd
	sw $v0, 7860($sp)
	lw $a0, 7860($sp)
	jal print
	lw $a0, 424($sp)
	jal toString
	sw $v0, 7868($sp)
	lw $a0, 7868($sp)
	la $a1, string_364
	jal stringAdd
	sw $v0, 7876($sp)
	lw $a0, 7876($sp)
	jal print
	lw $a0, 428($sp)
	jal toString
	sw $v0, 7884($sp)
	lw $a0, 7884($sp)
	la $a1, string_365
	jal stringAdd
	sw $v0, 7892($sp)
	lw $a0, 7892($sp)
	jal print
	lw $a0, 432($sp)
	jal toString
	sw $v0, 7900($sp)
	lw $a0, 7900($sp)
	la $a1, string_366
	jal stringAdd
	sw $v0, 7908($sp)
	lw $a0, 7908($sp)
	jal print
	lw $a0, 436($sp)
	jal toString
	sw $v0, 7916($sp)
	lw $a0, 7916($sp)
	la $a1, string_367
	jal stringAdd
	sw $v0, 7924($sp)
	lw $a0, 7924($sp)
	jal print
	lw $a0, 440($sp)
	jal toString
	sw $v0, 7932($sp)
	lw $a0, 7932($sp)
	la $a1, string_368
	jal stringAdd
	sw $v0, 7940($sp)
	lw $a0, 7940($sp)
	jal print
	lw $a0, 444($sp)
	jal toString
	sw $v0, 7948($sp)
	lw $a0, 7948($sp)
	la $a1, string_369
	jal stringAdd
	sw $v0, 7956($sp)
	lw $a0, 7956($sp)
	jal print
	lw $a0, 448($sp)
	jal toString
	sw $v0, 7964($sp)
	lw $a0, 7964($sp)
	la $a1, string_370
	jal stringAdd
	sw $v0, 7972($sp)
	lw $a0, 7972($sp)
	jal print
	lw $a0, 452($sp)
	jal toString
	sw $v0, 7980($sp)
	lw $a0, 7980($sp)
	la $a1, string_371
	jal stringAdd
	sw $v0, 7988($sp)
	lw $a0, 7988($sp)
	jal print
	lw $a0, 456($sp)
	jal toString
	sw $v0, 7996($sp)
	lw $a0, 7996($sp)
	la $a1, string_372
	jal stringAdd
	sw $v0, 8004($sp)
	lw $a0, 8004($sp)
	jal print
	lw $a0, 460($sp)
	jal toString
	sw $v0, 8012($sp)
	lw $a0, 8012($sp)
	la $a1, string_373
	jal stringAdd
	sw $v0, 8020($sp)
	lw $a0, 8020($sp)
	jal print
	lw $a0, 464($sp)
	jal toString
	sw $v0, 8028($sp)
	lw $a0, 8028($sp)
	la $a1, string_374
	jal stringAdd
	sw $v0, 8036($sp)
	lw $a0, 8036($sp)
	jal print
	lw $a0, 468($sp)
	jal toString
	sw $v0, 8044($sp)
	lw $a0, 8044($sp)
	la $a1, string_375
	jal stringAdd
	sw $v0, 8052($sp)
	lw $a0, 8052($sp)
	jal print
	lw $a0, 472($sp)
	jal toString
	sw $v0, 8060($sp)
	lw $a0, 8060($sp)
	la $a1, string_376
	jal stringAdd
	sw $v0, 8068($sp)
	lw $a0, 8068($sp)
	jal print
	lw $a0, 476($sp)
	jal toString
	sw $v0, 8076($sp)
	lw $a0, 8076($sp)
	la $a1, string_377
	jal stringAdd
	sw $v0, 8084($sp)
	lw $a0, 8084($sp)
	jal print
	lw $a0, 480($sp)
	jal toString
	sw $v0, 8092($sp)
	lw $a0, 8092($sp)
	la $a1, string_378
	jal stringAdd
	sw $v0, 8100($sp)
	lw $a0, 8100($sp)
	jal print
	lw $a0, 484($sp)
	jal toString
	sw $v0, 8108($sp)
	lw $a0, 8108($sp)
	la $a1, string_379
	jal stringAdd
	sw $v0, 8116($sp)
	lw $a0, 8116($sp)
	jal print
	lw $a0, 488($sp)
	jal toString
	sw $v0, 8124($sp)
	lw $a0, 8124($sp)
	la $a1, string_380
	jal stringAdd
	sw $v0, 8132($sp)
	lw $a0, 8132($sp)
	jal print
	lw $a0, 492($sp)
	jal toString
	sw $v0, 8140($sp)
	lw $a0, 8140($sp)
	la $a1, string_381
	jal stringAdd
	sw $v0, 8148($sp)
	lw $a0, 8148($sp)
	jal print
	lw $a0, 496($sp)
	jal toString
	sw $v0, 8156($sp)
	lw $a0, 8156($sp)
	la $a1, string_382
	jal stringAdd
	sw $v0, 8164($sp)
	lw $a0, 8164($sp)
	jal print
	lw $a0, 500($sp)
	jal toString
	sw $v0, 8172($sp)
	lw $a0, 8172($sp)
	la $a1, string_383
	jal stringAdd
	sw $v0, 8180($sp)
	lw $a0, 8180($sp)
	jal print
	lw $a0, 504($sp)
	jal toString
	sw $v0, 8188($sp)
	lw $a0, 8188($sp)
	la $a1, string_384
	jal stringAdd
	sw $v0, 8196($sp)
	lw $a0, 8196($sp)
	jal print
	lw $a0, 508($sp)
	jal toString
	sw $v0, 8204($sp)
	lw $a0, 8204($sp)
	la $a1, string_385
	jal stringAdd
	sw $v0, 8212($sp)
	lw $a0, 8212($sp)
	jal print
	lw $a0, 512($sp)
	jal toString
	sw $v0, 8220($sp)
	lw $a0, 8220($sp)
	la $a1, string_386
	jal stringAdd
	sw $v0, 8228($sp)
	lw $a0, 8228($sp)
	jal print
	lw $a0, 516($sp)
	jal toString
	sw $v0, 8236($sp)
	lw $a0, 8236($sp)
	la $a1, string_387
	jal stringAdd
	sw $v0, 8244($sp)
	lw $a0, 8244($sp)
	jal print
	lw $a0, 520($sp)
	jal toString
	sw $v0, 8252($sp)
	lw $a0, 8252($sp)
	la $a1, string_388
	jal stringAdd
	sw $v0, 8260($sp)
	lw $a0, 8260($sp)
	jal print
	lw $a0, 524($sp)
	jal toString
	sw $v0, 8268($sp)
	lw $a0, 8268($sp)
	la $a1, string_389
	jal stringAdd
	sw $v0, 8276($sp)
	lw $a0, 8276($sp)
	jal print
	lw $a0, 528($sp)
	jal toString
	sw $v0, 8284($sp)
	lw $a0, 8284($sp)
	la $a1, string_390
	jal stringAdd
	sw $v0, 8292($sp)
	lw $a0, 8292($sp)
	jal print
	lw $a0, 532($sp)
	jal toString
	sw $v0, 8300($sp)
	lw $a0, 8300($sp)
	la $a1, string_391
	jal stringAdd
	sw $v0, 8308($sp)
	lw $a0, 8308($sp)
	jal print
	lw $a0, 536($sp)
	jal toString
	sw $v0, 8316($sp)
	lw $a0, 8316($sp)
	la $a1, string_392
	jal stringAdd
	sw $v0, 8324($sp)
	lw $a0, 8324($sp)
	jal print
	lw $a0, 540($sp)
	jal toString
	sw $v0, 8332($sp)
	lw $a0, 8332($sp)
	la $a1, string_393
	jal stringAdd
	sw $v0, 8340($sp)
	lw $a0, 8340($sp)
	jal print
	lw $a0, 544($sp)
	jal toString
	sw $v0, 8348($sp)
	lw $a0, 8348($sp)
	la $a1, string_394
	jal stringAdd
	sw $v0, 8356($sp)
	lw $a0, 8356($sp)
	jal print
	lw $a0, 548($sp)
	jal toString
	sw $v0, 8364($sp)
	lw $a0, 8364($sp)
	la $a1, string_395
	jal stringAdd
	sw $v0, 8372($sp)
	lw $a0, 8372($sp)
	jal print
	lw $a0, 552($sp)
	jal toString
	sw $v0, 8380($sp)
	lw $a0, 8380($sp)
	la $a1, string_396
	jal stringAdd
	sw $v0, 8388($sp)
	lw $a0, 8388($sp)
	jal print
	lw $a0, 556($sp)
	jal toString
	sw $v0, 8396($sp)
	lw $a0, 8396($sp)
	la $a1, string_397
	jal stringAdd
	sw $v0, 8404($sp)
	lw $a0, 8404($sp)
	jal print
	lw $a0, 560($sp)
	jal toString
	sw $v0, 8412($sp)
	lw $a0, 8412($sp)
	la $a1, string_398
	jal stringAdd
	sw $v0, 8420($sp)
	lw $a0, 8420($sp)
	jal print
	lw $a0, 564($sp)
	jal toString
	sw $v0, 8428($sp)
	lw $a0, 8428($sp)
	la $a1, string_399
	jal stringAdd
	sw $v0, 8436($sp)
	lw $a0, 8436($sp)
	jal print
	lw $a0, 568($sp)
	jal toString
	sw $v0, 8444($sp)
	lw $a0, 8444($sp)
	la $a1, string_400
	jal stringAdd
	sw $v0, 8452($sp)
	lw $a0, 8452($sp)
	jal print
	lw $a0, 572($sp)
	jal toString
	sw $v0, 8460($sp)
	lw $a0, 8460($sp)
	la $a1, string_401
	jal stringAdd
	sw $v0, 8468($sp)
	lw $a0, 8468($sp)
	jal print
	lw $a0, 576($sp)
	jal toString
	sw $v0, 8476($sp)
	lw $a0, 8476($sp)
	la $a1, string_402
	jal stringAdd
	sw $v0, 8484($sp)
	lw $a0, 8484($sp)
	jal print
	lw $a0, 580($sp)
	jal toString
	sw $v0, 8492($sp)
	lw $a0, 8492($sp)
	la $a1, string_403
	jal stringAdd
	sw $v0, 8500($sp)
	lw $a0, 8500($sp)
	jal print
	lw $a0, 584($sp)
	jal toString
	sw $v0, 8508($sp)
	lw $a0, 8508($sp)
	la $a1, string_404
	jal stringAdd
	sw $v0, 8516($sp)
	lw $a0, 8516($sp)
	jal print
	lw $a0, 588($sp)
	jal toString
	sw $v0, 8524($sp)
	lw $a0, 8524($sp)
	la $a1, string_405
	jal stringAdd
	sw $v0, 8532($sp)
	lw $a0, 8532($sp)
	jal print
	lw $a0, 592($sp)
	jal toString
	sw $v0, 8540($sp)
	lw $a0, 8540($sp)
	la $a1, string_406
	jal stringAdd
	sw $v0, 8548($sp)
	lw $a0, 8548($sp)
	jal print
	lw $a0, 596($sp)
	jal toString
	sw $v0, 8556($sp)
	lw $a0, 8556($sp)
	la $a1, string_407
	jal stringAdd
	sw $v0, 8564($sp)
	lw $a0, 8564($sp)
	jal print
	lw $a0, 600($sp)
	jal toString
	sw $v0, 8572($sp)
	lw $a0, 8572($sp)
	la $a1, string_408
	jal stringAdd
	sw $v0, 8580($sp)
	lw $a0, 8580($sp)
	jal print
	lw $a0, 604($sp)
	jal toString
	sw $v0, 8588($sp)
	lw $a0, 8588($sp)
	la $a1, string_409
	jal stringAdd
	sw $v0, 8596($sp)
	lw $a0, 8596($sp)
	jal print
	lw $a0, 608($sp)
	jal toString
	sw $v0, 8604($sp)
	lw $a0, 8604($sp)
	la $a1, string_410
	jal stringAdd
	sw $v0, 8612($sp)
	lw $a0, 8612($sp)
	jal print
	lw $a0, 612($sp)
	jal toString
	sw $v0, 8620($sp)
	lw $a0, 8620($sp)
	la $a1, string_411
	jal stringAdd
	sw $v0, 8628($sp)
	lw $a0, 8628($sp)
	jal print
	lw $a0, 616($sp)
	jal toString
	sw $v0, 8636($sp)
	lw $a0, 8636($sp)
	la $a1, string_412
	jal stringAdd
	sw $v0, 8644($sp)
	lw $a0, 8644($sp)
	jal print
	lw $a0, 620($sp)
	jal toString
	sw $v0, 8652($sp)
	lw $a0, 8652($sp)
	la $a1, string_413
	jal stringAdd
	sw $v0, 8660($sp)
	lw $a0, 8660($sp)
	jal print
	lw $a0, 624($sp)
	jal toString
	sw $v0, 8668($sp)
	lw $a0, 8668($sp)
	la $a1, string_414
	jal stringAdd
	sw $v0, 8676($sp)
	lw $a0, 8676($sp)
	jal print
	lw $a0, 628($sp)
	jal toString
	sw $v0, 8684($sp)
	lw $a0, 8684($sp)
	la $a1, string_415
	jal stringAdd
	sw $v0, 8692($sp)
	lw $a0, 8692($sp)
	jal print
	lw $a0, 632($sp)
	jal toString
	sw $v0, 8700($sp)
	lw $a0, 8700($sp)
	la $a1, string_416
	jal stringAdd
	sw $v0, 8708($sp)
	lw $a0, 8708($sp)
	jal print
	lw $a0, 636($sp)
	jal toString
	sw $v0, 8716($sp)
	lw $a0, 8716($sp)
	la $a1, string_417
	jal stringAdd
	sw $v0, 8724($sp)
	lw $a0, 8724($sp)
	jal print
	lw $a0, 640($sp)
	jal toString
	sw $v0, 8732($sp)
	lw $a0, 8732($sp)
	la $a1, string_418
	jal stringAdd
	sw $v0, 8740($sp)
	lw $a0, 8740($sp)
	jal print
	lw $a0, 644($sp)
	jal toString
	sw $v0, 8748($sp)
	lw $a0, 8748($sp)
	la $a1, string_419
	jal stringAdd
	sw $v0, 8756($sp)
	lw $a0, 8756($sp)
	jal print
	lw $a0, 648($sp)
	jal toString
	sw $v0, 8764($sp)
	lw $a0, 8764($sp)
	la $a1, string_420
	jal stringAdd
	sw $v0, 8772($sp)
	lw $a0, 8772($sp)
	jal print
	lw $a0, 652($sp)
	jal toString
	sw $v0, 8780($sp)
	lw $a0, 8780($sp)
	la $a1, string_421
	jal stringAdd
	sw $v0, 8788($sp)
	lw $a0, 8788($sp)
	jal print
	lw $a0, 656($sp)
	jal toString
	sw $v0, 8796($sp)
	lw $a0, 8796($sp)
	la $a1, string_422
	jal stringAdd
	sw $v0, 8804($sp)
	lw $a0, 8804($sp)
	jal print
	lw $a0, 660($sp)
	jal toString
	sw $v0, 8812($sp)
	lw $a0, 8812($sp)
	la $a1, string_423
	jal stringAdd
	sw $v0, 8820($sp)
	lw $a0, 8820($sp)
	jal print
	lw $a0, 664($sp)
	jal toString
	sw $v0, 8828($sp)
	lw $a0, 8828($sp)
	la $a1, string_424
	jal stringAdd
	sw $v0, 8836($sp)
	lw $a0, 8836($sp)
	jal print
	lw $a0, 668($sp)
	jal toString
	sw $v0, 8844($sp)
	lw $a0, 8844($sp)
	la $a1, string_425
	jal stringAdd
	sw $v0, 8852($sp)
	lw $a0, 8852($sp)
	jal print
	lw $a0, 672($sp)
	jal toString
	sw $v0, 8860($sp)
	lw $a0, 8860($sp)
	la $a1, string_426
	jal stringAdd
	sw $v0, 8868($sp)
	lw $a0, 8868($sp)
	jal print
	lw $a0, 676($sp)
	jal toString
	sw $v0, 8876($sp)
	lw $a0, 8876($sp)
	la $a1, string_427
	jal stringAdd
	sw $v0, 8884($sp)
	lw $a0, 8884($sp)
	jal print
	lw $a0, 680($sp)
	jal toString
	sw $v0, 8892($sp)
	lw $a0, 8892($sp)
	la $a1, string_428
	jal stringAdd
	sw $v0, 8900($sp)
	lw $a0, 8900($sp)
	jal print
	lw $a0, 684($sp)
	jal toString
	sw $v0, 8908($sp)
	lw $a0, 8908($sp)
	la $a1, string_429
	jal stringAdd
	sw $v0, 8916($sp)
	lw $a0, 8916($sp)
	jal print
	lw $a0, 688($sp)
	jal toString
	sw $v0, 8924($sp)
	lw $a0, 8924($sp)
	la $a1, string_430
	jal stringAdd
	sw $v0, 8932($sp)
	lw $a0, 8932($sp)
	jal print
	lw $a0, 692($sp)
	jal toString
	sw $v0, 8940($sp)
	lw $a0, 8940($sp)
	la $a1, string_431
	jal stringAdd
	sw $v0, 8948($sp)
	lw $a0, 8948($sp)
	jal print
	lw $a0, 696($sp)
	jal toString
	sw $v0, 8956($sp)
	lw $a0, 8956($sp)
	la $a1, string_432
	jal stringAdd
	sw $v0, 8964($sp)
	lw $a0, 8964($sp)
	jal print
	lw $a0, 700($sp)
	jal toString
	sw $v0, 8972($sp)
	lw $a0, 8972($sp)
	la $a1, string_433
	jal stringAdd
	sw $v0, 8980($sp)
	lw $a0, 8980($sp)
	jal print
	lw $a0, 704($sp)
	jal toString
	sw $v0, 8988($sp)
	lw $a0, 8988($sp)
	la $a1, string_434
	jal stringAdd
	sw $v0, 8996($sp)
	lw $a0, 8996($sp)
	jal print
	lw $a0, 708($sp)
	jal toString
	sw $v0, 9004($sp)
	lw $a0, 9004($sp)
	la $a1, string_435
	jal stringAdd
	sw $v0, 9012($sp)
	lw $a0, 9012($sp)
	jal print
	lw $a0, 712($sp)
	jal toString
	sw $v0, 9020($sp)
	lw $a0, 9020($sp)
	la $a1, string_436
	jal stringAdd
	sw $v0, 9028($sp)
	lw $a0, 9028($sp)
	jal print
	lw $a0, 716($sp)
	jal toString
	sw $v0, 9036($sp)
	lw $a0, 9036($sp)
	la $a1, string_437
	jal stringAdd
	sw $v0, 9044($sp)
	lw $a0, 9044($sp)
	jal print
	lw $a0, 720($sp)
	jal toString
	sw $v0, 9052($sp)
	lw $a0, 9052($sp)
	la $a1, string_438
	jal stringAdd
	sw $v0, 9060($sp)
	lw $a0, 9060($sp)
	jal print
	lw $a0, 724($sp)
	jal toString
	sw $v0, 9068($sp)
	lw $a0, 9068($sp)
	la $a1, string_439
	jal stringAdd
	sw $v0, 9076($sp)
	lw $a0, 9076($sp)
	jal print
	lw $a0, 728($sp)
	jal toString
	sw $v0, 9084($sp)
	lw $a0, 9084($sp)
	la $a1, string_440
	jal stringAdd
	sw $v0, 9092($sp)
	lw $a0, 9092($sp)
	jal print
	lw $a0, 732($sp)
	jal toString
	sw $v0, 9100($sp)
	lw $a0, 9100($sp)
	la $a1, string_441
	jal stringAdd
	sw $v0, 9108($sp)
	lw $a0, 9108($sp)
	jal print
	lw $a0, 736($sp)
	jal toString
	sw $v0, 9116($sp)
	lw $a0, 9116($sp)
	la $a1, string_442
	jal stringAdd
	sw $v0, 9124($sp)
	lw $a0, 9124($sp)
	jal print
	lw $a0, 740($sp)
	jal toString
	sw $v0, 9132($sp)
	lw $a0, 9132($sp)
	la $a1, string_443
	jal stringAdd
	sw $v0, 9140($sp)
	lw $a0, 9140($sp)
	jal print
	lw $a0, 744($sp)
	jal toString
	sw $v0, 9148($sp)
	lw $a0, 9148($sp)
	la $a1, string_444
	jal stringAdd
	sw $v0, 9156($sp)
	lw $a0, 9156($sp)
	jal print
	lw $a0, 748($sp)
	jal toString
	sw $v0, 9164($sp)
	lw $a0, 9164($sp)
	la $a1, string_445
	jal stringAdd
	sw $v0, 9172($sp)
	lw $a0, 9172($sp)
	jal print
	lw $a0, 752($sp)
	jal toString
	sw $v0, 9180($sp)
	lw $a0, 9180($sp)
	la $a1, string_446
	jal stringAdd
	sw $v0, 9188($sp)
	lw $a0, 9188($sp)
	jal print
	lw $a0, 756($sp)
	jal toString
	sw $v0, 9196($sp)
	lw $a0, 9196($sp)
	la $a1, string_447
	jal stringAdd
	sw $v0, 9204($sp)
	lw $a0, 9204($sp)
	jal print
	lw $a0, 760($sp)
	jal toString
	sw $v0, 9212($sp)
	lw $a0, 9212($sp)
	la $a1, string_448
	jal stringAdd
	sw $v0, 9220($sp)
	lw $a0, 9220($sp)
	jal print
	lw $a0, 764($sp)
	jal toString
	sw $v0, 9228($sp)
	lw $a0, 9228($sp)
	la $a1, string_449
	jal stringAdd
	sw $v0, 9236($sp)
	lw $a0, 9236($sp)
	jal print
	lw $a0, 768($sp)
	jal toString
	sw $v0, 9244($sp)
	lw $a0, 9244($sp)
	la $a1, string_450
	jal stringAdd
	sw $v0, 9252($sp)
	lw $a0, 9252($sp)
	jal print
	lw $a0, 772($sp)
	jal toString
	sw $v0, 9260($sp)
	lw $a0, 9260($sp)
	la $a1, string_451
	jal stringAdd
	sw $v0, 9268($sp)
	lw $a0, 9268($sp)
	jal print
	lw $a0, 776($sp)
	jal toString
	sw $v0, 9276($sp)
	lw $a0, 9276($sp)
	la $a1, string_452
	jal stringAdd
	sw $v0, 9284($sp)
	lw $a0, 9284($sp)
	jal print
	lw $a0, 780($sp)
	jal toString
	sw $v0, 9292($sp)
	lw $a0, 9292($sp)
	la $a1, string_453
	jal stringAdd
	sw $v0, 9300($sp)
	lw $a0, 9300($sp)
	jal print
	lw $a0, 784($sp)
	jal toString
	sw $v0, 9308($sp)
	lw $a0, 9308($sp)
	la $a1, string_454
	jal stringAdd
	sw $v0, 9316($sp)
	lw $a0, 9316($sp)
	jal print
	lw $a0, 788($sp)
	jal toString
	sw $v0, 9324($sp)
	lw $a0, 9324($sp)
	la $a1, string_455
	jal stringAdd
	sw $v0, 9332($sp)
	lw $a0, 9332($sp)
	jal print
	lw $a0, 792($sp)
	jal toString
	sw $v0, 9340($sp)
	lw $a0, 9340($sp)
	la $a1, string_456
	jal stringAdd
	sw $v0, 9348($sp)
	lw $a0, 9348($sp)
	jal print
	lw $a0, 796($sp)
	jal toString
	sw $v0, 9356($sp)
	lw $a0, 9356($sp)
	la $a1, string_457
	jal stringAdd
	sw $v0, 9364($sp)
	lw $a0, 9364($sp)
	jal print
	lw $a0, 800($sp)
	jal toString
	sw $v0, 9372($sp)
	lw $a0, 9372($sp)
	la $a1, string_458
	jal stringAdd
	sw $v0, 9380($sp)
	lw $a0, 9380($sp)
	jal print
	lw $a0, 804($sp)
	jal toString
	sw $v0, 9388($sp)
	lw $a0, 9388($sp)
	la $a1, string_459
	jal stringAdd
	sw $v0, 9396($sp)
	lw $a0, 9396($sp)
	jal print
	lw $a0, 808($sp)
	jal toString
	sw $v0, 9404($sp)
	lw $a0, 9404($sp)
	la $a1, string_460
	jal stringAdd
	sw $v0, 9412($sp)
	lw $a0, 9412($sp)
	jal print
	lw $a0, 812($sp)
	jal toString
	sw $v0, 9420($sp)
	lw $a0, 9420($sp)
	la $a1, string_461
	jal stringAdd
	sw $v0, 9428($sp)
	lw $a0, 9428($sp)
	jal print
	lw $a0, 816($sp)
	jal toString
	sw $v0, 9436($sp)
	lw $a0, 9436($sp)
	la $a1, string_462
	jal stringAdd
	sw $v0, 9444($sp)
	lw $a0, 9444($sp)
	jal print
	lw $a0, 820($sp)
	jal toString
	sw $v0, 9452($sp)
	lw $a0, 9452($sp)
	la $a1, string_463
	jal stringAdd
	sw $v0, 9460($sp)
	lw $a0, 9460($sp)
	jal print
	lw $a0, 824($sp)
	jal toString
	sw $v0, 9468($sp)
	lw $a0, 9468($sp)
	la $a1, string_464
	jal stringAdd
	sw $v0, 9476($sp)
	lw $a0, 9476($sp)
	jal print
	lw $a0, 828($sp)
	jal toString
	sw $v0, 9484($sp)
	lw $a0, 9484($sp)
	la $a1, string_465
	jal stringAdd
	sw $v0, 9492($sp)
	lw $a0, 9492($sp)
	jal print
	lw $a0, 832($sp)
	jal toString
	sw $v0, 9500($sp)
	lw $a0, 9500($sp)
	la $a1, string_466
	jal stringAdd
	sw $v0, 9508($sp)
	lw $a0, 9508($sp)
	jal print
	lw $a0, 836($sp)
	jal toString
	sw $v0, 9516($sp)
	lw $a0, 9516($sp)
	la $a1, string_467
	jal stringAdd
	sw $v0, 9524($sp)
	lw $a0, 9524($sp)
	jal print
	lw $a0, 840($sp)
	jal toString
	sw $v0, 9532($sp)
	lw $a0, 9532($sp)
	la $a1, string_468
	jal stringAdd
	sw $v0, 9540($sp)
	lw $a0, 9540($sp)
	jal print
	lw $a0, 844($sp)
	jal toString
	sw $v0, 9548($sp)
	lw $a0, 9548($sp)
	la $a1, string_469
	jal stringAdd
	sw $v0, 9556($sp)
	lw $a0, 9556($sp)
	jal print
	lw $a0, 848($sp)
	jal toString
	sw $v0, 9564($sp)
	lw $a0, 9564($sp)
	la $a1, string_470
	jal stringAdd
	sw $v0, 9572($sp)
	lw $a0, 9572($sp)
	jal print
	lw $a0, 852($sp)
	jal toString
	sw $v0, 9580($sp)
	lw $a0, 9580($sp)
	la $a1, string_471
	jal stringAdd
	sw $v0, 9588($sp)
	lw $a0, 9588($sp)
	jal print
	lw $a0, 856($sp)
	jal toString
	sw $v0, 9596($sp)
	lw $a0, 9596($sp)
	la $a1, string_472
	jal stringAdd
	sw $v0, 9604($sp)
	lw $a0, 9604($sp)
	jal print
	lw $a0, 860($sp)
	jal toString
	sw $v0, 9612($sp)
	lw $a0, 9612($sp)
	la $a1, string_473
	jal stringAdd
	sw $v0, 9620($sp)
	lw $a0, 9620($sp)
	jal print
	lw $a0, 864($sp)
	jal toString
	sw $v0, 9628($sp)
	lw $a0, 9628($sp)
	la $a1, string_474
	jal stringAdd
	sw $v0, 9636($sp)
	lw $a0, 9636($sp)
	jal print
	lw $a0, 868($sp)
	jal toString
	sw $v0, 9644($sp)
	lw $a0, 9644($sp)
	la $a1, string_475
	jal stringAdd
	sw $v0, 9652($sp)
	lw $a0, 9652($sp)
	jal print
	lw $a0, 872($sp)
	jal toString
	sw $v0, 9660($sp)
	lw $a0, 9660($sp)
	la $a1, string_476
	jal stringAdd
	sw $v0, 9668($sp)
	lw $a0, 9668($sp)
	jal print
	lw $a0, 876($sp)
	jal toString
	sw $v0, 9676($sp)
	lw $a0, 9676($sp)
	la $a1, string_477
	jal stringAdd
	sw $v0, 9684($sp)
	lw $a0, 9684($sp)
	jal print
	lw $a0, 880($sp)
	jal toString
	sw $v0, 9692($sp)
	lw $a0, 9692($sp)
	la $a1, string_478
	jal stringAdd
	sw $v0, 9700($sp)
	lw $a0, 9700($sp)
	jal print
	lw $a0, 884($sp)
	jal toString
	sw $v0, 9708($sp)
	lw $a0, 9708($sp)
	la $a1, string_479
	jal stringAdd
	sw $v0, 9716($sp)
	lw $a0, 9716($sp)
	jal print
	lw $a0, 888($sp)
	jal toString
	sw $v0, 9724($sp)
	lw $a0, 9724($sp)
	la $a1, string_480
	jal stringAdd
	sw $v0, 9732($sp)
	lw $a0, 9732($sp)
	jal print
	lw $a0, 892($sp)
	jal toString
	sw $v0, 9740($sp)
	lw $a0, 9740($sp)
	la $a1, string_481
	jal stringAdd
	sw $v0, 9748($sp)
	lw $a0, 9748($sp)
	jal print
	lw $a0, 896($sp)
	jal toString
	sw $v0, 9756($sp)
	lw $a0, 9756($sp)
	la $a1, string_482
	jal stringAdd
	sw $v0, 9764($sp)
	lw $a0, 9764($sp)
	jal print
	lw $a0, 900($sp)
	jal toString
	sw $v0, 9772($sp)
	lw $a0, 9772($sp)
	la $a1, string_483
	jal stringAdd
	sw $v0, 9780($sp)
	lw $a0, 9780($sp)
	jal print
	lw $a0, 904($sp)
	jal toString
	sw $v0, 9788($sp)
	lw $a0, 9788($sp)
	la $a1, string_484
	jal stringAdd
	sw $v0, 9796($sp)
	lw $a0, 9796($sp)
	jal print
	lw $a0, 908($sp)
	jal toString
	sw $v0, 9804($sp)
	lw $a0, 9804($sp)
	la $a1, string_485
	jal stringAdd
	sw $v0, 9812($sp)
	lw $a0, 9812($sp)
	jal print
	lw $a0, 912($sp)
	jal toString
	sw $v0, 9820($sp)
	lw $a0, 9820($sp)
	la $a1, string_486
	jal stringAdd
	sw $v0, 9828($sp)
	lw $a0, 9828($sp)
	jal print
	lw $a0, 916($sp)
	jal toString
	sw $v0, 9836($sp)
	lw $a0, 9836($sp)
	la $a1, string_487
	jal stringAdd
	sw $v0, 9844($sp)
	lw $a0, 9844($sp)
	jal print
	lw $a0, 920($sp)
	jal toString
	sw $v0, 9852($sp)
	lw $a0, 9852($sp)
	la $a1, string_488
	jal stringAdd
	sw $v0, 9860($sp)
	lw $a0, 9860($sp)
	jal print
	lw $a0, 924($sp)
	jal toString
	sw $v0, 9868($sp)
	lw $a0, 9868($sp)
	la $a1, string_489
	jal stringAdd
	sw $v0, 9876($sp)
	lw $a0, 9876($sp)
	jal print
	lw $a0, 928($sp)
	jal toString
	sw $v0, 9884($sp)
	lw $a0, 9884($sp)
	la $a1, string_490
	jal stringAdd
	sw $v0, 9892($sp)
	lw $a0, 9892($sp)
	jal print
	lw $a0, 932($sp)
	jal toString
	sw $v0, 9900($sp)
	lw $a0, 9900($sp)
	la $a1, string_491
	jal stringAdd
	sw $v0, 9908($sp)
	lw $a0, 9908($sp)
	jal print
	lw $a0, 936($sp)
	jal toString
	sw $v0, 9916($sp)
	lw $a0, 9916($sp)
	la $a1, string_492
	jal stringAdd
	sw $v0, 9924($sp)
	lw $a0, 9924($sp)
	jal print
	lw $a0, 940($sp)
	jal toString
	sw $v0, 9932($sp)
	lw $a0, 9932($sp)
	la $a1, string_493
	jal stringAdd
	sw $v0, 9940($sp)
	lw $a0, 9940($sp)
	jal print
	lw $a0, 944($sp)
	jal toString
	sw $v0, 9948($sp)
	lw $a0, 9948($sp)
	la $a1, string_494
	jal stringAdd
	sw $v0, 9956($sp)
	lw $a0, 9956($sp)
	jal print
	lw $a0, 948($sp)
	jal toString
	sw $v0, 9964($sp)
	lw $a0, 9964($sp)
	la $a1, string_495
	jal stringAdd
	sw $v0, 9972($sp)
	lw $a0, 9972($sp)
	jal print
	lw $a0, 952($sp)
	jal toString
	sw $v0, 9980($sp)
	lw $a0, 9980($sp)
	la $a1, string_496
	jal stringAdd
	sw $v0, 9988($sp)
	lw $a0, 9988($sp)
	jal print
	lw $a0, 956($sp)
	jal toString
	sw $v0, 9996($sp)
	lw $a0, 9996($sp)
	la $a1, string_497
	jal stringAdd
	sw $v0, 10004($sp)
	lw $a0, 10004($sp)
	jal print
	lw $a0, 960($sp)
	jal toString
	sw $v0, 10012($sp)
	lw $a0, 10012($sp)
	la $a1, string_498
	jal stringAdd
	sw $v0, 10020($sp)
	lw $a0, 10020($sp)
	jal print
	lw $a0, 964($sp)
	jal toString
	sw $v0, 10028($sp)
	lw $a0, 10028($sp)
	la $a1, string_499
	jal stringAdd
	sw $v0, 10036($sp)
	lw $a0, 10036($sp)
	jal print
	lw $a0, 968($sp)
	jal toString
	sw $v0, 10044($sp)
	lw $a0, 10044($sp)
	la $a1, string_500
	jal stringAdd
	sw $v0, 10052($sp)
	lw $a0, 10052($sp)
	jal print
	lw $a0, 972($sp)
	jal toString
	sw $v0, 10060($sp)
	lw $a0, 10060($sp)
	la $a1, string_501
	jal stringAdd
	sw $v0, 10068($sp)
	lw $a0, 10068($sp)
	jal print
	lw $a0, 976($sp)
	jal toString
	sw $v0, 10076($sp)
	lw $a0, 10076($sp)
	la $a1, string_502
	jal stringAdd
	sw $v0, 10084($sp)
	lw $a0, 10084($sp)
	jal print
	lw $a0, 980($sp)
	jal toString
	sw $v0, 10092($sp)
	lw $a0, 10092($sp)
	la $a1, string_503
	jal stringAdd
	sw $v0, 10100($sp)
	lw $a0, 10100($sp)
	jal print
	lw $a0, 984($sp)
	jal toString
	sw $v0, 10108($sp)
	lw $a0, 10108($sp)
	la $a1, string_504
	jal stringAdd
	sw $v0, 10116($sp)
	lw $a0, 10116($sp)
	jal print
	lw $a0, 988($sp)
	jal toString
	sw $v0, 10124($sp)
	lw $a0, 10124($sp)
	la $a1, string_505
	jal stringAdd
	sw $v0, 10132($sp)
	lw $a0, 10132($sp)
	jal print
	lw $a0, 992($sp)
	jal toString
	sw $v0, 10140($sp)
	lw $a0, 10140($sp)
	la $a1, string_506
	jal stringAdd
	sw $v0, 10148($sp)
	lw $a0, 10148($sp)
	jal print
	lw $a0, 996($sp)
	jal toString
	sw $v0, 10156($sp)
	lw $a0, 10156($sp)
	la $a1, string_507
	jal stringAdd
	sw $v0, 10164($sp)
	lw $a0, 10164($sp)
	jal print
	lw $a0, 1000($sp)
	jal toString
	sw $v0, 10172($sp)
	lw $a0, 10172($sp)
	la $a1, string_508
	jal stringAdd
	sw $v0, 10180($sp)
	lw $a0, 10180($sp)
	jal print
	lw $a0, 1004($sp)
	jal toString
	sw $v0, 10188($sp)
	lw $a0, 10188($sp)
	la $a1, string_509
	jal stringAdd
	sw $v0, 10196($sp)
	lw $a0, 10196($sp)
	jal print
	lw $a0, 1008($sp)
	jal toString
	sw $v0, 10204($sp)
	lw $a0, 10204($sp)
	la $a1, string_510
	jal stringAdd
	sw $v0, 10212($sp)
	lw $a0, 10212($sp)
	jal print
	lw $a0, 1012($sp)
	jal toString
	sw $v0, 10220($sp)
	lw $a0, 10220($sp)
	la $a1, string_511
	jal stringAdd
	sw $v0, 10228($sp)
	lw $a0, 10228($sp)
	jal print
	lw $a0, 1016($sp)
	jal toString
	sw $v0, 10236($sp)
	lw $a0, 10236($sp)
	la $a1, string_512
	jal stringAdd
	sw $v0, 10244($sp)
	lw $a0, 10244($sp)
	jal print
	lw $a0, 1020($sp)
	jal toString
	sw $v0, 10252($sp)
	lw $a0, 10252($sp)
	la $a1, string_513
	jal stringAdd
	sw $v0, 10260($sp)
	lw $a0, 10260($sp)
	jal print
	la $a0, string_514
	jal println
	li $v0, 0
	b label_913
label_913:
	lw $ra, 10388($sp)
	addu $sp, $sp, 10396
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 1
string_1:
.asciiz " "
.align 2
.word 1
string_2:
.asciiz " "
.align 2
.word 1
string_3:
.asciiz " "
.align 2
.word 1
string_4:
.asciiz " "
.align 2
.word 1
string_5:
.asciiz " "
.align 2
.word 1
string_6:
.asciiz " "
.align 2
.word 1
string_7:
.asciiz " "
.align 2
.word 1
string_8:
.asciiz " "
.align 2
.word 1
string_9:
.asciiz " "
.align 2
.word 1
string_10:
.asciiz " "
.align 2
.word 1
string_11:
.asciiz " "
.align 2
.word 1
string_12:
.asciiz " "
.align 2
.word 1
string_13:
.asciiz " "
.align 2
.word 1
string_14:
.asciiz " "
.align 2
.word 1
string_15:
.asciiz " "
.align 2
.word 1
string_16:
.asciiz " "
.align 2
.word 1
string_17:
.asciiz " "
.align 2
.word 1
string_18:
.asciiz " "
.align 2
.word 1
string_19:
.asciiz " "
.align 2
.word 1
string_20:
.asciiz " "
.align 2
.word 1
string_21:
.asciiz " "
.align 2
.word 1
string_22:
.asciiz " "
.align 2
.word 1
string_23:
.asciiz " "
.align 2
.word 1
string_24:
.asciiz " "
.align 2
.word 1
string_25:
.asciiz " "
.align 2
.word 1
string_26:
.asciiz " "
.align 2
.word 1
string_27:
.asciiz " "
.align 2
.word 1
string_28:
.asciiz " "
.align 2
.word 1
string_29:
.asciiz " "
.align 2
.word 1
string_30:
.asciiz " "
.align 2
.word 1
string_31:
.asciiz " "
.align 2
.word 1
string_32:
.asciiz " "
.align 2
.word 1
string_33:
.asciiz " "
.align 2
.word 1
string_34:
.asciiz " "
.align 2
.word 1
string_35:
.asciiz " "
.align 2
.word 1
string_36:
.asciiz " "
.align 2
.word 1
string_37:
.asciiz " "
.align 2
.word 1
string_38:
.asciiz " "
.align 2
.word 1
string_39:
.asciiz " "
.align 2
.word 1
string_40:
.asciiz " "
.align 2
.word 1
string_41:
.asciiz " "
.align 2
.word 1
string_42:
.asciiz " "
.align 2
.word 1
string_43:
.asciiz " "
.align 2
.word 1
string_44:
.asciiz " "
.align 2
.word 1
string_45:
.asciiz " "
.align 2
.word 1
string_46:
.asciiz " "
.align 2
.word 1
string_47:
.asciiz " "
.align 2
.word 1
string_48:
.asciiz " "
.align 2
.word 1
string_49:
.asciiz " "
.align 2
.word 1
string_50:
.asciiz " "
.align 2
.word 1
string_51:
.asciiz " "
.align 2
.word 1
string_52:
.asciiz " "
.align 2
.word 1
string_53:
.asciiz " "
.align 2
.word 1
string_54:
.asciiz " "
.align 2
.word 1
string_55:
.asciiz " "
.align 2
.word 1
string_56:
.asciiz " "
.align 2
.word 1
string_57:
.asciiz " "
.align 2
.word 1
string_58:
.asciiz " "
.align 2
.word 1
string_59:
.asciiz " "
.align 2
.word 1
string_60:
.asciiz " "
.align 2
.word 1
string_61:
.asciiz " "
.align 2
.word 1
string_62:
.asciiz " "
.align 2
.word 1
string_63:
.asciiz " "
.align 2
.word 1
string_64:
.asciiz " "
.align 2
.word 1
string_65:
.asciiz " "
.align 2
.word 1
string_66:
.asciiz " "
.align 2
.word 1
string_67:
.asciiz " "
.align 2
.word 1
string_68:
.asciiz " "
.align 2
.word 1
string_69:
.asciiz " "
.align 2
.word 1
string_70:
.asciiz " "
.align 2
.word 1
string_71:
.asciiz " "
.align 2
.word 1
string_72:
.asciiz " "
.align 2
.word 1
string_73:
.asciiz " "
.align 2
.word 1
string_74:
.asciiz " "
.align 2
.word 1
string_75:
.asciiz " "
.align 2
.word 1
string_76:
.asciiz " "
.align 2
.word 1
string_77:
.asciiz " "
.align 2
.word 1
string_78:
.asciiz " "
.align 2
.word 1
string_79:
.asciiz " "
.align 2
.word 1
string_80:
.asciiz " "
.align 2
.word 1
string_81:
.asciiz " "
.align 2
.word 1
string_82:
.asciiz " "
.align 2
.word 1
string_83:
.asciiz " "
.align 2
.word 1
string_84:
.asciiz " "
.align 2
.word 1
string_85:
.asciiz " "
.align 2
.word 1
string_86:
.asciiz " "
.align 2
.word 1
string_87:
.asciiz " "
.align 2
.word 1
string_88:
.asciiz " "
.align 2
.word 1
string_89:
.asciiz " "
.align 2
.word 1
string_90:
.asciiz " "
.align 2
.word 1
string_91:
.asciiz " "
.align 2
.word 1
string_92:
.asciiz " "
.align 2
.word 1
string_93:
.asciiz " "
.align 2
.word 1
string_94:
.asciiz " "
.align 2
.word 1
string_95:
.asciiz " "
.align 2
.word 1
string_96:
.asciiz " "
.align 2
.word 1
string_97:
.asciiz " "
.align 2
.word 1
string_98:
.asciiz " "
.align 2
.word 1
string_99:
.asciiz " "
.align 2
.word 1
string_100:
.asciiz " "
.align 2
.word 1
string_101:
.asciiz " "
.align 2
.word 1
string_102:
.asciiz " "
.align 2
.word 1
string_103:
.asciiz " "
.align 2
.word 1
string_104:
.asciiz " "
.align 2
.word 1
string_105:
.asciiz " "
.align 2
.word 1
string_106:
.asciiz " "
.align 2
.word 1
string_107:
.asciiz " "
.align 2
.word 1
string_108:
.asciiz " "
.align 2
.word 1
string_109:
.asciiz " "
.align 2
.word 1
string_110:
.asciiz " "
.align 2
.word 1
string_111:
.asciiz " "
.align 2
.word 1
string_112:
.asciiz " "
.align 2
.word 1
string_113:
.asciiz " "
.align 2
.word 1
string_114:
.asciiz " "
.align 2
.word 1
string_115:
.asciiz " "
.align 2
.word 1
string_116:
.asciiz " "
.align 2
.word 1
string_117:
.asciiz " "
.align 2
.word 1
string_118:
.asciiz " "
.align 2
.word 1
string_119:
.asciiz " "
.align 2
.word 1
string_120:
.asciiz " "
.align 2
.word 1
string_121:
.asciiz " "
.align 2
.word 1
string_122:
.asciiz " "
.align 2
.word 1
string_123:
.asciiz " "
.align 2
.word 1
string_124:
.asciiz " "
.align 2
.word 1
string_125:
.asciiz " "
.align 2
.word 1
string_126:
.asciiz " "
.align 2
.word 1
string_127:
.asciiz " "
.align 2
.word 1
string_128:
.asciiz " "
.align 2
.word 1
string_129:
.asciiz " "
.align 2
.word 1
string_130:
.asciiz " "
.align 2
.word 1
string_131:
.asciiz " "
.align 2
.word 1
string_132:
.asciiz " "
.align 2
.word 1
string_133:
.asciiz " "
.align 2
.word 1
string_134:
.asciiz " "
.align 2
.word 1
string_135:
.asciiz " "
.align 2
.word 1
string_136:
.asciiz " "
.align 2
.word 1
string_137:
.asciiz " "
.align 2
.word 1
string_138:
.asciiz " "
.align 2
.word 1
string_139:
.asciiz " "
.align 2
.word 1
string_140:
.asciiz " "
.align 2
.word 1
string_141:
.asciiz " "
.align 2
.word 1
string_142:
.asciiz " "
.align 2
.word 1
string_143:
.asciiz " "
.align 2
.word 1
string_144:
.asciiz " "
.align 2
.word 1
string_145:
.asciiz " "
.align 2
.word 1
string_146:
.asciiz " "
.align 2
.word 1
string_147:
.asciiz " "
.align 2
.word 1
string_148:
.asciiz " "
.align 2
.word 1
string_149:
.asciiz " "
.align 2
.word 1
string_150:
.asciiz " "
.align 2
.word 1
string_151:
.asciiz " "
.align 2
.word 1
string_152:
.asciiz " "
.align 2
.word 1
string_153:
.asciiz " "
.align 2
.word 1
string_154:
.asciiz " "
.align 2
.word 1
string_155:
.asciiz " "
.align 2
.word 1
string_156:
.asciiz " "
.align 2
.word 1
string_157:
.asciiz " "
.align 2
.word 1
string_158:
.asciiz " "
.align 2
.word 1
string_159:
.asciiz " "
.align 2
.word 1
string_160:
.asciiz " "
.align 2
.word 1
string_161:
.asciiz " "
.align 2
.word 1
string_162:
.asciiz " "
.align 2
.word 1
string_163:
.asciiz " "
.align 2
.word 1
string_164:
.asciiz " "
.align 2
.word 1
string_165:
.asciiz " "
.align 2
.word 1
string_166:
.asciiz " "
.align 2
.word 1
string_167:
.asciiz " "
.align 2
.word 1
string_168:
.asciiz " "
.align 2
.word 1
string_169:
.asciiz " "
.align 2
.word 1
string_170:
.asciiz " "
.align 2
.word 1
string_171:
.asciiz " "
.align 2
.word 1
string_172:
.asciiz " "
.align 2
.word 1
string_173:
.asciiz " "
.align 2
.word 1
string_174:
.asciiz " "
.align 2
.word 1
string_175:
.asciiz " "
.align 2
.word 1
string_176:
.asciiz " "
.align 2
.word 1
string_177:
.asciiz " "
.align 2
.word 1
string_178:
.asciiz " "
.align 2
.word 1
string_179:
.asciiz " "
.align 2
.word 1
string_180:
.asciiz " "
.align 2
.word 1
string_181:
.asciiz " "
.align 2
.word 1
string_182:
.asciiz " "
.align 2
.word 1
string_183:
.asciiz " "
.align 2
.word 1
string_184:
.asciiz " "
.align 2
.word 1
string_185:
.asciiz " "
.align 2
.word 1
string_186:
.asciiz " "
.align 2
.word 1
string_187:
.asciiz " "
.align 2
.word 1
string_188:
.asciiz " "
.align 2
.word 1
string_189:
.asciiz " "
.align 2
.word 1
string_190:
.asciiz " "
.align 2
.word 1
string_191:
.asciiz " "
.align 2
.word 1
string_192:
.asciiz " "
.align 2
.word 1
string_193:
.asciiz " "
.align 2
.word 1
string_194:
.asciiz " "
.align 2
.word 1
string_195:
.asciiz " "
.align 2
.word 1
string_196:
.asciiz " "
.align 2
.word 1
string_197:
.asciiz " "
.align 2
.word 1
string_198:
.asciiz " "
.align 2
.word 1
string_199:
.asciiz " "
.align 2
.word 1
string_200:
.asciiz " "
.align 2
.word 1
string_201:
.asciiz " "
.align 2
.word 1
string_202:
.asciiz " "
.align 2
.word 1
string_203:
.asciiz " "
.align 2
.word 1
string_204:
.asciiz " "
.align 2
.word 1
string_205:
.asciiz " "
.align 2
.word 1
string_206:
.asciiz " "
.align 2
.word 1
string_207:
.asciiz " "
.align 2
.word 1
string_208:
.asciiz " "
.align 2
.word 1
string_209:
.asciiz " "
.align 2
.word 1
string_210:
.asciiz " "
.align 2
.word 1
string_211:
.asciiz " "
.align 2
.word 1
string_212:
.asciiz " "
.align 2
.word 1
string_213:
.asciiz " "
.align 2
.word 1
string_214:
.asciiz " "
.align 2
.word 1
string_215:
.asciiz " "
.align 2
.word 1
string_216:
.asciiz " "
.align 2
.word 1
string_217:
.asciiz " "
.align 2
.word 1
string_218:
.asciiz " "
.align 2
.word 1
string_219:
.asciiz " "
.align 2
.word 1
string_220:
.asciiz " "
.align 2
.word 1
string_221:
.asciiz " "
.align 2
.word 1
string_222:
.asciiz " "
.align 2
.word 1
string_223:
.asciiz " "
.align 2
.word 1
string_224:
.asciiz " "
.align 2
.word 1
string_225:
.asciiz " "
.align 2
.word 1
string_226:
.asciiz " "
.align 2
.word 1
string_227:
.asciiz " "
.align 2
.word 1
string_228:
.asciiz " "
.align 2
.word 1
string_229:
.asciiz " "
.align 2
.word 1
string_230:
.asciiz " "
.align 2
.word 1
string_231:
.asciiz " "
.align 2
.word 1
string_232:
.asciiz " "
.align 2
.word 1
string_233:
.asciiz " "
.align 2
.word 1
string_234:
.asciiz " "
.align 2
.word 1
string_235:
.asciiz " "
.align 2
.word 1
string_236:
.asciiz " "
.align 2
.word 1
string_237:
.asciiz " "
.align 2
.word 1
string_238:
.asciiz " "
.align 2
.word 1
string_239:
.asciiz " "
.align 2
.word 1
string_240:
.asciiz " "
.align 2
.word 1
string_241:
.asciiz " "
.align 2
.word 1
string_242:
.asciiz " "
.align 2
.word 1
string_243:
.asciiz " "
.align 2
.word 1
string_244:
.asciiz " "
.align 2
.word 1
string_245:
.asciiz " "
.align 2
.word 1
string_246:
.asciiz " "
.align 2
.word 1
string_247:
.asciiz " "
.align 2
.word 1
string_248:
.asciiz " "
.align 2
.word 1
string_249:
.asciiz " "
.align 2
.word 1
string_250:
.asciiz " "
.align 2
.word 1
string_251:
.asciiz " "
.align 2
.word 1
string_252:
.asciiz " "
.align 2
.word 1
string_253:
.asciiz " "
.align 2
.word 1
string_254:
.asciiz " "
.align 2
.word 1
string_255:
.asciiz " "
.align 2
.word 1
string_256:
.asciiz " "
.align 2
.word 0
string_257:
.asciiz ""
.align 2
.word 1
string_258:
.asciiz " "
.align 2
.word 1
string_259:
.asciiz " "
.align 2
.word 1
string_260:
.asciiz " "
.align 2
.word 1
string_261:
.asciiz " "
.align 2
.word 1
string_262:
.asciiz " "
.align 2
.word 1
string_263:
.asciiz " "
.align 2
.word 1
string_264:
.asciiz " "
.align 2
.word 1
string_265:
.asciiz " "
.align 2
.word 1
string_266:
.asciiz " "
.align 2
.word 1
string_267:
.asciiz " "
.align 2
.word 1
string_268:
.asciiz " "
.align 2
.word 1
string_269:
.asciiz " "
.align 2
.word 1
string_270:
.asciiz " "
.align 2
.word 1
string_271:
.asciiz " "
.align 2
.word 1
string_272:
.asciiz " "
.align 2
.word 1
string_273:
.asciiz " "
.align 2
.word 1
string_274:
.asciiz " "
.align 2
.word 1
string_275:
.asciiz " "
.align 2
.word 1
string_276:
.asciiz " "
.align 2
.word 1
string_277:
.asciiz " "
.align 2
.word 1
string_278:
.asciiz " "
.align 2
.word 1
string_279:
.asciiz " "
.align 2
.word 1
string_280:
.asciiz " "
.align 2
.word 1
string_281:
.asciiz " "
.align 2
.word 1
string_282:
.asciiz " "
.align 2
.word 1
string_283:
.asciiz " "
.align 2
.word 1
string_284:
.asciiz " "
.align 2
.word 1
string_285:
.asciiz " "
.align 2
.word 1
string_286:
.asciiz " "
.align 2
.word 1
string_287:
.asciiz " "
.align 2
.word 1
string_288:
.asciiz " "
.align 2
.word 1
string_289:
.asciiz " "
.align 2
.word 1
string_290:
.asciiz " "
.align 2
.word 1
string_291:
.asciiz " "
.align 2
.word 1
string_292:
.asciiz " "
.align 2
.word 1
string_293:
.asciiz " "
.align 2
.word 1
string_294:
.asciiz " "
.align 2
.word 1
string_295:
.asciiz " "
.align 2
.word 1
string_296:
.asciiz " "
.align 2
.word 1
string_297:
.asciiz " "
.align 2
.word 1
string_298:
.asciiz " "
.align 2
.word 1
string_299:
.asciiz " "
.align 2
.word 1
string_300:
.asciiz " "
.align 2
.word 1
string_301:
.asciiz " "
.align 2
.word 1
string_302:
.asciiz " "
.align 2
.word 1
string_303:
.asciiz " "
.align 2
.word 1
string_304:
.asciiz " "
.align 2
.word 1
string_305:
.asciiz " "
.align 2
.word 1
string_306:
.asciiz " "
.align 2
.word 1
string_307:
.asciiz " "
.align 2
.word 1
string_308:
.asciiz " "
.align 2
.word 1
string_309:
.asciiz " "
.align 2
.word 1
string_310:
.asciiz " "
.align 2
.word 1
string_311:
.asciiz " "
.align 2
.word 1
string_312:
.asciiz " "
.align 2
.word 1
string_313:
.asciiz " "
.align 2
.word 1
string_314:
.asciiz " "
.align 2
.word 1
string_315:
.asciiz " "
.align 2
.word 1
string_316:
.asciiz " "
.align 2
.word 1
string_317:
.asciiz " "
.align 2
.word 1
string_318:
.asciiz " "
.align 2
.word 1
string_319:
.asciiz " "
.align 2
.word 1
string_320:
.asciiz " "
.align 2
.word 1
string_321:
.asciiz " "
.align 2
.word 1
string_322:
.asciiz " "
.align 2
.word 1
string_323:
.asciiz " "
.align 2
.word 1
string_324:
.asciiz " "
.align 2
.word 1
string_325:
.asciiz " "
.align 2
.word 1
string_326:
.asciiz " "
.align 2
.word 1
string_327:
.asciiz " "
.align 2
.word 1
string_328:
.asciiz " "
.align 2
.word 1
string_329:
.asciiz " "
.align 2
.word 1
string_330:
.asciiz " "
.align 2
.word 1
string_331:
.asciiz " "
.align 2
.word 1
string_332:
.asciiz " "
.align 2
.word 1
string_333:
.asciiz " "
.align 2
.word 1
string_334:
.asciiz " "
.align 2
.word 1
string_335:
.asciiz " "
.align 2
.word 1
string_336:
.asciiz " "
.align 2
.word 1
string_337:
.asciiz " "
.align 2
.word 1
string_338:
.asciiz " "
.align 2
.word 1
string_339:
.asciiz " "
.align 2
.word 1
string_340:
.asciiz " "
.align 2
.word 1
string_341:
.asciiz " "
.align 2
.word 1
string_342:
.asciiz " "
.align 2
.word 1
string_343:
.asciiz " "
.align 2
.word 1
string_344:
.asciiz " "
.align 2
.word 1
string_345:
.asciiz " "
.align 2
.word 1
string_346:
.asciiz " "
.align 2
.word 1
string_347:
.asciiz " "
.align 2
.word 1
string_348:
.asciiz " "
.align 2
.word 1
string_349:
.asciiz " "
.align 2
.word 1
string_350:
.asciiz " "
.align 2
.word 1
string_351:
.asciiz " "
.align 2
.word 1
string_352:
.asciiz " "
.align 2
.word 1
string_353:
.asciiz " "
.align 2
.word 1
string_354:
.asciiz " "
.align 2
.word 1
string_355:
.asciiz " "
.align 2
.word 1
string_356:
.asciiz " "
.align 2
.word 1
string_357:
.asciiz " "
.align 2
.word 1
string_358:
.asciiz " "
.align 2
.word 1
string_359:
.asciiz " "
.align 2
.word 1
string_360:
.asciiz " "
.align 2
.word 1
string_361:
.asciiz " "
.align 2
.word 1
string_362:
.asciiz " "
.align 2
.word 1
string_363:
.asciiz " "
.align 2
.word 1
string_364:
.asciiz " "
.align 2
.word 1
string_365:
.asciiz " "
.align 2
.word 1
string_366:
.asciiz " "
.align 2
.word 1
string_367:
.asciiz " "
.align 2
.word 1
string_368:
.asciiz " "
.align 2
.word 1
string_369:
.asciiz " "
.align 2
.word 1
string_370:
.asciiz " "
.align 2
.word 1
string_371:
.asciiz " "
.align 2
.word 1
string_372:
.asciiz " "
.align 2
.word 1
string_373:
.asciiz " "
.align 2
.word 1
string_374:
.asciiz " "
.align 2
.word 1
string_375:
.asciiz " "
.align 2
.word 1
string_376:
.asciiz " "
.align 2
.word 1
string_377:
.asciiz " "
.align 2
.word 1
string_378:
.asciiz " "
.align 2
.word 1
string_379:
.asciiz " "
.align 2
.word 1
string_380:
.asciiz " "
.align 2
.word 1
string_381:
.asciiz " "
.align 2
.word 1
string_382:
.asciiz " "
.align 2
.word 1
string_383:
.asciiz " "
.align 2
.word 1
string_384:
.asciiz " "
.align 2
.word 1
string_385:
.asciiz " "
.align 2
.word 1
string_386:
.asciiz " "
.align 2
.word 1
string_387:
.asciiz " "
.align 2
.word 1
string_388:
.asciiz " "
.align 2
.word 1
string_389:
.asciiz " "
.align 2
.word 1
string_390:
.asciiz " "
.align 2
.word 1
string_391:
.asciiz " "
.align 2
.word 1
string_392:
.asciiz " "
.align 2
.word 1
string_393:
.asciiz " "
.align 2
.word 1
string_394:
.asciiz " "
.align 2
.word 1
string_395:
.asciiz " "
.align 2
.word 1
string_396:
.asciiz " "
.align 2
.word 1
string_397:
.asciiz " "
.align 2
.word 1
string_398:
.asciiz " "
.align 2
.word 1
string_399:
.asciiz " "
.align 2
.word 1
string_400:
.asciiz " "
.align 2
.word 1
string_401:
.asciiz " "
.align 2
.word 1
string_402:
.asciiz " "
.align 2
.word 1
string_403:
.asciiz " "
.align 2
.word 1
string_404:
.asciiz " "
.align 2
.word 1
string_405:
.asciiz " "
.align 2
.word 1
string_406:
.asciiz " "
.align 2
.word 1
string_407:
.asciiz " "
.align 2
.word 1
string_408:
.asciiz " "
.align 2
.word 1
string_409:
.asciiz " "
.align 2
.word 1
string_410:
.asciiz " "
.align 2
.word 1
string_411:
.asciiz " "
.align 2
.word 1
string_412:
.asciiz " "
.align 2
.word 1
string_413:
.asciiz " "
.align 2
.word 1
string_414:
.asciiz " "
.align 2
.word 1
string_415:
.asciiz " "
.align 2
.word 1
string_416:
.asciiz " "
.align 2
.word 1
string_417:
.asciiz " "
.align 2
.word 1
string_418:
.asciiz " "
.align 2
.word 1
string_419:
.asciiz " "
.align 2
.word 1
string_420:
.asciiz " "
.align 2
.word 1
string_421:
.asciiz " "
.align 2
.word 1
string_422:
.asciiz " "
.align 2
.word 1
string_423:
.asciiz " "
.align 2
.word 1
string_424:
.asciiz " "
.align 2
.word 1
string_425:
.asciiz " "
.align 2
.word 1
string_426:
.asciiz " "
.align 2
.word 1
string_427:
.asciiz " "
.align 2
.word 1
string_428:
.asciiz " "
.align 2
.word 1
string_429:
.asciiz " "
.align 2
.word 1
string_430:
.asciiz " "
.align 2
.word 1
string_431:
.asciiz " "
.align 2
.word 1
string_432:
.asciiz " "
.align 2
.word 1
string_433:
.asciiz " "
.align 2
.word 1
string_434:
.asciiz " "
.align 2
.word 1
string_435:
.asciiz " "
.align 2
.word 1
string_436:
.asciiz " "
.align 2
.word 1
string_437:
.asciiz " "
.align 2
.word 1
string_438:
.asciiz " "
.align 2
.word 1
string_439:
.asciiz " "
.align 2
.word 1
string_440:
.asciiz " "
.align 2
.word 1
string_441:
.asciiz " "
.align 2
.word 1
string_442:
.asciiz " "
.align 2
.word 1
string_443:
.asciiz " "
.align 2
.word 1
string_444:
.asciiz " "
.align 2
.word 1
string_445:
.asciiz " "
.align 2
.word 1
string_446:
.asciiz " "
.align 2
.word 1
string_447:
.asciiz " "
.align 2
.word 1
string_448:
.asciiz " "
.align 2
.word 1
string_449:
.asciiz " "
.align 2
.word 1
string_450:
.asciiz " "
.align 2
.word 1
string_451:
.asciiz " "
.align 2
.word 1
string_452:
.asciiz " "
.align 2
.word 1
string_453:
.asciiz " "
.align 2
.word 1
string_454:
.asciiz " "
.align 2
.word 1
string_455:
.asciiz " "
.align 2
.word 1
string_456:
.asciiz " "
.align 2
.word 1
string_457:
.asciiz " "
.align 2
.word 1
string_458:
.asciiz " "
.align 2
.word 1
string_459:
.asciiz " "
.align 2
.word 1
string_460:
.asciiz " "
.align 2
.word 1
string_461:
.asciiz " "
.align 2
.word 1
string_462:
.asciiz " "
.align 2
.word 1
string_463:
.asciiz " "
.align 2
.word 1
string_464:
.asciiz " "
.align 2
.word 1
string_465:
.asciiz " "
.align 2
.word 1
string_466:
.asciiz " "
.align 2
.word 1
string_467:
.asciiz " "
.align 2
.word 1
string_468:
.asciiz " "
.align 2
.word 1
string_469:
.asciiz " "
.align 2
.word 1
string_470:
.asciiz " "
.align 2
.word 1
string_471:
.asciiz " "
.align 2
.word 1
string_472:
.asciiz " "
.align 2
.word 1
string_473:
.asciiz " "
.align 2
.word 1
string_474:
.asciiz " "
.align 2
.word 1
string_475:
.asciiz " "
.align 2
.word 1
string_476:
.asciiz " "
.align 2
.word 1
string_477:
.asciiz " "
.align 2
.word 1
string_478:
.asciiz " "
.align 2
.word 1
string_479:
.asciiz " "
.align 2
.word 1
string_480:
.asciiz " "
.align 2
.word 1
string_481:
.asciiz " "
.align 2
.word 1
string_482:
.asciiz " "
.align 2
.word 1
string_483:
.asciiz " "
.align 2
.word 1
string_484:
.asciiz " "
.align 2
.word 1
string_485:
.asciiz " "
.align 2
.word 1
string_486:
.asciiz " "
.align 2
.word 1
string_487:
.asciiz " "
.align 2
.word 1
string_488:
.asciiz " "
.align 2
.word 1
string_489:
.asciiz " "
.align 2
.word 1
string_490:
.asciiz " "
.align 2
.word 1
string_491:
.asciiz " "
.align 2
.word 1
string_492:
.asciiz " "
.align 2
.word 1
string_493:
.asciiz " "
.align 2
.word 1
string_494:
.asciiz " "
.align 2
.word 1
string_495:
.asciiz " "
.align 2
.word 1
string_496:
.asciiz " "
.align 2
.word 1
string_497:
.asciiz " "
.align 2
.word 1
string_498:
.asciiz " "
.align 2
.word 1
string_499:
.asciiz " "
.align 2
.word 1
string_500:
.asciiz " "
.align 2
.word 1
string_501:
.asciiz " "
.align 2
.word 1
string_502:
.asciiz " "
.align 2
.word 1
string_503:
.asciiz " "
.align 2
.word 1
string_504:
.asciiz " "
.align 2
.word 1
string_505:
.asciiz " "
.align 2
.word 1
string_506:
.asciiz " "
.align 2
.word 1
string_507:
.asciiz " "
.align 2
.word 1
string_508:
.asciiz " "
.align 2
.word 1
string_509:
.asciiz " "
.align 2
.word 1
string_510:
.asciiz " "
.align 2
.word 1
string_511:
.asciiz " "
.align 2
.word 1
string_512:
.asciiz " "
.align 2
.word 1
string_513:
.asciiz " "
.align 2
.word 0
string_514:
.asciiz ""
.align 2
global_0:
.space 4
.align 2
