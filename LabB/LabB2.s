main: #---------------------
addi 	x5, x0, 60 # x5 = 60
addi 	x6, x0, 7 	# x6 = 7
add 	x7, x5, x6 # x7 = x5+x6
#------------------------------
ecall x0, x7, 3 # do print