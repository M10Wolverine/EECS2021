	# --- data definition ---
MAX: 	DW 2147483647;
SIZE: 	DB -32;
count: 	DW 0

getCount: #-----------------------------
# push operation
addi 	x2, x2, -8
sd 	x1, 0(x2)

lw 	x10, count(x0)

# pop operation
ld	x1, 0(x2)
addi 	x2, x2, 8
jalr 	x0, 0(x1)

setCount: #--------------
#push operation
addi 	x2, x2, -8
sd x1, 0(x2)

sd 	x12, count(x0) #save arg. reg. x12 to count

#pop
ld 	x1, 0(x2)
addi	x2, x2, 8
jalr 	x0, 0(x1)

# --- STACK definition ---
BSTACK: DD 0xffffffffffff0000 # The bottom of the stack
TSTACK: DD 0xfffffffffffffff8 # The top of the stack



	#----------------------------
START:
#--- Stack pointer Initialization
ld 	x2, TSTACK(x0)

#-----------------------------
jal 	x1, getCount
add 	x5, x0, x10
ecall 	x0, x5, 0

#Test case for setCount------------
ecall 	x12, x0, 5		#prompt user for input and save to arg. reg. x12
jal	x1, setCount		#set count to input
jal 	x1, getCount		#get value of count
add	x5, x0, x10
ecall 	x0, x5, 0

lw 	x5, MAX(x0)
ecall 	x0, x5, 0
#lbu 	x5, SIZE(x0)
addi 	x6, x0, 8
lbu 	x5, MAX(x6)
ecall 	x0, x5, 0