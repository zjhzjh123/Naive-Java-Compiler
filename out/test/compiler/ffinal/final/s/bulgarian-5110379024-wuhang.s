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
_random:
	sub $sp, $sp, 160
	sw $s3, 108($sp)
	sw $s4, 112($sp)
	sw $ra, 152($sp)
label_76:
	lw $t0, global_8
	lw $t1, global_6
	div $s4, $t0, $t1
	lw $t0, global_7
	mul $s4, $t0, $s4
	lw $t0, global_8
	lw $t1, global_6
	rem $s3, $t0, $t1
	lw $t0, global_4
	mul $s3, $t0, $s3
	sub $s4, $s3, $s4
	move $s4, $s4
	li $t1, 0
	sge $s3, $s4, $t1
	beqz $s3, label_79
	b label_78
label_78:
	sw $s4, global_8
	b label_80
label_79:
	lw $t1, global_5
	addu $s4, $s4, $t1
	sw $s4, global_8
	b label_80
label_80:
	lw $v0, global_8
	b label_77
label_77:
	lw $ra, 152($sp)
	lw $s3, 108($sp)
	lw $s4, 112($sp)
	addu $sp, $sp, 160
	jr $ra
_initialize:
	sub $sp, $sp, 132
	sw $ra, 124($sp)
label_81:
	lw $t1, 0($sp)
	sw $t1, global_8
label_82:
label_82:
	lw $ra, 124($sp)
	addu $sp, $sp, 132
	jr $ra
_swap:
	sub $sp, $sp, 180
	sw $s2, 124($sp)
	sw $s3, 128($sp)
	sw $s4, 132($sp)
	sw $ra, 172($sp)
label_83:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $s3, $s4
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	sw $s2, 4($s4)
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
label_84:
label_84:
	lw $ra, 172($sp)
	lw $s2, 124($sp)
	lw $s3, 128($sp)
	lw $s4, 132($sp)
	addu $sp, $sp, 180
	jr $ra
_pd:
	sub $sp, $sp, 152
	sw $s4, 104($sp)
	sw $ra, 144($sp)
label_85:
	b label_87
label_87:
	lw $t0, global_1
	lw $t1, 0($sp)
	sle $s4, $t0, $t1
	beqz $s4, label_90
	b label_88
label_88:
	lw $t0, global_1
	addi $s4, $t0, 1
	lw $t0, global_1
	mul $s4, $t0, $s4
	li $t1, 2
	div $s4, $s4, $t1
	lw $t0, 0($sp)
	seq $s4, $t0, $s4
	beqz $s4, label_92
	b label_91
label_91:
	li $v0, 1
	b label_86
label_92:
label_89:
	lw $t0, global_1
	addi $t1, $t0, 1
	sw $t1, global_1
	b label_87
label_90:
	li $v0, 0
	b label_86
label_86:
	lw $ra, 144($sp)
	lw $s4, 104($sp)
	addu $sp, $sp, 152
	jr $ra
_show:
	sub $sp, $sp, 168
	sw $s3, 116($sp)
	sw $s4, 120($sp)
	sw $ra, 160($sp)
label_93:
	li $t1, 0
	move $s3, $t1
	b label_95
label_95:
	lw $t1, global_2
	slt $s4, $s3, $t1
	beqz $s4, label_98
	b label_96
label_96:
	mul $s4, $s3, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	la $a1, string_9
	jal stringAdd
	move $s4, $v0
	move $a0, $s4
	jal print
label_97:
	addi $s3, $s3, 1
	b label_95
label_98:
	la $a0, string_10
	jal println
label_94:
label_94:
	lw $ra, 160($sp)
	lw $s3, 116($sp)
	lw $s4, 120($sp)
	addu $sp, $sp, 168
	jr $ra
_win:
	sub $sp, $sp, 292
	sw $s0, 228($sp)
	sw $s1, 232($sp)
	sw $s2, 236($sp)
	sw $s3, 240($sp)
	sw $s4, 244($sp)
	sw $t9, 224($sp)
	sw $ra, 284($sp)
label_99:
	li $t0, 100
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 100
	sw $t0, 0($s4)
	move $s3, $s4
	lw $t0, global_2
	lw $t1, global_1
	sne $s4, $t0, $t1
	beqz $s4, label_102
	b label_101
label_101:
	li $v0, 0
	b label_100
label_102:
	li $t1, 0
	move $s4, $t1
	b label_103
label_103:
	lw $t1, global_2
	slt $s2, $s4, $t1
	beqz $s2, label_106
	b label_104
label_104:
	mul $s2, $s4, $k0
	lw $t0, global_3
	addu $s2, $t0, $s2
	lw $s2, 4($s2)
	mul $s1, $s4, $k0
	addu $s1, $s3, $s1
	sw $s2, 4($s1)
label_105:
	addi $s4, $s4, 1
	b label_103
label_106:
	li $t1, 0
	move $s2, $t1
	b label_107
label_107:
	lw $t0, global_2
	li $t1, 1
	sub $s4, $t0, $t1
	slt $s4, $s2, $s4
	beqz $s4, label_110
	b label_108
label_108:
	addi $s4, $s2, 1
	move $s4, $s4
	b label_111
label_111:
	lw $t1, global_2
	slt $s1, $s4, $t1
	beqz $s1, label_114
	b label_112
label_112:
	mul $s1, $s4, $k0
	addu $s1, $s3, $s1
	lw $s0, 4($s1)
	mul $s1, $s2, $k0
	addu $s1, $s3, $s1
	lw $s1, 4($s1)
	sgt $s1, $s1, $s0
	beqz $s1, label_116
	b label_115
label_115:
	mul $s1, $s2, $k0
	addu $s1, $s3, $s1
	lw $s1, 4($s1)
	move $t9, $s1
	mul $s1, $s4, $k0
	addu $s1, $s3, $s1
	lw $s1, 4($s1)
	mul $s0, $s2, $k0
	addu $s0, $s3, $s0
	sw $s1, 4($s0)
	mul $s1, $s4, $k0
	addu $s1, $s3, $s1
	sw $t9, 4($s1)
	b label_116
label_116:
label_113:
	addi $s4, $s4, 1
	b label_111
label_114:
label_109:
	addi $s2, $s2, 1
	b label_107
label_110:
	li $t1, 0
	move $s2, $t1
	b label_117
label_117:
	lw $t1, global_2
	slt $s4, $s2, $t1
	beqz $s4, label_120
	b label_118
label_118:
	addi $s4, $s2, 1
	mul $s1, $s2, $k0
	addu $s1, $s3, $s1
	lw $s1, 4($s1)
	sne $s4, $s1, $s4
	beqz $s4, label_122
	b label_121
label_121:
	li $v0, 0
	b label_100
label_122:
label_119:
	addi $s2, $s2, 1
	b label_117
label_120:
	li $v0, 1
	b label_100
label_100:
	lw $ra, 284($sp)
	lw $s0, 228($sp)
	lw $s1, 232($sp)
	lw $s2, 236($sp)
	lw $s3, 240($sp)
	lw $s4, 244($sp)
	lw $t9, 224($sp)
	addu $sp, $sp, 292
	jr $ra
_merge:
	sub $sp, $sp, 204
	sw $s2, 148($sp)
	sw $s3, 152($sp)
	sw $s4, 156($sp)
	sw $ra, 196($sp)
label_123:
	li $t1, 0
	move $s3, $t1
	b label_125
label_125:
	lw $t1, global_2
	slt $s4, $s3, $t1
	beqz $s4, label_128
	b label_126
label_126:
	mul $s4, $s3, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	seq $s4, $s4, $t1
	beqz $s4, label_130
	b label_129
label_129:
	addi $s4, $s3, 1
	move $s2, $s4
	b label_131
label_131:
	lw $t1, global_2
	slt $s4, $s2, $t1
	beqz $s4, label_134
	b label_132
label_132:
	mul $s4, $s2, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	sne $s4, $s4, $t1
	beqz $s4, label_136
	b label_135
label_135:
	sw $s3, -180($sp)
	sw $s2, -176($sp)
	jal _swap
	b label_134
label_136:
label_133:
	addi $s2, $s2, 1
	b label_131
label_134:
	b label_130
label_130:
label_127:
	addi $s3, $s3, 1
	b label_125
label_128:
	li $t1, 0
	move $s3, $t1
	b label_137
label_137:
	lw $t1, global_2
	slt $s4, $s3, $t1
	beqz $s4, label_140
	b label_138
label_138:
	mul $s4, $s3, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	li $t1, 0
	seq $s4, $s4, $t1
	beqz $s4, label_142
	b label_141
label_141:
	sw $s3, global_2
	b label_140
label_142:
label_139:
	addi $s3, $s3, 1
	b label_137
label_140:
label_124:
label_124:
	lw $ra, 196($sp)
	lw $s2, 148($sp)
	lw $s3, 152($sp)
	lw $s4, 156($sp)
	addu $sp, $sp, 204
	jr $ra
_move:
	sub $sp, $sp, 164
	sw $s2, 108($sp)
	sw $s3, 112($sp)
	sw $s4, 116($sp)
	sw $ra, 156($sp)
label_143:
	li $t1, 0
	move $s3, $t1
	b label_145
label_145:
	lw $t1, global_2
	slt $s4, $s3, $t1
	beqz $s4, label_148
	b label_146
label_146:
	mul $s4, $s3, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s2, 4($s4)
	li $t1, 1
	sub $s2, $s2, $t1
	sw $s2, 4($s4)
	addi $s4, $s3, 1
	move $s3, $s4
label_147:
	b label_145
label_148:
	lw $t0, global_2
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $t0, global_2
	sw $t0, 4($s4)
	lw $t1, global_2
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_2
label_144:
label_144:
	lw $ra, 156($sp)
	lw $s2, 108($sp)
	lw $s3, 112($sp)
	lw $s4, 116($sp)
	addu $sp, $sp, 164
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 384
	sw $s0, 320($sp)
	sw $s1, 324($sp)
	sw $s2, 328($sp)
	sw $s3, 332($sp)
	sw $s4, 336($sp)
	sw $ra, 376($sp)
label_149:
	li $t1, 48271
	sw $t1, global_4
	li $t1, 2147483647
	sw $t1, global_5
	li $t1, 1
	sw $t1, global_8
	li $t1, 0
	move $s0, $t1
	li $t1, 0
	move $s3, $t1
	li $t1, 0
	move $s2, $t1
	li $t1, 210
	sw $t1, global_0
	li $t1, 0
	sw $t1, global_1
	li $t0, 100
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	li $t0, 100
	sw $t0, 0($s4)
	sw $s4, global_3
	lw $t0, global_5
	lw $t1, global_4
	div $s4, $t0, $t1
	sw $s4, global_6
	lw $t0, global_5
	lw $t1, global_4
	rem $s4, $t0, $t1
	sw $s4, global_7
	lw $t1, global_0
	sw $t1, -152($sp)
	jal _pd
	move $s4, $v0
	li $t1, 1
	xor $s4, $s4, $t1
	beqz $s4, label_152
	b label_151
label_151:
	la $a0, string_11
	jal println
	li $v0, 1
	b label_150
label_152:
	la $a0, string_12
	jal println
	li $t1, 3654898
	sw $t1, -132($sp)
	jal _initialize
	jal _random
	move $s4, $v0
	li $t1, 10
	rem $s4, $s4, $t1
	addi $s4, $s4, 1
	sw $s4, global_2
	lw $a0, global_2
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	b label_153
label_153:
	lw $t0, global_2
	li $t1, 1
	sub $s4, $t0, $t1
	slt $s4, $s0, $s4
	beqz $s4, label_156
	b label_154
label_154:
	jal _random
	move $s4, $v0
	li $t1, 10
	rem $s4, $s4, $t1
	addi $s1, $s4, 1
	mul $s4, $s0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	sw $s1, 4($s4)
	b label_157
label_157:
	mul $s4, $s0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	addu $s4, $s4, $s3
	lw $t1, global_0
	sgt $s4, $s4, $t1
	beqz $s4, label_159
	b label_158
label_158:
	jal _random
	move $s4, $v0
	li $t1, 10
	rem $s4, $s4, $t1
	addi $s4, $s4, 1
	mul $s1, $s0, $k0
	lw $t0, global_3
	addu $s1, $t0, $s1
	sw $s4, 4($s1)
	b label_157
label_159:
	mul $s4, $s0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	addu $s4, $s3, $s4
	move $s3, $s4
label_155:
	addi $s0, $s0, 1
	b label_153
label_156:
	lw $t0, global_0
	sub $s3, $t0, $s3
	lw $t0, global_2
	li $t1, 1
	sub $s4, $t0, $t1
	mul $s4, $s4, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	jal _show
	jal _merge
	b label_160
label_160:
	jal _win
	move $s4, $v0
	li $t1, 1
	xor $s4, $s4, $t1
	beqz $s4, label_162
	b label_161
label_161:
	addi $s2, $s2, 1
	move $a0, $s2
	jal toString
	move $s4, $v0
	la $a0, string_14
	move $a1, $s4
	jal stringAdd
	move $s4, $v0
	move $a0, $s4
	la $a1, string_13
	jal stringAdd
	move $s4, $v0
	move $a0, $s4
	jal println
	jal _move
	jal _merge
	jal _show
	b label_160
label_162:
	move $a0, $s2
	jal toString
	move $s4, $v0
	la $a0, string_16
	move $a1, $s4
	jal stringAdd
	move $s4, $v0
	move $a0, $s4
	la $a1, string_15
	jal stringAdd
	move $s4, $v0
	move $a0, $s4
	jal println
	li $v0, 0
	b label_150
label_150:
	lw $ra, 376($sp)
	lw $s0, 320($sp)
	lw $s1, 324($sp)
	lw $s2, 328($sp)
	lw $s3, 332($sp)
	lw $s4, 336($sp)
	addu $sp, $sp, 384
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 1
string_9:
.asciiz " "
.align 2
.word 0
string_10:
.asciiz ""
.align 2
.word 79
string_11:
.asciiz "Sorry, the number n must be a number s.t. there exists i satisfying n=1+2+...+i"
.align 2
.word 12
string_12:
.asciiz "Let's start!"
.align 2
.word 1
string_13:
.asciiz ":"
.align 2
.word 5
string_14:
.asciiz "step "
.align 2
.word 8
string_15:
.asciiz " step(s)"
.align 2
.word 7
string_16:
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
