`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 02:21:06 PM
// Design Name: 
// Module Name: ALSU_Bouns
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALSU_Bouns(clk,rst,A,B,cin,serial_in,red_op_A,red_op_B,opcode,bypass_A,
bypass_B,direction,leds,anode,cathode);
input clk,rst,cin,serial_in,red_op_A,red_op_B,bypass_A,bypass_B,direction ;
input [2:0] A,B,opcode;
output  [15:0]leds;
output reg [3:0]anode;
output [6:0]cathode;
wire [5:0]out;
parameter INPUT_PRIORITY="A";
parameter FULL_ADDER="ON";
ALSU #(.INPUT_PRIORITY(INPUT_PRIORITY),.FULL_ADDER(FULL_ADDER))
DUT(clk,rst,A,B,cin,serial_in,red_op_A,red_op_B,opcode,bypass_A,bypass_B,direction,leds,out);
wire [3:0]D1,D2,D3,D4;
reg [3:0] D;
convert C1(out,D1,D2,D3,D4);
convert_7seg C2(D,cathode);
integer counter=0;
always @(posedge clk or posedge rst) begin
    if(rst) begin
         anode<=0;
        end
     else begin
        if(counter==0)begin
            D<=D1;
            anode<=4'b0001;
            counter<=counter+1;
        end
        else if (counter==1) begin
            D<=D2;
            anode<=4'b0010;
            counter<=counter+1;
        end
        else if (counter==2) begin
            D<=D3;
            anode<=4'b0100;
            counter<=counter+1;
        end
        else if (counter==3) begin
            D<=D4;
            anode<=4'b1000;
            counter<=counter-3;
        end
    end
end
endmodule
