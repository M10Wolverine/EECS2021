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
sd 	x1, 0(x2)

sd	x12, count(x0)	#save arg. reg. x12 to count

#pop
ld 	x1, 0(x2)
addi	x2, x2, 8
jalr 	x0, 0(x1)

incrementCount: #--------------
#push operation
addi 	x2, x2, -8
sd 	x1, 0(x2)

lw	x5, count(x0)		#load count to x5
addi 	x5, x5, 1		#add 1 to x5
sd 	x5, count(x0) 		#save x5 back to count

#pop
ld 	x1, 0(x2)
addi	x2, x2, 8
jalr 	x0, 0(x1)

signum: #---------------------
#push operation
addi 	x2, x2, -8
sd 	x1, 0(x2)

	blt 	x13, x0, LT 		#check if arg. reg. x13 is less than 0
	beq	x13, x0, EQ		#check if equal
	addi 	x7, x0, 1	  	#otherwise set temp. x7 to 1
	beq	x0, x0, FINI		#jump to FINI

LT:	addi 	x7, x0, -1		#set x7 to -1
	beq 	x0, x0, FINI		

EQ:	add 	x7, x0, x0		#set x7 to 0

FINI:	jal 	x1, incrementCount		#increment count
	add 	x11, x7, x0		#set return reg. x11 to value of x7

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
#ecall 	x12, x0, 5		#prompt user for input and save to arg. reg. x12
#jal	x1, setCount		#set count to input
#jal 	x1, getCount		#get value of count
#add	x5, x0, x10
#ecall 	x0, x5, 0

#Tests for signum 
ecall 	x13, x0, 5		#prompt for input, save to arg. reg. x13
jal	x1, signum		#call signum
ecall	x0, x11, 0		#checks answer of signum
jal 	x1, getCount		#checks value of count
add 	x5, x0, x10		#saves returned value to temp. reg. x5
ecall 	x0, x5, 0		#output value of count

ecall 	x13, x0, 5		#prompt for input, save to arg. reg. x13
jal	x1, signum		#call signum
ecall	x0, x11, 0		#checks answer of signum
jal 	x1, getCount		#checks value of count
add 	x5, x0, x10		#saves returned value to temp. reg. x5
ecall 	x0, x5, 0		#output value of count

ecall 	x13, x0, 5		#prompt for input, save to arg. reg. x13
jal	x1, signum		#call signum
ecall	x0, x11, 0		#checks answer of signum
jal 	x1, getCount		#checks value of count
add 	x5, x0, x10		#saves returned value to temp. reg. x5
ecall 	x0, x5, 0		#output value of count


#lw 	x5, MAX(x0)
#ecall 	x0, x5, 0
#lbu 	x5, SIZE(x0)
#addi 	x6, x0, 8
#lbu 	x5, MAX(x6)
#ecall 	x0, x5, 0