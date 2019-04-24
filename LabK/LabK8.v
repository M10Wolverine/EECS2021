module labK;
reg a, b, c, flag, expect;
wire z;
integer i, j, k;

not my_not(notOut, c);
and andOne(andOneOut, a, andOneIn);
and andTwo(andTwoOut, c, b);
or (z, orInFirst, orInSecond);
assign andOneIn = notOut;
assign orInFirst = andOneOut;
assign orInSecond = andTwoOut;

initial
begin
for (i = 0; i < 2; i = i + 1)
	begin
	for (j = 0; j < 2; j = j + 1)
		begin
		for (k=0; k<2; k = k+1)
			begin
			a = i; b = j; c=k;
			//expect = (a & ~c) | (b & c);
			if ((a === 1 && c === 0) || (b === 1 && c === 1))
				expect = 1;
			else
				expect = 0;			

			#1;
			if (expect === z)
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


