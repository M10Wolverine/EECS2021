main:
	add 	x6, x0, x0 #x6=s0, set equal to 0
	ecall	x5, x0, 5 #x5 = t0, read and save
	add 	x7, x0, x0 #x7 = t5, set equal to 0
	add 	x8, x0, x0 #used to store value of less than

loop: 	slt 	x8, x7, x5 #set 8 to 1 if t5 is less than t0
	beq 	x8, x0, fini #if 8 is 0 jump to fini
	add 	x6, x6, x7 #add s0 t t5, save to s0
	addi 	x7, x7, 1 #add 1 to t5
	jal 	x1, loop #jump to loop
fini:	ecall 	x0, x6, 0