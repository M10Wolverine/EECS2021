GLOBAL:            # Global location of the whole program 
# --- STACK definition --- 
BSTACK: 	DD 0xffffffffffff0000   # The bottom of the stack     
TSTACK: 	DD 0xfffffffffffffff8   # The top of the stack 
#----------------------------- 
# --- HEAP definition --- 
BHEAP: 	DD 0xffff000000000000  # The top of the HEAP     
THEAP:	DD 0xffffffffffff0000  # The bottom of the HEAP 
MAL_LAST_IDX: DD 0    
               # The last available index in 
                  # the heap 
#--- Memory allocation -- Simple array for the heap representation 
MALLOC: 
addi	x2, x2, -16
sd 	x5, 16(x2)
sd	x6, 8(x2)
ld    x5, x0, MAL_LAST_IDX    # Load the value of the index  
ld    x6, x0, BHEAP    # Load the address of the base of the heap 
add   x10, x5, x6      # Calculating the allocated address for returning 
auipc x7, MAL_LAST_IDX # Loading the address of the index into upper 20  
                       # bits word 
srli  x7, x7, 12       # Shift to the right by 12 bits to the right  
                       # address 
slli  x28, x12, 2      # make the index always multiple of 4 
add   x5, x5, x28			# Increasing the index 
sd    x5, 0(x7)        # Store the new value of index
ld 	x6, 8(x2)
ld	x5, 16(x2) 
addi	x2, x2, 16
jalr  x0, 0(x1)        # return to caller 
#----------------------------- 
Fraction:


addi  x2, x0, -24      # Allocate 3 spaces in stack  
sd    x1, 16(x2)       # save x1 
sd    x5, 8(x2)       # save x5 
sd    x6, 0(x2)        # save x6 

add   x5, x0, x12      # x5 = numerator
add   x6, x0, x13      # x6 = denominator 
addi  x12, x0, 8       # 8 bytes of the heap memory requested 
jal   x1, MALLOC       # requesting memory allocation
ld    x6, 0(x2)       # load x6 
ld    x5, 8(x2)        # load x5 
sw    x5, 0(x10)       # store numerator in memory
sw    x6, 4(x10)       # store denominator in memory
			# replace ? with a proper number
			# recall it is a 32 bits int
ld    x1, 16(x2)        # load x1 
addi  x2, x0, 24       # recall the space in stack
jalr  x0, 0(x1)        # return to the caller
#--------------------------------

START:                 # START of the application 
#---  Stack pointer Initialization  
ld    sp, TSTACK(x0) 
#---  Global pointer Initialization 
auipc x3, GLOBAL   
srli  x3, x3, 12

#Fraction
addi	x2, x2, -4
sw	x1, 4(x2) 
addi 	x12, x0, 3
addi 	x13, x0, 8
jal 	x1, Fraction
add	x8, x0, x10 #s0 holds a
      
#------------------------------- 
# The rest of the code goes here 
addi  x12, x0, 4			# 4 bytes of heap requested 
jal   x1, MALLOC       # requesting memory allocation  
ecall x0, x10, 2       # printing the return address in hexadecimal 

addi  x12, x0, 8			# 8 bytes of heap requested 
jal   x1, MALLOC       # requesting memory allocation  
ecall x0, x10, 2       # printing the return address in hexadecimal 
