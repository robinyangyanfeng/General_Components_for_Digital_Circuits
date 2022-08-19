/*
 * Half adder
 */
 
module half_adder(A,B,S,C);

input			wire	A;
input			wire	B;
output		wire	S;
output		wire	C;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;

assign C = SYNTHESIZED_WIRE_0;

assign SYNTHESIZED_WIRE_1 = B | A;

assign SYNTHESIZED_WIRE_0 = A & B;

assign SYNTHESIZED_WIRE_2 = ~SYNTHESIZED_WIRE_0;

assign S = SYNTHESIZED_WIRE_1 & SYNTHESIZED_WIRE_2;

endmodule