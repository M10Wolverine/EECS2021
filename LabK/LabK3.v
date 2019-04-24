module labK;
reg a, b; // reg without size means 1-bit
//wire tmp, z;

//not my_not(tmp, b);
//and my_and(z, a, tmp);

wire notOutput, lowerInput, tmp, z;

not my_not(notOutput, b);
and my_and(z, a, lowerInput);
assign lowerInput = notOutput;


initial
begin
	a = 1; b = 1;
	#1 $display("a=%b b=%b z=%b", a, b, z);
	#1 $finish;
end

endmodule

