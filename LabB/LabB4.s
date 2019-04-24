main: #---------------------
ecall 	x5, x0, 5  
addi 	x6, x0, 7 	# x6 = 7
beq 	x5, x6, XX
sub 	x7, x6, x5 # x7 = x5-x6
jal 	x1, YY
XX:#---------------------- 
add 	x7, x5, x6	# x7=x5+x6
YY:#----------------------
#------------------------------
ecall x0, x7, 0 # do print