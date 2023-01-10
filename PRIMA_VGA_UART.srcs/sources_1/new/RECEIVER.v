`timescale 1ns / 1ps

module RECEIVER(input r, clk, /*clk_en,*/ output reg R_O, wire [7:0] code);

parameter	BRate = 9600,
            NEXclk = 100_000_000,
			period = NEXclk/BRate/2,
			bit0 = 3*period,
			bit1 = 5*period,
			bit2 = 7*period,
			bit3 = 9*period,
			bit4 = 11*period,
			bit5 = 13*period,
			bit6 = 15*period,
			bit7 = 17*period,
			stop = 19*period;

reg [$clog2(stop):0] state = 0;
reg [7:0] received_data;

assign code = received_data;

initial
begin
    received_data <= 8'b0;
    R_O <= 0;
end

always @(posedge clk) 
begin
//if (clk_en)

    if (state == 0)
    begin
        R_O <= 0;
        state <= state + 1;
    end
    else if(state <= period)
    begin
        R_O <= 0;
        if (~r) state <= state + 1;
    end
    else
	case (state)
		bit0: 
		begin
			received_data[0] <= r;
			state <= state + 1;
		end
		bit1: 
		begin
			received_data[1] <= r;
			state <= state + 1;
		end
		bit2: 
		begin
			received_data[2] <= r;
			state <= state + 1;
		end
		bit3: 
		begin
			received_data[3] <= r;
			state <= state + 1;
		end
		bit4: 
		begin
			received_data[4] <= r;
			state <= state + 1;
		end
		bit5: 
		begin
			received_data[5] <= r;
			state <= state + 1;
		end
		bit6: 
		begin
			received_data[6] <= r;
			state <= state + 1;
		end
		bit7: 
		begin
			received_data[7] <= r;
			state <= state + 1;
		end
		stop:
		begin
            R_O <= 1;
            state <= 0;
        end
		default: state <= state + 1;
	endcase
end

endmodule