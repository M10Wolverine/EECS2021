main: #---------------------
addi 	x5, x0, -60
srai 	x28, x5, 1
ecall 	x0, x28, 0
slli 	x28, x5, 1
ecall x0, x28, 0
#---------------------
fini: