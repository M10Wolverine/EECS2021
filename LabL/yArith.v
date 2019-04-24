module yArith(z, cout, a, b, ctrl);
// add if ctrl=0, subtract if ctrl=1
output [31:0] z;
output cout;
input [31:0] a, b;
input ctrl;
wire[31:0] notB, tmp;
wire cin;

// instantiate the components and connect them
// Hint: about 4 lines of code

	not bNot[0:31](notB, b);
	yMux #(.SIZE(32)) selector(tmp, b, notB, ctrl);
	yAdder mine(z, cout, a, tmp, ctrl);
endmodule 
