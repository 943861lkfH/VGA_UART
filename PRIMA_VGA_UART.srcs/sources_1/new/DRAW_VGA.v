`timescale 1ns / 1ps

module DRAW_VGA(
  input clk,
  input [10:0] ypos,
  input [10:0] xpos,
  input [19:0] element,
  
  output reg [2:0] colors,
  output board_gfx
); 
reg [5:0] score_digit;
wire [7:0] score_bits;


initial begin
end

always @(posedge clk)
begin
case (xpos[9:4])
    5'd10: begin
        case (ypos[9:2])
        0,1,2,3:
        begin
            score_digit<=element[19:16];
            colors[2]<=0;
            colors[1]<=1;
            colors[0]<=0;
        end      
        endcase;
    end
    
    5'd12: begin
        case (ypos[9:2])
        0,1,2,3:
        begin
            score_digit<=element[15:12];
            colors[2]<=0;
            colors[1]<=1;
            colors[0]<=0;
        end
        endcase
    end
    
    5'd14: begin
        case (ypos[9:2])
        0,1,2,3:
        begin
            score_digit<=element[11:8];
            colors[2]<=0;
            colors[1]<=1;
            colors[0]<=0;
        end
        endcase
    end
    
    5'd16: begin
        case (ypos[9:2])
        0,1,2,3:
        begin
            score_digit<=element[7:4];
            colors[2]<=0;
            colors[1]<=1;
            colors[0]<=0;
        end
        endcase
    end
    
    5'd18: begin
        case (ypos[9:2])
        0,1,2,3:
        begin
            score_digit<=element[3:0];
            colors[2]<=0;
            colors[1]<=1;
            colors[0]<=0;
        end
        endcase
    end
    
    default: score_digit <= 23; // no digit
    endcase
end

DIGITS digits(.clk(clk),.digit(score_digit),.yofs(ypos[/*5:3*/3:1]),.bits(score_bits));

assign board_gfx = score_bits[xpos[3:1] ^ 3'b111];

endmodule