module labL1;
reg expect;
parameter SIZE = 2;
wire  z;
reg  a, b;
reg c;
integer i, j, k;

yMux1 testyMux[SIZE-1:0](z, a, b, c);


initial
begin
for (i = 0; i < 2; i = i + 1)
	begin
	for (j = 0; j < 2; j = j + 1)
		begin
		for (k=0; k<2; k = k+1)
			begin
			assign a = i; assign b = j; assign c=k;
			expect = (a&~c)|(b&c);
			#1;

			if (expect === z )
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
	*/
	$finish;
end

endmodule


