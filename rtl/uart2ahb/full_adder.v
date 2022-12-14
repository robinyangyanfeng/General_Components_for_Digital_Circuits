/*
 * Full adder
 */
 
module full_adder(A,B,X,S,C);

input		wire			A;
input		wire			B;
input		wire			X;
output	wire			S;
output	wire			C;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;

half_adder half_adder_inst_0(
		.A(A),
		.B(B),
		.S(SYNTHESIZED_WIRE_0),
		.C(SYNTHESIZED_WIRE_2)
);

half_adder half_adder_inst_1(
		.A(A),
		.B(B),
		.S(S),
		.C(SYNTHESIZED_WIRE_1)		
);

assign C = SYNTHESIZED_WIRE_1 | SYNTHESIZED_WIRE_2;

endmodule