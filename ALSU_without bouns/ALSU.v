`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2023 10:02:05 AM
// Design Name: 
// Module Name: ALSU
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


module ALSU(clk,rst,A,B,cin,serial_in,red_op_A,red_op_B,opcode,bypass_A,bypass_B,direction,leds,out);
input clk,rst,cin,serial_in,red_op_A,red_op_B,bypass_A,bypass_B,direction ;
input [2:0] A,B,opcode;
output reg [15:0]leds;
output reg [5:0]out;

parameter INPUT_PRIORITY="A";
parameter FULL_ADDER="ON";


always @(posedge clk or posedge rst) begin
	if(rst) begin
		out <= 0;
		leds<=0;
	end 
	else begin
		 if (bypass_A || bypass_B) begin
		   if (bypass_A && bypass_B) begin
		   	if (INPUT_PRIORITY=="A")
		 		begin
		 		leds<=0;
		 		out<=A;
		 		end
		 	else if (INPUT_PRIORITY=="B")
		 	begin
		 	leds<=0;
		 		out<=B;
		 		end
		   end
		   else if (bypass_A) begin
		   	leds<=0;
		 		out<=A;
		   end
		   else begin
		   	leds<=0;
		 		out<=B;
		   end
		 	
		 	
		 end
		 else begin
		 	 case (opcode)
		 	 3'b000:if (red_op_A || red_op_B) begin
		 				if (red_op_A && red_op_B) begin
		 				if (INPUT_PRIORITY=="A")		 					
		 						begin
		 						out<=&A;
		 						leds<=0;
		 						end
	
		 				else if (INPUT_PRIORITY=="B")
		 						begin
		 						leds<=0;
		 						out<=&B;
		 						end
		 				end
		 				else if(red_op_A) begin
		 					out<=&A;
		 						leds<=0;
		 				end
		 				else begin
		 					leds<=0;
		 						out<=&B;
		 				end
					end
					else 
					begin
					leds<=0;
					out<=A&B;
					end 	 
		 	 3'b001:if (red_op_A || red_op_B) begin
		 				if (red_op_A && red_op_B) begin
		 				if (INPUT_PRIORITY=="A")		 					
		 						begin
		 						out<=^A;
		 						leds<=0;
		 						end
	
		 				else if (INPUT_PRIORITY=="B")
		 						begin
		 						leds<=0;
		 						out<=^B;
		 						end
		 				end
		 				else if(red_op_A) begin
		 					out<=^A;
		 						leds<=0;
		 				end
		 				else begin
		 					leds<=0;
		 						out<=^B;
		 				end
					end
					else begin
					out<=A^B; 
					leds<=0;
					end	 
		 	 3'b010:if (red_op_A || red_op_B) begin //invalid
		 	 			out<=0;
		 	 			leds<=~leds;
		 	 		end
		 			else if (FULL_ADDER=="ON") begin
		 	 			out<=A+B+cin;
		 	 			leds<=0;	
		 	 		end
		 	 		else if (FULL_ADDER=="OFF") begin
		 	 			out<=A+B;
		 	 			leds<=0;
		 	 		end
		 	 3'b011:if (red_op_A || red_op_B) begin //invalid
		 	 			out<=0;
		 	 			leds<=~leds;
		 	 		end
		 	 		else begin
		 	 		out<=A*B;
		 	 		leds<=0;
		 	 		end
		 	 3'b100:if (red_op_A || red_op_B) begin //invalid
		 	 			out<=0;
		 	 			leds<=~leds;
		 	 		end
		 	 		else begin
		 	 		if (direction) begin
		 	 			out<={out[4:0],serial_in};
		 	 			leds<=0;
		 	 		end
		 	 		else begin
		 	 			out<={serial_in,out[5:1]};
		 	 			leds<=0;
		 	 		end
		 	 		end
		 	 3'b101:if (red_op_A || red_op_B) begin //invalid
		 	 			out<=0;
		 	 			leds<=~leds;
		 	 		end
		 	 		else begin
		 	 		if (direction) begin
		 	 			out<={out[4:0],out[5]};
		 	 			leds<=0;
		 	 		end
		 	 		else begin
		 	 			out<={out[0],out[5:1]};
		 	 			leds<=0;
		 	 		end
		 	 		end
		 	 3'b110: begin //invalid
		 	 			out<=0;
		 	 			leds<=~leds;
		 	 		end
		 	 3'b111: begin //invalid
		 	 			out<=0;
		 	 			leds<=~leds;
		 	 		end
		 	 endcase
		 end
	end
end

endmodule
