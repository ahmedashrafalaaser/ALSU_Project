`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 03:18:37 PM
// Design Name: 
// Module Name: convert
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


module convert(out,D1,D2,D3,D4);
input [5:0]out;
output [3:0]D1,D2,D3,D4;
assign D1=out%10;
assign D2=(out%100)/10;
assign D3=(out%1000)/100;
assign D4=out/1000;
endmodule

module convert_7seg(D,cathode);
input [3:0] D;
output reg [6:0]cathode;
always @(*)
begin
 case(D)
 4'b0000: cathode = 7'b0000001; // "0"  
 4'b0001: cathode = 7'b1001111; // "1" 
 4'b0010: cathode = 7'b0010010; // "2" 
 4'b0011: cathode = 7'b0000110; // "3" 
 4'b0100: cathode = 7'b1001100; // "4" 
 4'b0101: cathode = 7'b0100100; // "5" 
 4'b0110: cathode = 7'b0100000; // "6" 
 4'b0111: cathode = 7'b0001111; // "7" 
 4'b1000: cathode = 7'b0000000; // "8"  
 4'b1001: cathode = 7'b0000100; // "9" 
 default: cathode = 7'b0000001; // "0"
 endcase
end
endmodule