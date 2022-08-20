/*
 * This UART transfer module
 */

module uart_tx #
(
		parameter		DATA_WIDTH = 8
)
(
		input		wire					clk		,
		input		wire					rst_n	,
		
		/*
		 * Internal signal input
		 */
		input		wire [DATA_WIDTH-1:0]	int_sig_in,
		input		wire									tx_valid	,
		
		/*
		 * Uart interface
		 */
		output	wire					ser_out,
		
		/*
		 * Status
		 */
		output	wire					busy
);

parameter IDLE = 2'b00;
parameter DATA = 2'b01;
parameter STOP = 2'b10;

reg [7:0] keep_reg	= 0	;
reg [9:0] shift_reg	= 0	;
reg				txd				= 0	;
reg				busy_reg	= 0	;

reg [3:0] cnt = 0;
wire			cnt_flg;

reg [1:0] c_state;
reg [1:0] n_state;

always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt <= 0;
	end else begin
		if(c_state == DATA)begin
			cnt <= cnt + 1;
			if(cnt == 10)begin
				cnt <= 0;
			end
		end else begin
			cnt <= 0;
		end
	end		
end

assign cnt_flg = (c_state == DATA) & (cnt == 10);

always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		c_state <= IDLE;
	end else begin
		c_state <= n_state;
	end
end

always @(posedge clk or negedge rst_n)begin
	case(c_state)
		IDLE:begin
				if(keep_reg == 0)begin
					n_state <= IDLE;
				end else begin
					if(tx_valid)begin
						keep_reg 	<= int_sig_in			;
						shift_reg	<= {1,keep_reg,0}	;
						n_state 	<= DATA						;
					end else begin
						n_state <= IDLE;
					end
				end
		end
		DATA:begin
				txd			 	<= shift_reg[0];
				shift_reg	<= {shift_reg[0],shift_reg[9:1]};
				if(cnt_flg)begin
					n_state	<= STOP;
				end else begin
					n_state 	<= DATA	;
					busy_reg	<= 1		;
				end
		end
		STOP:begin
				shift_reg <= 10'b11_1111_1111;
				txd				<= shift_reg[0];
				shift_reg	<= {shift_reg[0],shift_reg[9:1]};
				busy_reg	<= 0;
				n_state		<= IDLE;
		end
	endcase
end

assign ser_out 	= txd			;
assign busy			= busy_reg;

endmodule