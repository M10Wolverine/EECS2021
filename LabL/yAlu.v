module yAlu(z, ex, a, b, op);
input [31:0] a, b;
input [2:0] op;
output [31:0] z;
output ex;
wire [31:0] andOut, orOut, arithOut, slt, xorArithOut, tmp;

wire [15:0] z16;
wire [7:0] z8;
wire [3:0] z4;
wire [1:0] z2;
wire z1, z0;

assign slt[31:1] = 0; 
assign ex = 0; // not supported

or or16[15:0] (z16, z[15: 0], z[31:16]);
or or8[7:0] (z8, z16[7: 0], z16[15:8]);
or or4[3:0] (z4, z8[3: 0], z8[7:4]);
or or2[1:0] (z2, z4[1:0], z4[3:2]);
or or1[15:0] (z1, z2[1], z2[0]);
not m_not (z0, z1);
assign ex = z0;


assign sltCtrl =1;
// instantiate a circuit to set slt[0]
// Hint: about 2 lines of code 
xor sltXor (condition, a[31], b[31]);
yArith sltArith (tmp, cout, a, b, sltCtrl);
yMux #(.SIZE(1)) sltMux(slt[0], tmp[31], a[31], condition);

// instantiate the components and connect them
// Hint: about 4 lines of code 
yArith arith(arithOut, cout, a, b, op[2]);
and andGate[31:0](andOut, a, b);
or orGate[31:0] (orOut, a, b);
yMux4to1 #(.SIZE(32)) muxMod(z, andOut, orOut, arithOut, slt , op[1:0]);

endmodule
