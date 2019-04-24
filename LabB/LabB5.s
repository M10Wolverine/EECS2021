main: #---------------------
ecall 	x5, x0, 5  
addi 	x6, x0, 7 		# x6 = 7
slt	x28, x5, x6 		# set x28 to 1 if 5<6
beq 	x28, x0, XX
add 	x7, x5, x6 		# x7 = x5+x6
jal 	x1, YY
XX:#---------------------- 
sub 	x7, x5, x6	# x7=x5-x6
YY:#----------------------
#------------------------------
ecall x0, x7, 0 # do print