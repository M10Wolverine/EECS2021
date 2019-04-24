module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
wire [31:0] andOut, orOut, arithOut, slt, xorArithOut;
wire  xorOut, sltXorNot, sltAndOut, orFinalOut;

assign slt[31:1] = 0; 
assign ex = 0; // not supported

// instantiate a circuit to set slt[0]
// Hint: about 2 lines of code 
xor sltXor (xorOut, a[31], b[31]); //If signs not equal
and xorAnd (xorAndOut, xorOut, a[31]); //slt[0] = a[31] if signs not equal
not xorNot(sltXorNot, xorOut); //Invert xor, if signs equal create 1 to subtract
yArith xorArith (xorArithOut, cout, a, b, sltXorNot); //Calculate a-b
and xorAnd2 (sltAndOut, xorArithOut[31], xorNot); //If signs equal slt[0] = res
or orFinal (orFinalOut, sltAndOut, xorAndOut);
assign slt[0] = orFinalOut;

// instantiate the components and connect them
// Hint: about 4 lines of code 
yArith arith(arithOut, cout, a, b, op[2]);
and andGate[31:0](andOut, a, b);
or orGate[31:0] (orOut, a, b);
yMux4to1 #(.SIZE(32)) muxMod(z, andOut, orOut, arithOut, slt , op[1:0]);

endmodule
