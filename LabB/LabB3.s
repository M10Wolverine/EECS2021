main: #---------------------
ecall 	x5, x0, 5  
addi 	x6, x0, 7 	# x6 = 7
add 	x7, x5, x6 # x7 = x5+x6
#------------------------------
ecall x0, x7, 0 # do print