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
jalr  x0, 0(x1)        # return to caller 
#----------------------------- 
Fraction:


addi  x2, x0, -24      # Allocate 3 spaces in stack  
sd    x1, 24(x2)       # save x1 

add   x5, x0, x12      # x5 = numerator
add   x6, x0, x13      # x6 = denominator
sd    x5, 16(x2)       # save x5 
sd    x6, 8(x2)        # save x6 

 
addi  x12, x0, 8       # 8 bytes of the heap memory requested 
jal   x1, MALLOC       # requesting memory allocation
ld    x6, 8(x2)       # load x6 
ld    x5, 16(x2)        # load x5 
sw    x5, 0(x10)       # store numerator in memory
sw    x6, 4(x10)       # store denominator in memory
			# replace ? with a proper number
			# recall it is a 32 bits int
ld    x1, 24(x2)        # load x1 
addi  x2, x0, 24       # recall the space in stack
jalr  x0, 0(x1)        # return to the caller

getNumerator:
#---------------------------------------------
#// retrieve the numerator of this
#// fraction and return it in x10.

lw 	x10, 	0(x12)
jalr 	x0, 	0(x1)

getDenominator:
#---------------------------------------------
#// retrieve the denominator of this
#// fraction and return it in x10.

lw 	x10, 	4(x12) #4 byte offset
jalr 	x0, 	0(x1)

adding:
#---------------------------------------------
#// Given a fraction address in x12,
#// and a second fraction address in x13,
#// mutate the fraction at x12 so it becomes
#// the sum of the two fractions
#addi	x2, x0, -8
#sd	x1, 8(x2)

lw	x5, 0(x12) #numerator
lw	x6, 4(x12) #denominator
lw	x28, 0(x13) #numerator
lw	x29, 4(x13) #denominator

#Add numerator
mul	x30, x5, x29
mul	x31, x6, x28
add	x5, x30, x31

#Add denominator
mul	x6, x6, x29

#Save fraction
sw	x5, 0(x12)
sw	x6, 4(x12)

jalr 	x0, 0(x1)

multiplying:
#--------------------
lw	x5, 0(x12) #numerator
lw	x6, 4(x12) #denominator
lw	x28, 0(x13) #numerator
lw	x29, 4(x13) #denominator

#Multiply numerator
mul	x5, x5, x28

#Multiply denominator
mul	x6, x6, x29

#Save fraction
sw	x5, 0(x12)
sw	x6, 4(x12)

jalr 	x0, 0(x1)

subtracting:
#------------------
lw	x5, 0(x12) #numerator
lw	x6, 4(x12) #denominator
lw	x28, 0(x13) #numerator
lw	x29, 4(x13) #denominator

#Turn other numerator negative
addi x7, x0, -1
mul x28, x28, x7

#Add numerator
mul	x30, x5, x29
mul	x31, x6, x28
add	x5, x30, x31

#Add denominator
mul	x6, x6, x29

#Save fraction
sw	x5, 0(x12)
sw	x6, 4(x12)

jalr 	x0, 0(x1)

dividing:
#--------------------
lw	x5, 0(x12) #numerator
lw	x6, 4(x12) #denominator
lw	x28, 0(x13) #numerator
lw	x29, 4(x13) #denominator

#Multiply numerator
mul	x5, x5, x29

#Multiply denominator
mul	x6, x6, x28

#Save fraction
sw	x5, 0(x12)
sw	x6, 4(x12)

jalr 	x0, 0(x1)

setNumerator:
#-------------------------
#sets numerator to specified immediate
sw	x13, 0(x12)
jalr	x0, 0(x1)

setDenominator:
#-----------------------
#sets denominator to specified immediate
sw	x13, 4(x12)
jalr	x0, 0(x1)


#--------------------------------
START:                 # START of the application 
#---  Stack pointer Initialization  
ld    sp, TSTACK(x0) 
#---  Global pointer Initialization 
auipc x3, GLOBAL   
srli  x3, x3, 12

#Fraction
addi	x2, x2, -12
sw	x1, 12(x2) 
addi 	x12, x0, 3
addi 	x13, x0, 8
jal 	x1, Fraction
add	x8, x0, x10 #s0 holds a

#addi	x2, x2, -8
sw	x1, 8(x2)
addi 	x12, x0, 1
addi	x13, x0, 2
jal	x1, Fraction
add	x9, x0, x10

#Print values
add	x12, x0, x8
jal	x1, getNumerator
ecall	x0, x10, 0

jal 	x1, getDenominator
ecall	x0, x10, 0

add	x12, x0, x9
jal	x1, getNumerator
ecall	x0, x10, 0

jal 	x1, getDenominator
ecall	x0, x10, 0

#Add fractions------------
add 	x12, x0, x8
add	x13, x0, x9
jal	x1, adding

#Print new fraction
add	x12, x0, x8
jal	x1, getNumerator
ecall	x0, x10, 0
jal 	x1, getDenominator
ecall	x0, x10, 0

#Subtract fractions------
add 	x12, x0, x8
add	x13, x0, x9
jal	x1, subtracting    

#Print new fraction
add	x12, x0, x8
jal	x1, getNumerator
ecall	x0, x10, 0
jal 	x1, getDenominator
ecall	x0, x10, 0

#Multiply fractions---------
add 	x12, x0, x8
add	x13, x0, x9
jal	x1, multiplying

#Print new fraction
add	x12, x0, x8
jal	x1, getNumerator
ecall	x0, x10, 0
jal 	x1, getDenominator
ecall	x0, x10, 0  

#Divide fractions---------
add 	x12, x0, x8
add	x13, x0, x9
jal	x1, dividing

#Print new fraction
add	x12, x0, x8
jal	x1, getNumerator
ecall	x0, x10, 0
jal 	x1, getDenominator
ecall	x0, x10, 0 

#Set numerator and denominator-------------
add	x12, x0, x8
addi	x13, x0, 5
jal	x1, setNumerator

addi	x13, x0, 7
jal	x1, setDenominator

#Print new values
jal	x1, getNumerator
ecall	x0, x10, 0

jal x1, getDenominator
ecall	x0, x10, 0



#------------------------------- 
# The rest of the code goes here 
#addi  x12, x0, 4			# 4 bytes of heap requested 
#jal   x1, MALLOC       # requesting memory allocation  
#ecall x0, x10, 2       # printing the return address in hexadecimal 

#addi  x12, x0, 8			# 8 bytes of heap requested 
#jal   x1, MALLOC       # requesting memory allocation  
#ecall x0, x10, 2       # printing the return address in hexadecimal 
