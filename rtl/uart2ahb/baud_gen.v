/*
 * This module is to generate baud rate clock
 * Because the clocks between AHB signal interface and UART interface are different gernerally
 * I design a module to generate baud rate clock by using input serial signals
 * The basic principle is to count the clock between two consecutive falling edges of the external data multiple times, 
 * divide the minimum value obtained by the comparison by 16 as the preset value of the self-decrement counter, 
 * and use the self-decrement counter overflow signal to obtain the divided frequency.
 */

module baud_gen
(
		input		wire						clk						,		
		input		wire						ser_in				,
		output	wire						baud_rate_clk
);

reg 				reg_1 = 0;
reg					reg_2 = 0;
reg [17:0]	reg_3 = 0;
reg [17:0]	reg_4 = 0;

reg [17:0]	overload_reg = 0;

reg [17:0]	cnt_add 	= 0;
reg [17:0]	cnt_sub 	= 0;
reg [1:0]		cnt_2_bit = 0;
reg					carry			= 0;

wire falling_edge_detect;
wire carry_o;

wire [17:0]	overload_reg_o;
wire [17:0] reg_4_o;
wire				v;
wire [17:0]	mux_o;
wire [17:0]	shift_4;

reg	[18:0]	sub_reg;

// detect falling edge
always @ (posedge clk)begin
	reg_1 <= ser_in	;
	reg_2 <= reg_1	;
end

assign falling_edge_detect = (~reg_1) & reg_2;

// 18-bit self-incrementing counter
always @(posedge clk or posedge falling_edge_detect)begin
	if(falling_edge_detect)begin
		reg_4		<= cnd_add;
		cnt_add <= 18'b0;
	end else begin
		cnt_add <= cnt_add + 1;
	end
end

assign reg_4_o = reg_4;

// subtractor
subtractor sub_inst
(
		.A(overload_reg_o),
		.B(reg_4_o),
		.V(v)
);

// 2 bit counter
always @(posedge falling_edge_detect or posedge v)begin
	if(v)begin
		cnt_2_bit <= 2'b0;
	end else if(cnt_2_bit == 2'b11)begin
		cnt_2_bit <= 2'b0;
	end else begin
		cnt_2_bit <= cnt_2_bit + 2'b01;
	end
end

always @(posedge falling_edge_detect or posedge v)begin
	if(v)begin
		carry <= 1'b0;
	end else if(cnt_2_bit == 2'b10)begin
		carry <= 1'b1;
	end else begin
		carry <= 1'b0;
	end
end

assign carry_o = carry;

// 18 bit mux
assign mux_o = v ? reg_4_o : overload_reg_o;

assign shift_4 = mux_o >> 4;

// overload register
always @(*)begin
	overload_reg = shift_4;
end

assign overload_reg_o = overload_reg;

// 18-bit down counter
always @(posedge clk)begin
	if(carry_o)begin
		reg_3 <= overload_reg_o
	end
end

always @(posedge clk)begin
	cnt_sub <= reg_3;
	if(cnt_sub == 0)begin
		cnt_sub <= reg_3;
	end else begin
		cnt_sub <= cnt_sub - 1;
	end
end

assign baud_rate_clk = (cnt_sub == 1) ? 1 : 0;

endmodule	