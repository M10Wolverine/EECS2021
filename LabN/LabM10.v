module labM;
reg [31:0] PCin;
reg RegDst, RegWrite, clk, ALUSrc, MemRead, MemWrite, Mem2Reg;
reg [2:0] op;
wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb;
wire [31:0] jTarget;
wire [31:0] branch;
wire zero;

yIF myIF(ins, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite); 
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;

initial
begin
	//------------------------------------Entry point
	PCin = 16'h28;
	//------------------------------------Run program
	repeat (43)
	begin
		//---------------------------------Fetch an ins
		clk = 1; #1;
		//---------------------------------Set control signals
		RegWrite = 0; ALUSrc = 1; op = 3'b010; MemRead = 0; MemWrite = 0; Mem2Reg=0;
		// Add statements to adjust the above defaults
		if (ins[6:0] === 7'h33) //R type
		begin
			RegWrite = 1;
			ALUSrc = 0;
			MemRead=0;
			MemWrite=0;
			Mem2Reg=0;
		end;
		if (ins[6:0] === 7'h6f) //UJ type
		begin
			RegWrite = 1;
			ALUSrc = 1;
			MemRead=0;
			MemWrite = 0;
			Mem2Reg=0;
		end;
		if (ins[6:0] === 7'h3 || ins[6:0] === 7'h13) //I type
		begin
			RegWrite = 1;
			ALUSrc = 1;
			MemRead=1;
			MemWrite=0;
			Mem2Reg=1;
		end;
		if (ins[6:0] === 7'h23) //S type
		begin
			RegWrite = 0;
			ALUSrc = 1;
			MemRead=0;
			MemWrite=1;
			Mem2Reg=0;
		end;
		if (ins[6:0] === 7'h63) //SB type
		begin
			RegWrite = 0;
			ALUSrc = 1;
			MemRead=0;
			MemWrite = 0;
			Mem2Reg=0;
		end;

		//---------------------------------Execute the ins
		clk = 0; #1;
		//---------------------------------View results
		$display("%h: rd1:%2d rd2:%2d z:%3d zero:%b wb=%2d", ins, rd1, rd2, z, zero, wb); 
		
		//---------------------------------Prepare for the next ins
		if (ins[6:0] === 7'h63 && zero ===1)
			PCin=PCp4+(imm<<2);
		else if (ins[6:0] === 7'h6f)
			PCin = PCp4+(jTarget<<2);
		else
			PCin=PCp4;
end
$finish;
end

endmodule
