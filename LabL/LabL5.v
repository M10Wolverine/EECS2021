module labL2;

parameter SIZE = 2;
wire  z, cout;
reg a, b, cin;
reg [1:0] expect;
integer i, j, k;

yAdder1 testAdder(z, cout, a, b, cin);


initial
begin
for (i = 0; i < 2; i = i + 1)
	begin
	for (j = 0; j < 2; j = j + 1)
		begin
		for (k=0; k<2; k = k+1)
			begin
			assign a = i; assign b = j; assign cin=k;
			expect = a+b+cin;
			#1;

			if (expect[0] !== z || expect[1] !== cout)
			 	#1 $display("FAIL: cout=%b z=%b expect=%b",  cout, z, expect);
			else
			 	#1 $display("PASS: cout=%b z=%b expect=%b", cout, z, expect);
			
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


