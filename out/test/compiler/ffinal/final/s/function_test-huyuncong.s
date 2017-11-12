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
_merge:
	sub $sp, $sp, 244
	sw $s2, 188($sp)
	sw $s3, 192($sp)
	sw $s4, 196($sp)
	sw $ra, 236($sp)
label_179:
	lw $t0, 0($sp)
	li $t1, 0
	seq $s4, $t0, $t1
	beqz $s4, label_182
	b label_181
label_181:
	lw $v0, 4($sp)
	b label_180
label_182:
	lw $t0, 4($sp)
	li $t1, 0
	seq $s4, $t0, $t1
	beqz $s4, label_184
	b label_183
label_183:
	lw $v0, 0($sp)
	b label_180
label_184:
	lw $t0, 4($sp)
	mul $s4, $t0, $k0
	lw $t0, global_5
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_5
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	slt $s4, $s4, $s3
	beqz $s4, label_186
	b label_185
label_185:
	lw $t1, 0($sp)
	move $s4, $t1
	lw $t1, 4($sp)
	sw $t1, 0($sp)
	sw $s4, 4($sp)
	b label_186
label_186:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	sw $s4, -244($sp)
	lw $t1, 4($sp)
	sw $t1, -240($sp)
	jal _merge
	move $s3, $v0
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $s2, $s4
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	sw $s2, 4($s4)
	lw $v0, 0($sp)
	b label_180
label_180:
	lw $ra, 236($sp)
	lw $s2, 188($sp)
	lw $s3, 192($sp)
	lw $s4, 196($sp)
	addu $sp, $sp, 244
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 400
	sw $s1, 340($sp)
	sw $s2, 344($sp)
	sw $s3, 348($sp)
	sw $s4, 352($sp)
	sw $ra, 392($sp)
label_187:
	jal getInt
	move $s4, $v0
	sw $s4, global_0
	jal getInt
	move $s4, $v0
	sw $s4, global_1
	jal getString
	move $s4, $v0
	sw $s4, global_2
	lw $t0, global_0
	lw $t1, global_1
	addu $s4, $t0, $t1
	addi $s3, $s4, 5
	addi $s4, $s3, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	sw $s3, 0($s4)
	sw $s4, global_3
	lw $t0, global_0
	lw $t1, global_1
	addu $s4, $t0, $t1
	addi $s4, $s4, 5
	addi $s3, $s4, 1
	mul $s3, $s3, $k0
	move $a0, $s3
	li $v0, 9
	syscall
	move $s3, $v0
	sw $s4, 0($s3)
	sw $s3, global_4
	lw $t0, global_0
	lw $t1, global_1
	addu $s4, $t0, $t1
	addi $s3, $s4, 5
	addi $s4, $s3, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	sw $s3, 0($s4)
	sw $s4, global_5
	li $t1, 1
	move $s3, $t1
	b label_189
label_189:
	lw $t1, global_0
	sle $s4, $s3, $t1
	beqz $s4, label_192
	b label_190
label_190:
	jal getInt
	move $s2, $v0
	mul $s4, $s3, $k0
	lw $t0, global_5
	addu $s4, $t0, $s4
	sw $s2, 4($s4)
	mul $s4, $s3, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
	mul $s4, $s3, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
label_191:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_189
label_192:
	li $t1, 1
	move $s3, $t1
	b label_193
label_193:
	lw $t1, global_1
	sle $s4, $s3, $t1
	beqz $s4, label_196
	b label_194
label_194:
	li $t1, 1
	sub $s4, $s3, $t1
	lw $a0, global_2
	move $a1, $s4
	jal ord
	move $s4, $v0
	lw $t1, global_0
	addu $s2, $s3, $t1
	mul $s2, $s2, $k0
	lw $t0, global_5
	addu $s2, $t0, $s2
	sw $s4, 4($s2)
	lw $t1, global_0
	addu $s4, $s3, $t1
	mul $s4, $s4, $k0
	lw $t0, global_3
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
	lw $t1, global_0
	addu $s4, $s3, $t1
	mul $s4, $s4, $k0
	lw $t0, global_4
	addu $s4, $t0, $s4
	li $t0, 0
	sw $t0, 4($s4)
label_195:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_193
label_196:
	li $t1, 1
	move $s1, $t1
	lw $t0, global_0
	addi $s4, $t0, 1
	move $s2, $s4
	li $t1, 2
	move $s3, $t1
	b label_197
label_197:
	lw $t1, global_0
	sle $s4, $s3, $t1
	beqz $s4, label_200
	b label_198
label_198:
	sw $s1, -244($sp)
	sw $s3, -240($sp)
	jal _merge
	move $s4, $v0
	move $s1, $s4
label_199:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_197
label_200:
	lw $t0, global_0
	addi $s4, $t0, 2
	move $s3, $s4
	b label_201
label_201:
	lw $t0, global_0
	lw $t1, global_1
	addu $s4, $t0, $t1
	sle $s4, $s3, $s4
	beqz $s4, label_204
	b label_202
label_202:
	sw $s2, -244($sp)
	sw $s3, -240($sp)
	jal _merge
	move $s4, $v0
	move $s2, $s4
label_203:
	move $s4, $s3
	addi $s3, $s4, 1
	b label_201
label_204:
	mul $s4, $s1, $k0
	lw $t0, global_5
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal print
	la $a0, string_6
	jal print
	lw $t1, global_0
	sub $s4, $s2, $t1
	li $t1, 1
	sub $s3, $s4, $t1
	lw $t1, global_0
	sub $s4, $s2, $t1
	li $t1, 1
	sub $s4, $s4, $t1
	lw $a0, global_2
	move $a1, $s3
	move $a2, $s4
	jal substring
	move $s4, $v0
	move $a0, $s4
	jal print
	la $a0, string_7
	jal print
	sw $s1, -244($sp)
	sw $s2, -240($sp)
	jal _merge
	move $s4, $v0
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	li $v0, 0
	b label_188
label_188:
	lw $ra, 392($sp)
	lw $s1, 340($sp)
	lw $s2, 344($sp)
	lw $s3, 348($sp)
	lw $s4, 352($sp)
	addu $sp, $sp, 400
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 1
string_6:
.asciiz " "
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
global_5:
.space 4
.align 2
