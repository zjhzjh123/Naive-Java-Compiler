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
label_276:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s4, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s4)
	sw $s4, global_13
	li $t1, 0
	sw $t1, global_14
	b label_278
label_278:
	lw $t0, global_14
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_281
	b label_279
label_279:
	lw $t0, 0($sp)
	addi $s4, $t0, 1
	mul $s4, $s4, $k0
	move $a0, $s4
	li $v0, 9
	syscall
	move $s3, $v0
	lw $t0, 0($sp)
	sw $t0, 0($s3)
	lw $t0, global_14
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	sw $s3, 4($s4)
	li $t1, 0
	sw $t1, global_15
	b label_282
label_282:
	lw $t0, global_15
	lw $t1, 0($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_285
	b label_283
label_283:
	lw $t0, global_14
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_15
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, 0
	sw $t0, 4($s4)
label_284:
	lw $t1, global_15
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_15
	b label_282
label_285:
label_280:
	lw $t1, global_14
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_14
	b label_278
label_281:
label_277:
label_277:
	lw $ra, 192($sp)
	lw $s3, 148($sp)
	lw $s4, 152($sp)
	addu $sp, $sp, 200
	jr $ra
_check:
	sub $sp, $sp, 148
	sw $s4, 100($sp)
	sw $ra, 140($sp)
label_286:
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_290
	b label_288
label_288:
	lw $t0, 0($sp)
	li $t1, 0
	sge $s4, $t0, $t1
	beqz $s4, label_290
	b label_289
label_289:
	li $t1, 1
	move $s4, $t1
	b label_291
label_290:
	li $t1, 0
	move $s4, $t1
	b label_291
label_291:
	move $v0, $s4
	b label_287
label_287:
	lw $ra, 140($sp)
	lw $s4, 100($sp)
	addu $sp, $sp, 148
	jr $ra
_addList:
	sub $sp, $sp, 236
	sw $s2, 180($sp)
	sw $s3, 184($sp)
	sw $s4, 188($sp)
	sw $ra, 228($sp)
label_292:
	lw $t1, 0($sp)
	sw $t1, -148($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _check
	move $s4, $v0
	beqz $s4, label_298
	b label_296
label_296:
	lw $t1, 4($sp)
	sw $t1, -148($sp)
	lw $t1, global_0
	sw $t1, -144($sp)
	jal _check
	move $s4, $v0
	beqz $s4, label_302
	b label_300
label_300:
	lw $t0, 0($sp)
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, 4($sp)
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	li $t1, -1
	seq $s4, $s4, $t1
	beqz $s4, label_302
	b label_301
label_301:
	li $t1, 1
	move $s4, $t1
	b label_303
label_302:
	li $t1, 0
	move $s4, $t1
	b label_303
label_303:
	beqz $s4, label_298
	b label_297
label_297:
	li $t1, 1
	move $s4, $t1
	b label_299
label_298:
	li $t1, 0
	move $s4, $t1
	b label_299
label_299:
	beqz $s4, label_295
	b label_294
label_294:
	lw $t0, global_10
	addi $s4, $t0, 1
	sw $s4, global_10
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
	addi $s4, $t0, 1
	lw $t0, 0($sp)
	mul $s3, $t0, $k0
	lw $t0, global_13
	addu $s3, $t0, $s3
	lw $s2, 4($s3)
	lw $t0, 4($sp)
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	sw $s4, 4($s3)
	lw $t0, 0($sp)
	lw $t1, global_4
	seq $s4, $t0, $t1
	beqz $s4, label_308
	b label_306
label_306:
	lw $t0, 4($sp)
	lw $t1, global_5
	seq $s4, $t0, $t1
	beqz $s4, label_308
	b label_307
label_307:
	li $t1, 1
	move $s4, $t1
	b label_309
label_308:
	li $t1, 0
	move $s4, $t1
	b label_309
label_309:
	beqz $s4, label_305
	b label_304
label_304:
	li $t1, 1
	sw $t1, global_11
	b label_305
label_305:
	b label_295
label_295:
label_293:
label_293:
	lw $ra, 228($sp)
	lw $s2, 180($sp)
	lw $s3, 184($sp)
	lw $s4, 188($sp)
	addu $sp, $sp, 236
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 396
	sw $s3, 344($sp)
	sw $s4, 348($sp)
	sw $ra, 388($sp)
label_310:
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
	sw $t1, global_14
	b label_312
label_312:
	lw $t0, global_14
	lw $t1, global_0
	slt $s4, $t0, $t1
	beqz $s4, label_315
	b label_313
label_313:
	li $t1, 0
	sw $t1, global_15
	b label_316
label_316:
	lw $t0, global_15
	lw $t1, global_0
	slt $s4, $t0, $t1
	beqz $s4, label_319
	b label_317
label_317:
	lw $t0, global_14
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_15
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	li $t0, -1
	sw $t0, 4($s4)
label_318:
	lw $t1, global_15
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_15
	b label_316
label_319:
label_314:
	lw $t1, global_14
	move $s4, $t1
	addi $t1, $s4, 1
	sw $t1, global_14
	b label_312
label_315:
	b label_320
label_320:
	lw $t0, global_1
	lw $t1, global_10
	sle $s4, $t0, $t1
	beqz $s4, label_322
	b label_321
label_321:
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
	lw $t0, global_13
	addu $s4, $t0, $s4
	lw $s4, 4($s4)
	lw $t0, global_7
	mul $s3, $t0, $k0
	addu $s4, $s4, $s3
	lw $s4, 4($s4)
	sw $s4, global_12
	lw $t0, global_6
	li $t1, 1
	sub $s4, $t0, $t1
	lw $t0, global_7
	li $t1, 2
	sub $s3, $t0, $t1
	sw $s4, -236($sp)
	sw $s3, -232($sp)
	jal _addList
	lw $t0, global_6
	li $t1, 1
	sub $s4, $t0, $t1
	lw $t0, global_7
	addi $s3, $t0, 2
	sw $s4, -236($sp)
	sw $s3, -232($sp)
	jal _addList
	lw $t0, global_6
	addi $s3, $t0, 1
	lw $t0, global_7
	li $t1, 2
	sub $s4, $t0, $t1
	sw $s3, -236($sp)
	sw $s4, -232($sp)
	jal _addList
	lw $t0, global_6
	addi $s3, $t0, 1
	lw $t0, global_7
	addi $s4, $t0, 2
	sw $s3, -236($sp)
	sw $s4, -232($sp)
	jal _addList
	lw $t0, global_6
	li $t1, 2
	sub $s3, $t0, $t1
	lw $t0, global_7
	li $t1, 1
	sub $s4, $t0, $t1
	sw $s3, -236($sp)
	sw $s4, -232($sp)
	jal _addList
	lw $t0, global_6
	li $t1, 2
	sub $s4, $t0, $t1
	lw $t0, global_7
	addi $s3, $t0, 1
	sw $s4, -236($sp)
	sw $s3, -232($sp)
	jal _addList
	lw $t0, global_6
	addi $s3, $t0, 2
	lw $t0, global_7
	li $t1, 1
	sub $s4, $t0, $t1
	sw $s3, -236($sp)
	sw $s4, -232($sp)
	jal _addList
	lw $t0, global_6
	addi $s3, $t0, 2
	lw $t0, global_7
	addi $s4, $t0, 1
	sw $s3, -236($sp)
	sw $s4, -232($sp)
	jal _addList
	lw $t0, global_11
	li $t1, 1
	seq $s4, $t0, $t1
	beqz $s4, label_324
	b label_323
label_323:
	b label_322
label_324:
	lw $t0, global_1
	addi $s4, $t0, 1
	sw $s4, global_1
	b label_320
label_322:
	lw $t0, global_11
	li $t1, 1
	seq $s4, $t0, $t1
	beqz $s4, label_326
	b label_325
label_325:
	lw $t0, global_4
	mul $s4, $t0, $k0
	lw $t0, global_13
	addu $s4, $t0, $s4
	lw $s3, 4($s4)
	lw $t0, global_5
	mul $s4, $t0, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	b label_327
label_326:
	la $a0, string_16
	jal print
	b label_327
label_327:
	li $v0, 0
	b label_311
label_311:
	lw $ra, 388($sp)
	lw $s3, 344($sp)
	lw $s4, 348($sp)
	addu $sp, $sp, 396
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 13
string_16:
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
