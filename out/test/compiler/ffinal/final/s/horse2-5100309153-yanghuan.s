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
_check:
	sub $sp, $sp, 148
	sw $s4, 100($sp)
	sw $ra, 140($sp)
label_346:
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	slt $s4, $t0, $t1
	beqz $s4, label_350
	b label_348
label_348:
	lw $t0, 0($sp)
	li $t1, 0
	sge $s4, $t0, $t1
	beqz $s4, label_350
	b label_349
label_349:
	li $t1, 1
	move $s4, $t1
	b label_351
label_350:
	li $t1, 0
	move $s4, $t1
	b label_351
label_351:
	move $v0, $s4
	b label_347
label_347:
	lw $ra, 140($sp)
	lw $s4, 100($sp)
	addu $sp, $sp, 148
	jr $ra
main:
	li $k0, 4
	sub $sp, $sp, 1540
	sw $s6, 1436($sp)
	sw $s7, 1440($sp)
	sw $t2, 1444($sp)
	sw $t3, 1448($sp)
	sw $t4, 1452($sp)
	sw $t5, 1456($sp)
	sw $t6, 1460($sp)
	sw $t7, 1464($sp)
	sw $t8, 1468($sp)
	sw $t9, 1472($sp)
	sw $s0, 1476($sp)
	sw $s1, 1480($sp)
	sw $s2, 1484($sp)
	sw $s3, 1488($sp)
	sw $s4, 1492($sp)
	sw $ra, 1532($sp)
label_352:
	jal getInt
	move $s4, $v0
	move $s1, $s4
	li $t1, 0
	move $t2, $t1
	li $t1, 0
	move $t6, $t1
	li $t1, 0
	move $t8, $t1
	li $t1, 0
	move $t4, $t1
	li $t1, 1
	sub $s3, $s1, $t1
	move $s4, $s3
	move $t9, $s3
	li $t1, 0
	move $t5, $t1
	li $t1, 0
	move $s3, $t1
	li $t1, 0
	move $s0, $t1
	li $t1, 0
	move $s7, $t1
	mul $s2, $s1, $s1
	addi $s3, $s2, 1
	mul $s3, $s3, $k0
	move $a0, $s3
	li $v0, 9
	syscall
	move $s3, $v0
	sw $s2, 0($s3)
	move $t3, $s3
	li $t1, 0
	move $s3, $t1
	b label_354
label_354:
	mul $s2, $s1, $s1
	slt $s2, $s3, $s2
	beqz $s2, label_357
	b label_355
label_355:
	mul $s2, $s3, $k0
	addu $s2, $t3, $s2
	li $t0, 0
	sw $t0, 4($s2)
label_356:
	move $s3, $s3
	addi $s3, $s3, 1
	b label_354
label_357:
	mul $s2, $s1, $s1
	addi $s3, $s2, 1
	mul $s3, $s3, $k0
	move $a0, $s3
	li $v0, 9
	syscall
	move $s3, $v0
	sw $s2, 0($s3)
	move $s2, $s3
	li $t1, 0
	move $s3, $t1
	b label_358
label_358:
	mul $t7, $s1, $s1
	slt $t7, $s3, $t7
	beqz $t7, label_361
	b label_359
label_359:
	mul $t7, $s3, $k0
	addu $t7, $s2, $t7
	li $t0, 0
	sw $t0, 4($t7)
label_360:
	move $s3, $s3
	addi $s3, $s3, 1
	b label_358
label_361:
	addi $s3, $s1, 1
	mul $s3, $s3, $k0
	move $a0, $s3
	li $v0, 9
	syscall
	move $s3, $v0
	sw $s1, 0($s3)
	move $t7, $s3
	li $t1, 0
	move $s3, $t1
	b label_362
label_362:
	slt $t5, $s3, $s1
	beqz $t5, label_365
	b label_363
label_363:
	addi $t5, $s1, 1
	mul $t5, $t5, $k0
	move $a0, $t5
	li $v0, 9
	syscall
	move $t5, $v0
	sw $s1, 0($t5)
	mul $s7, $s3, $k0
	addu $s7, $t7, $s7
	sw $t5, 4($s7)
	li $t1, 0
	move $s7, $t1
	b label_366
label_366:
	slt $t5, $s7, $s1
	beqz $t5, label_369
	b label_367
label_367:
	mul $t5, $s3, $k0
	addu $t5, $t7, $t5
	lw $t5, 4($t5)
	mul $s6, $s7, $k0
	addu $t5, $t5, $s6
	li $t0, -1
	sw $t0, 4($t5)
label_368:
	move $t5, $s7
	addi $s7, $t5, 1
	b label_366
label_369:
label_364:
	move $s3, $s3
	addi $s3, $s3, 1
	b label_362
label_365:
	li $t0, 0
	mul $s3, $t0, $k0
	addu $s3, $t3, $s3
	sw $t6, 4($s3)
	li $t0, 0
	mul $s3, $t0, $k0
	addu $s3, $s2, $s3
	sw $t2, 4($s3)
	mul $s3, $t6, $k0
	addu $s3, $t7, $s3
	lw $s3, 4($s3)
	mul $t6, $t2, $k0
	addu $s3, $s3, $t6
	lw $s3, 4($s3)
	li $t1, 0
	seq $s3, $s3, $t1
	b label_370
label_370:
	sle $s3, $t4, $t8
	beqz $s3, label_372
	b label_371
label_371:
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	mul $s3, $s3, $k0
	addu $s3, $t7, $s3
	lw $s3, 4($s3)
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	mul $t6, $t6, $k0
	addu $s3, $s3, $t6
	lw $s3, 4($s3)
	move $s7, $s3
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	li $t1, 1
	sub $s3, $s3, $t1
	move $s3, $s3
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	li $t1, 2
	sub $t6, $t6, $t1
	move $t5, $t6
	sw $s3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_377
	b label_375
label_375:
	sw $t5, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_381
	b label_379
label_379:
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	lw $t6, 4($t6)
	li $t1, -1
	seq $t6, $t6, $t1
	beqz $t6, label_381
	b label_380
label_380:
	li $t1, 1
	move $t6, $t1
	b label_382
label_381:
	li $t1, 0
	move $t6, $t1
	b label_382
label_382:
	beqz $t6, label_377
	b label_376
label_376:
	li $t1, 1
	move $t6, $t1
	b label_378
label_377:
	li $t1, 0
	move $t6, $t1
	b label_378
label_378:
	beqz $t6, label_374
	b label_373
label_373:
	addi $t8, $t8, 1
	move $t8, $t8
	mul $t6, $t8, $k0
	addu $t6, $t3, $t6
	sw $s3, 4($t6)
	mul $t6, $t8, $k0
	addu $t6, $s2, $t6
	sw $t5, 4($t6)
	addi $t2, $s7, 1
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $s6, 4($t6)
	mul $t6, $t5, $k0
	addu $t6, $s6, $t6
	sw $t2, 4($t6)
	seq $s3, $s3, $t9
	beqz $s3, label_387
	b label_385
label_385:
	seq $s3, $t5, $s4
	beqz $s3, label_387
	b label_386
label_386:
	li $t1, 1
	move $s3, $t1
	b label_388
label_387:
	li $t1, 0
	move $s3, $t1
	b label_388
label_388:
	beqz $s3, label_384
	b label_383
label_383:
	li $t1, 1
	move $s0, $t1
	b label_384
label_384:
	b label_374
label_374:
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	li $t1, 1
	sub $s3, $s3, $t1
	move $s3, $s3
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	addi $t6, $t6, 2
	move $t5, $t6
	sw $s3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_393
	b label_391
label_391:
	sw $t5, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_397
	b label_395
label_395:
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	lw $t6, 4($t6)
	li $t1, -1
	seq $t6, $t6, $t1
	beqz $t6, label_397
	b label_396
label_396:
	li $t1, 1
	move $t6, $t1
	b label_398
label_397:
	li $t1, 0
	move $t6, $t1
	b label_398
label_398:
	beqz $t6, label_393
	b label_392
label_392:
	li $t1, 1
	move $t6, $t1
	b label_394
label_393:
	li $t1, 0
	move $t6, $t1
	b label_394
label_394:
	beqz $t6, label_390
	b label_389
label_389:
	addi $t8, $t8, 1
	move $t8, $t8
	mul $t6, $t8, $k0
	addu $t6, $t3, $t6
	sw $s3, 4($t6)
	mul $t6, $t8, $k0
	addu $t6, $s2, $t6
	sw $t5, 4($t6)
	addi $t2, $s7, 1
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $s6, $t5, $k0
	addu $t6, $t6, $s6
	sw $t2, 4($t6)
	seq $s3, $s3, $t9
	beqz $s3, label_403
	b label_401
label_401:
	seq $s3, $t5, $s4
	beqz $s3, label_403
	b label_402
label_402:
	li $t1, 1
	move $s3, $t1
	b label_404
label_403:
	li $t1, 0
	move $s3, $t1
	b label_404
label_404:
	beqz $s3, label_400
	b label_399
label_399:
	li $t1, 1
	move $s0, $t1
	b label_400
label_400:
	b label_390
label_390:
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	li $t1, 2
	sub $t6, $t6, $t1
	move $t5, $t6
	sw $s3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_409
	b label_407
label_407:
	sw $t5, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_413
	b label_411
label_411:
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t2, 4($t6)
	mul $t6, $t5, $k0
	addu $t6, $t2, $t6
	lw $t6, 4($t6)
	li $t1, -1
	seq $t6, $t6, $t1
	beqz $t6, label_413
	b label_412
label_412:
	li $t1, 1
	move $t6, $t1
	b label_414
label_413:
	li $t1, 0
	move $t6, $t1
	b label_414
label_414:
	beqz $t6, label_409
	b label_408
label_408:
	li $t1, 1
	move $t6, $t1
	b label_410
label_409:
	li $t1, 0
	move $t6, $t1
	b label_410
label_410:
	beqz $t6, label_406
	b label_405
label_405:
	addi $t8, $t8, 1
	move $t8, $t8
	mul $t6, $t8, $k0
	addu $t6, $t3, $t6
	sw $s3, 4($t6)
	mul $t6, $t8, $k0
	addu $t6, $s2, $t6
	sw $t5, 4($t6)
	addi $t6, $s7, 1
	mul $t2, $s3, $k0
	addu $t2, $t7, $t2
	lw $t2, 4($t2)
	mul $s6, $t5, $k0
	addu $t2, $t2, $s6
	sw $t6, 4($t2)
	seq $s3, $s3, $t9
	beqz $s3, label_419
	b label_417
label_417:
	seq $s3, $t5, $s4
	beqz $s3, label_419
	b label_418
label_418:
	li $t1, 1
	move $s3, $t1
	b label_420
label_419:
	li $t1, 0
	move $s3, $t1
	b label_420
label_420:
	beqz $s3, label_416
	b label_415
label_415:
	li $t1, 1
	move $s0, $t1
	b label_416
label_416:
	b label_406
label_406:
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	addi $s3, $s3, 1
	move $s3, $s3
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	addi $t6, $t6, 2
	move $t5, $t6
	sw $s3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_425
	b label_423
label_423:
	sw $t5, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_429
	b label_427
label_427:
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	lw $t6, 4($t6)
	li $t1, -1
	seq $t6, $t6, $t1
	beqz $t6, label_429
	b label_428
label_428:
	li $t1, 1
	move $t6, $t1
	b label_430
label_429:
	li $t1, 0
	move $t6, $t1
	b label_430
label_430:
	beqz $t6, label_425
	b label_424
label_424:
	li $t1, 1
	move $t6, $t1
	b label_426
label_425:
	li $t1, 0
	move $t6, $t1
	b label_426
label_426:
	beqz $t6, label_422
	b label_421
label_421:
	addi $t8, $t8, 1
	move $t8, $t8
	mul $t6, $t8, $k0
	addu $t6, $t3, $t6
	sw $s3, 4($t6)
	mul $t6, $t8, $k0
	addu $t6, $s2, $t6
	sw $t5, 4($t6)
	addi $s6, $s7, 1
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	sw $s6, 4($t6)
	seq $s3, $s3, $t9
	beqz $s3, label_435
	b label_433
label_433:
	seq $s3, $t5, $s4
	beqz $s3, label_435
	b label_434
label_434:
	li $t1, 1
	move $s3, $t1
	b label_436
label_435:
	li $t1, 0
	move $s3, $t1
	b label_436
label_436:
	beqz $s3, label_432
	b label_431
label_431:
	li $t1, 1
	move $s0, $t1
	b label_432
label_432:
	b label_422
label_422:
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	li $t1, 2
	sub $s3, $s3, $t1
	move $s3, $s3
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	li $t1, 1
	sub $t6, $t6, $t1
	move $t5, $t6
	sw $s3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_441
	b label_439
label_439:
	sw $t5, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_445
	b label_443
label_443:
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	lw $t6, 4($t6)
	li $t1, -1
	seq $t6, $t6, $t1
	beqz $t6, label_445
	b label_444
label_444:
	li $t1, 1
	move $t6, $t1
	b label_446
label_445:
	li $t1, 0
	move $t6, $t1
	b label_446
label_446:
	beqz $t6, label_441
	b label_440
label_440:
	li $t1, 1
	move $t6, $t1
	b label_442
label_441:
	li $t1, 0
	move $t6, $t1
	b label_442
label_442:
	beqz $t6, label_438
	b label_437
label_437:
	addi $t8, $t8, 1
	move $t8, $t8
	mul $t6, $t8, $k0
	addu $t6, $t3, $t6
	sw $s3, 4($t6)
	mul $t6, $t8, $k0
	addu $t6, $s2, $t6
	sw $t5, 4($t6)
	addi $s6, $s7, 1
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	sw $s6, 4($t6)
	seq $s3, $s3, $t9
	beqz $s3, label_451
	b label_449
label_449:
	seq $s3, $t5, $s4
	beqz $s3, label_451
	b label_450
label_450:
	li $t1, 1
	move $s3, $t1
	b label_452
label_451:
	li $t1, 0
	move $s3, $t1
	b label_452
label_452:
	beqz $s3, label_448
	b label_447
label_447:
	li $t1, 1
	move $s0, $t1
	b label_448
label_448:
	b label_438
label_438:
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	li $t1, 2
	sub $s3, $s3, $t1
	move $s3, $s3
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	addi $t6, $t6, 1
	move $t5, $t6
	sw $s3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_457
	b label_455
label_455:
	sw $t5, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_461
	b label_459
label_459:
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	lw $t6, 4($t6)
	li $t1, -1
	seq $t6, $t6, $t1
	beqz $t6, label_461
	b label_460
label_460:
	li $t1, 1
	move $t6, $t1
	b label_462
label_461:
	li $t1, 0
	move $t6, $t1
	b label_462
label_462:
	beqz $t6, label_457
	b label_456
label_456:
	li $t1, 1
	move $t6, $t1
	b label_458
label_457:
	li $t1, 0
	move $t6, $t1
	b label_458
label_458:
	beqz $t6, label_454
	b label_453
label_453:
	addi $t8, $t8, 1
	move $t8, $t8
	mul $t6, $t8, $k0
	addu $t6, $t3, $t6
	sw $s3, 4($t6)
	mul $t6, $t8, $k0
	addu $t6, $s2, $t6
	sw $t5, 4($t6)
	addi $t2, $s7, 1
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $s6, $t5, $k0
	addu $t6, $t6, $s6
	sw $t2, 4($t6)
	seq $s3, $s3, $t9
	beqz $s3, label_467
	b label_465
label_465:
	seq $s3, $t5, $s4
	beqz $s3, label_467
	b label_466
label_466:
	li $t1, 1
	move $s3, $t1
	b label_468
label_467:
	li $t1, 0
	move $s3, $t1
	b label_468
label_468:
	beqz $s3, label_464
	b label_463
label_463:
	li $t1, 1
	move $s0, $t1
	b label_464
label_464:
	b label_454
label_454:
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	addi $s3, $s3, 2
	move $s3, $s3
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	li $t1, 1
	sub $t6, $t6, $t1
	move $t5, $t6
	sw $s3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_473
	b label_471
label_471:
	sw $t5, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_477
	b label_475
label_475:
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t2, 4($t6)
	mul $t6, $t5, $k0
	addu $t6, $t2, $t6
	lw $t6, 4($t6)
	li $t1, -1
	seq $t6, $t6, $t1
	beqz $t6, label_477
	b label_476
label_476:
	li $t1, 1
	move $t6, $t1
	b label_478
label_477:
	li $t1, 0
	move $t6, $t1
	b label_478
label_478:
	beqz $t6, label_473
	b label_472
label_472:
	li $t1, 1
	move $t6, $t1
	b label_474
label_473:
	li $t1, 0
	move $t6, $t1
	b label_474
label_474:
	beqz $t6, label_470
	b label_469
label_469:
	addi $t8, $t8, 1
	move $t8, $t8
	mul $t6, $t8, $k0
	addu $t6, $t3, $t6
	sw $s3, 4($t6)
	mul $t6, $t8, $k0
	addu $t6, $s2, $t6
	sw $t5, 4($t6)
	addi $t2, $s7, 1
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $s6, $t5, $k0
	addu $t6, $t6, $s6
	sw $t2, 4($t6)
	seq $s3, $s3, $t9
	beqz $s3, label_483
	b label_481
label_481:
	seq $s3, $t5, $s4
	beqz $s3, label_483
	b label_482
label_482:
	li $t1, 1
	move $s3, $t1
	b label_484
label_483:
	li $t1, 0
	move $s3, $t1
	b label_484
label_484:
	beqz $s3, label_480
	b label_479
label_479:
	li $t1, 1
	move $s0, $t1
	b label_480
label_480:
	b label_470
label_470:
	mul $s3, $t4, $k0
	addu $s3, $t3, $s3
	lw $s3, 4($s3)
	addi $s3, $s3, 2
	move $s3, $s3
	mul $t6, $t4, $k0
	addu $t6, $s2, $t6
	lw $t6, 4($t6)
	addi $t6, $t6, 1
	move $t5, $t6
	sw $s3, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_489
	b label_487
label_487:
	sw $t5, -148($sp)
	sw $s1, -144($sp)
	jal _check
	move $t6, $v0
	beqz $t6, label_493
	b label_491
label_491:
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	lw $t6, 4($t6)
	li $t1, -1
	seq $t6, $t6, $t1
	beqz $t6, label_493
	b label_492
label_492:
	li $t1, 1
	move $t6, $t1
	b label_494
label_493:
	li $t1, 0
	move $t6, $t1
	b label_494
label_494:
	beqz $t6, label_489
	b label_488
label_488:
	li $t1, 1
	move $t6, $t1
	b label_490
label_489:
	li $t1, 0
	move $t6, $t1
	b label_490
label_490:
	beqz $t6, label_486
	b label_485
label_485:
	addi $t8, $t8, 1
	move $t8, $t8
	mul $t6, $t8, $k0
	addu $t6, $t3, $t6
	sw $s3, 4($t6)
	mul $t6, $t8, $k0
	addu $t6, $s2, $t6
	sw $t5, 4($t6)
	addi $s7, $s7, 1
	mul $t6, $s3, $k0
	addu $t6, $t7, $t6
	lw $t6, 4($t6)
	mul $t2, $t5, $k0
	addu $t6, $t6, $t2
	sw $s7, 4($t6)
	seq $s3, $s3, $t9
	beqz $s3, label_499
	b label_497
label_497:
	seq $s3, $t5, $s4
	beqz $s3, label_499
	b label_498
label_498:
	li $t1, 1
	move $s3, $t1
	b label_500
label_499:
	li $t1, 0
	move $s3, $t1
	b label_500
label_500:
	beqz $s3, label_496
	b label_495
label_495:
	li $t1, 1
	move $s0, $t1
	b label_496
label_496:
	b label_486
label_486:
	li $t1, 1
	seq $s3, $s0, $t1
	beqz $s3, label_502
	b label_501
label_501:
	b label_372
label_502:
	addi $s3, $t4, 1
	move $t4, $s3
	b label_370
label_372:
	li $t1, 1
	seq $s3, $s0, $t1
	beqz $s3, label_504
	b label_503
label_503:
	mul $s3, $t9, $k0
	addu $s3, $t7, $s3
	lw $s3, 4($s3)
	mul $s4, $s4, $k0
	addu $s4, $s3, $s4
	lw $s4, 4($s4)
	move $a0, $s4
	jal toString
	move $s4, $v0
	move $a0, $s4
	jal println
	b label_505
label_504:
	la $a0, string_0
	jal print
	b label_505
label_505:
	li $v0, 0
	b label_353
label_353:
	lw $ra, 1532($sp)
	lw $s6, 1436($sp)
	lw $s7, 1440($sp)
	lw $t2, 1444($sp)
	lw $t3, 1448($sp)
	lw $t4, 1452($sp)
	lw $t5, 1456($sp)
	lw $t6, 1460($sp)
	lw $t7, 1464($sp)
	lw $t8, 1468($sp)
	lw $t9, 1472($sp)
	lw $s0, 1476($sp)
	lw $s1, 1480($sp)
	lw $s2, 1484($sp)
	lw $s3, 1488($sp)
	lw $s4, 1492($sp)
	addu $sp, $sp, 1540
	jr $ra
	.data
____string_buffer:
	.space 1024
	.align 2
____string_newline:
	.asciiz "\n"
	.align 2
.word 13
string_0:
.asciiz "no solution!\n"
.align 2
