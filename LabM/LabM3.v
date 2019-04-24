module LabM;
reg [31:0] wd;
reg [4:0] rs1, rs2, wn;
reg clk, w, flag;
wire [31:0] rd1, rd2;
integer i, j;

rf myRF(rd1, rd2, rs1, rs2, wn, wd, clk, w);

initial
begin
	flag = $value$plusargs("w=%b", w);
	for (i = 0; i < 32; i = i + 1)
	begin
		clk = 0;
		wd = i * i;
		wn = i;
		clk = 1;
		#1;
	end

	for (j=0; j<10; j=j+1)
	begin
		rs1 = $random %32;
		rs2 = $random %32;

		#2;
		$display("rs1=%d rd1=%d  rs2=%d rd2=%d", rs1, rd1, rs2, rd2);
	end

$finish;
end

endmodule
