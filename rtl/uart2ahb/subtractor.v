/*
 * 18 bit subtractor
 * The module provides overflow signal as reset signal for another counter
 */

module subtractor 
(
	input		wire [17:0]	A,
	input		wire [17:0]	B,
	output	wire 				V
);

wire 	[17:0] C;

reg		SUB = 1;

reg		U = 1;

full_adder full_adder_inst_0(
    .A(A[0]), .B(B[0]^SUB), .X(SUB),
    .S(S[0]), .C(C[0])
);

full_adder full_adder_inst_1(
    .A(A[1]), .B(B[1]^SUB), .X(C[0]),
    .S(S[1]), .C(C[1])
);

full_adder full_adder_inst_2(
    .A(A[2]), .B(B[2]^SUB), .X(C[1]),
    .S(S[2]), .C(C[2])
);
  
full_adder full_adder_inst_3(
    .A(A[3]), .B(B[3]^SUB), .X(C[2]),
    .S(S[3]), .C(C[3])
);

full_adder full_adder_inst_4(
    .A(A[4]), .B(B[4]^SUB), .X(C[3]),
    .S(S[4]), .C(C[4])
);

full_adder full_adder_inst_5(
    .A(A[5]), .B(B[5]^SUB), .X(C[4]),
    .S(S[5]), .C(C[5])
);

full_adder full_adder_inst_6(
    .A(A[6]), .B(B[6]^SUB), .X(C[5]),
    .S(S[6]), .C(C[6])
);

full_adder full_adder_inst_7(
    .A(A[7]), .B(B[7]^SUB), .X(C[6]),
    .S(S[7]), .C(C[7])
);

full_adder full_adder_inst_8(
    .A(A[8]), .B(B[8]^SUB), .X(C[7]),
    .S(S[8]), .C(C[8])
);

full_adder full_adder_inst_9(
    .A(A[9]), .B(B[9]^SUB), .X(C[8]),
    .S(S[9]), .C(C[9])
);

full_adder full_adder_inst_10(
    .A(A[10]), .B(B[10]^SUB), .X(C[9]),
    .S(S[10]), .C(C[10])
);

full_adder full_adder_inst_11(
    .A(A[11]), .B(B[11]^SUB), .X(C[10]),
    .S(S[11]), .C(C[11])
);

full_adder full_adder_inst_12(
    .A(A[12]), .B(B[12]^SUB), .X(C[11]),
    .S(S[12]), .C(C[12])
);

full_adder full_adder_inst_13(
    .A(A[13]), .B(B[13]^SUB), .X(C[12]),
    .S(S[13]), .C(C[13])
);

full_adder full_adder_inst_14(
    .A(A[14]), .B(B[14]^SUB), .X(C[13]),
    .S(S[14]), .C(C[14])
);

full_adder full_adder_inst_15(
    .A(A[15]), .B(B[15]^SUB), .X(C[14]),
    .S(S[15]), .C(C[15])
);

full_adder full_adder_inst_16(
    .A(A[16]), .B(B[16]^SUB), .X(C[15]),
    .S(S[16]), .C(C[16])
);

full_adder full_adder_inst_17(
    .A(A[17]), .B(B[17]^SUB), .X(C[16]),
    .S(S[17]), .C(C[17])
);

  assign V = (~U & ~SUB & ~A[17] & ~B[17] &  S[17])
           | (~U & ~SUB &  A[17] &  B[17] & ~S[17])
           | (~U &  SUB & ~A[17] &  B[17] &  S[17])
           | (~U &  SUB &  A[17] & ~B[17] & ~S[17])
           | ( U & ~SUB &  C[17])
           | ( U &  SUB & ~C[3]);
endmodule
