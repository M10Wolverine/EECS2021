module labL6;

parameter SIZE = 32;
wire signed [31:0] z;
wire signed cout;
reg signed [31:0] a, b;
reg cin;
reg signed [31:0] expect;
reg ok;
integer i, j, k;


yAdder testAdder(z, cout, a, b, cin);


initial
repeat (15)
begin

a = $random;
b = $random;

cin = 0;
#1;
	expect = a+b+cin;
#1;

if (expect !== z)
	#1 $display("Fail: z=%d %b expect=%b", z,  z, expect);
else
	#1 $display("Pass: z=%d %b expect=%b", z,  z, expect);


/*
for (i = 0; i < 8; i = i + 1)
	begin
	for (j = 0; j < 8; j = j + 1)
		begin
		for (k=0; k<2; k = k+1)
			begin
			assign a = i; assign b = j; assign c=k;
			//expect[SIZE-31:0] = (a&~c)|(b&c);
			expect[0] = (a[0]&~c)|(b[0]&c);
			expect[1] = (a[1]&~c)|(b[1]&c);
			expect[2] = (a[2]&~c)|(b[2]&c);
			#1;

			if (expect[0] === z[0] && expect[1] === z[1]&& expect[2] === z[2])
			 	#1 $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
			else
			 	#1 $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
			
			end
	 	 end


	 end

	//a = 1; b = 0; c = 0;
	/*flag = $value$plusargs("a=%b", a);
	flag = $value$plusargs("b=%b", b);
	flag = $value$plusargs("c=%b", c);
	if (flag === "x")
		$display("argument missing");
		//$finish;
 	#1 $display("a=%b b=%b c=%b z=%b", a, b, c, z);
	
	$finish;*/
end

endmodule


