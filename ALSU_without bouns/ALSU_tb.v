module ALSU_tb();
reg clk,rst,cin,serial_in,red_op_A,red_op_B,bypass_A,bypass_B,direction ;
reg [2:0] A,B,opcode;
wire [15:0]leds;
wire [5:0]out;
parameter INPUT_PRIORITY="A";
parameter FULL_ADDER="ON";
ALSU #(.INPUT_PRIORITY(INPUT_PRIORITY),.FULL_ADDER(FULL_ADDER)) DUT (clk,rst,A,B,cin,serial_in,red_op_A,red_op_B,opcode,bypass_A,bypass_B,direction,leds,out);

integer i=0;
initial begin
clk=0;
forever 
#2 clk=~clk;
end
initial begin
	rst=1;
	repeat(5)@(negedge clk);
	rst=0;
	repeat(5)@(negedge clk);
	bypass_A=1;
	for(i=0;i<10;i=i+1)begin
		{cin,serial_in,red_op_A,red_op_B,bypass_B,direction,opcode,A,B}=$random;
repeat(4)@(negedge clk);
	end
	repeat(5)@(negedge clk);
	bypass_B=1;
	for(i=0;i<10;i=i+1)begin
		{cin,serial_in,red_op_A,red_op_B,bypass_A,direction,opcode,A,B}=$random;
repeat(4)@(negedge clk);
	end
	repeat(5)@(negedge clk);
	bypass_B=0;
	bypass_A=0;
	for(i=0;i<10;i=i+1)begin
		{cin,serial_in,red_op_A,red_op_B,direction,opcode,A,B}=$random;
repeat(4)@(negedge clk);
	end
	repeat(5)@(negedge clk);
	red_op_A=1;
	for(i=0;i<10;i=i+1)begin
		{cin,serial_in,red_op_B,direction,opcode,A,B}=$random;
repeat(4)@(negedge clk);
	end
	repeat(5)@(negedge clk);
	red_op_B=1;
	for(i=0;i<10;i=i+1)begin
		{cin,serial_in,red_op_A,direction,opcode,A,B}=$random;
repeat(4)@(negedge clk);
	end
	repeat(5)@(negedge clk);
	red_op_A=0;
	red_op_B=0;
	for(i=0;i<100;i=i+1)begin
		{cin,serial_in,direction,opcode,A,B}=$random;
repeat(4)@(negedge clk);
	end
$stop;
end
endmodule