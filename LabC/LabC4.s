	# --- data definition ---
MAX: 	DW 2147483647;
SIZE: 	DB -32;
count: 	DW 0

getCount: #-----------------------------
lw 	x10, count(x0)
# pop operation
addi 	x2, x2, 8
ld 	x1, 0(x2) 

jalr 	x0, 0(x1)

# --- STACK definition ---
BSTACK: DD 0xffffffffffff0000 # The bottom of the stack
TSTACK: DD 0xfffffffffffffff8 # The top of the stack



	#----------------------------
START:
#--- Stack pointer Initialization
ld 	x2, TSTACK(x0)
# push operation
sd 	x1, 0(x2)
addi 	x2, x2, -8
#-----------------------------
jal 	x1, getCount
add 	x5, x0, x10
ecall 	x0, x5, 0
lw 	x5, MAX(x0)
ecall 	x0, x5, 0
#lbu 	x5, SIZE(x0)
addi 	x6, x0, 8
lbu 	x5, MAX(x6)
ecall 	x0, x5, 0