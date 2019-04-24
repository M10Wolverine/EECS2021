module labK;
reg a, b, c, flag;
wire z;
integer i, j;

not my_not(notOut, b);
and andOne(andOneOut, a, andOneIn);
and andTwo(andTwoOut, c, b);
or (z, orInFirst, orInSecond);
assign andOneIn = notOut;
assign orInFirst = andOneOut;
assign orInSecond = andTwoOut;

initial
begin
	/* for (i = 0; i < 2; i = i + 1)
	 begin
		 for (j = 0; j < 2; j = j + 1)
		 begin
			a = i; b = j;

		 	#1 $display("a=%b b=%b z=%b", a, b, z);
	 	 end


	 end*/

	//a = 1; b = 0; c = 0;

	flag = $value$plusargs("a=%b", a);
	if ( flag !== 1)
		begin
		$display("argument 'a'  missing");
		$finish;
		end
	flag = $value$plusargs("b=%b", b);
	if (flag !== 1)
		begin
		$display("argument 'b'  missing");
		$finish;
		end
	flag = $value$plusargs("c=%b", c);
	if (flag !== 1)
		begin
		$display("argument 'c' missing");
		$finish;
	end
 	#1 $display("a=%b b=%b c=%b z=%b", a, b, c, z);

	$finish;
end

endmodule


