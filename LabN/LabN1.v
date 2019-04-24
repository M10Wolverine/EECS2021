module labN;
wire [31:0] PCin;
reg RegDst, RegWrite, clk, ALUSrc, MemRead, MemWrite, Mem2Reg, INT, isbranch, isjump;
reg [2:0] op;
reg [31:0]entryPoint, branchImm, jImm;
wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb;
wire [31:0] jTarget;
wire [31:0] branch, PC;
wire zero;

yIF myIF(ins, PC, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, branch, ins, wd, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite); 
yWB myWB(wb, z, memOut, Mem2Reg);
yPC myPC(PCin, PC, PCp4, INT, entryPoint, branchImm, jImm, zero, isbranch, isjump);
assign wd = wb;

initial
begin
	//------------------------------------Entry point
	entryPoint = 32'h28; INT =1; #1;
	//------------------------------------Run program
	repeat (43)
	begin
		//---------------------------------Fetch an ins
		clk = 1; #1; INT=0;
		//Temporary set
		isjump = 0;
		isbranch = 0;
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
			isjump=0;
			isbranch=0;
		end;
		if (ins[6:0] === 7'h6f) //UJ type JAL
		begin
			RegWrite = 1;
			ALUSrc = 1;
			MemRead=0;
			MemWrite = 0;
			Mem2Reg=0;
			isjump=1;
			isbranch=0;
		end;
		if (ins[6:0] === 7'h3 || ins[6:0] === 7'h13) //I type Load, immediates
		begin
			RegWrite = 1;
			ALUSrc = 1;
			MemRead=1;
			MemWrite=0;
			Mem2Reg=1;
			isjump=1;
			isbranch=0;
		end;
		if (ins[6:0] === 7'h23) //S type
		begin
			RegWrite = 0;
			ALUSrc = 1;
			MemRead=0;
			MemWrite=1;
			Mem2Reg=0;
			isjump=0;
			isbranch=0;
		end;
		if (ins[6:0] === 7'h63) //SB type branch
		begin
			RegWrite = 0;
			ALUSrc = 1;
			MemRead=0;
			MemWrite = 0;
			Mem2Reg=0;
			isjump=0;
			isbranch=1;
		end;

		//---------------------------------Execute the ins
		clk = 0; #1;
		//---------------------------------View results
		$display("%h: rd1:%2d rd2:%2d z:%3d zero:%b wb=%2d", ins, rd1, rd2, z, zero, wb); 
		
		//---------------------------------Prepare for the next ins
		/*if (ins[6:0] === 7'h63 && zero ===1)
			PCin=PCp4+(imm<<2);
		else if (ins[6:0] === 7'h6f)
			PCin = PCp4+(jTarget<<2);
		else
			PCin=PCp4;*/
end
$finish;
end

endmodule
