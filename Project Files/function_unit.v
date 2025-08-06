////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename: function_unit.v
// Author:	 Logan Johnson
// Created:	 13 Oct 2021
// Version:  2.0(15 Nov 2021)
// Description: The function unit should take the operands OpA, OpB from the  
// ROM in the top level entity, and the inputs SW[3:0] from the DE10-Lite board 
// to select the operation.  The outputs are the 16-bit result and 4 status bits, 
// which can be displayed on LEDs[7:0] on the DE10-Lite board.
//
//
//FS[3:0]
//0 0 0 0 A+B
//0 0 0 1 A
//0 0 1 0 A-B
//0 0 1 1 -B
//0 1 0 0 B-A
//0 1 0 1 -A
//0 1 1 0 NAND
//0 1 1 1 NOR
//1 0 0 0 A'
//1 0 0 1 MOD 8
//1 0 1 0 DEV 4
//1 0 1 1 CIR R
//1 1 0 0 CIR L
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module function_unit(FS, OpA, OpB, result, V, C, N, Z);
	input   [3:0] FS;				// Function Unit select code.
   input  [15:0] OpA;				// Function Unit operand A
   input  [15:0] OpB;				// Function Unit operand B
   output [15:0] result;		// Function Unit result
   output        V;				// Overflow status bit
   output        C;				// Carry-out status bit
   output        N;				// Negative status bit
   output        Z;				// Zero status bit
wire [15:0] resulta, resultl, results;

	arith_circuit a1 (resulta, C, V, OpA, OpB, FS);
	log l1 (resultl, OpA, OpB, FS);
	shift s1 (results, OpA, OpB, FS);
	
	// Combining all of the outputs
	assign result[0]= resulta[0] | resultl[0] | results[0];
	assign result[1]= resulta[1] | resultl[1] | results[1];
	assign result[2]= resulta[2] | resultl[2] | results[2];
	assign result[3]= resulta[3] | resultl[3] | results[3];
	assign result[4]= resulta[4] | resultl[4] | results[4];
	assign result[5]= resulta[5] | resultl[5] | results[5];
	assign result[6]= resulta[6] | resultl[6] | results[6];
	assign result[7]= resulta[7] | resultl[7] | results[7];
	//16-bits
	assign result[8]=  resulta[8]  | resultl[8]  | results[8];
	assign result[9]=  resulta[9]  | resultl[9]  | results[9];
	assign result[10]= resulta[10] | resultl[10] | results[10];
	assign result[11]= resulta[11] | resultl[11] | results[11];
	assign result[12]= resulta[12] | resultl[12] | results[12];
	assign result[13]= resulta[13] | resultl[13] | results[13];
	assign result[14]= resulta[14] | resultl[14] | results[14];
	assign result[15]= resulta[15] | resultl[15] | results[15];
	
	
	//status bits
	assign N = result[15];
	assign Z = ~( result[15] | result[14] | result[13] | result[12] | result[11] | result[10] | result[9] | result[8] | result[7] | result[6] | result[5] | result[4] | result[3] | result[2] | result[1] | result[0]);
	

endmodule



//Addition circuit 
//////////////////////////////////////////////

module arith_circuit (result, co, v, OpA, OpB, switches);
	input [3:0] switches;
	input [15:0] OpA, OpB;
	output [15:0] result;
	output v, co;
	
	wire [15:0] a, b, c, x;
	
	//mux section
		
		Mux_a_6x1 ma0 (a[0], switches, OpA[0]);
		Mux_b_6x1 mb0 (b[0], switches, OpB[0]);
		
		Mux_a_6x1 ma1 (a[1], switches, OpA[1]);
		Mux_b_6x1 mb1 (b[1], switches, OpB[1]);
		
		Mux_a_6x1 ma2 (a[2], switches, OpA[2]);
		Mux_b_6x1 mb2 (b[2], switches, OpB[2]);
		
		Mux_a_6x1 ma3 (a[3], switches, OpA[3]);
		Mux_b_6x1 mb3 (b[3], switches, OpB[3]);
		
		Mux_a_6x1 ma4 (a[4], switches, OpA[4]);
		Mux_b_6x1 mb4 (b[4], switches, OpB[4]);
		
		Mux_a_6x1 ma5 (a[5], switches, OpA[5]);
		Mux_b_6x1 mb5 (b[5], switches, OpB[5]);
		
		Mux_a_6x1 ma6 (a[6], switches, OpA[6]);
		Mux_b_6x1 mb6 (b[6], switches, OpB[6]);
		
		Mux_a_6x1 ma7 (a[7], switches, OpA[7]);
		Mux_b_6x1 mb7 (b[7], switches, OpB[7]);
		
		Mux_a_6x1 ma8 (a[8], switches, OpA[8]);
		Mux_b_6x1 mb8 (b[8], switches, OpB[8]);
		
		Mux_a_6x1 ma9 (a[9], switches, OpA[9]);
		Mux_b_6x1 mb9 (b[9], switches, OpB[9]);
		
		Mux_a_6x1 ma10 (a[10], switches, OpA[10]);
		Mux_b_6x1 mb10 (b[10], switches, OpB[10]);
		
		Mux_a_6x1 ma11 (a[11], switches, OpA[11]);
		Mux_b_6x1 mb11 (b[11], switches, OpB[11]);
			
		Mux_a_6x1 ma12 (a[12], switches, OpA[12]);
		Mux_b_6x1 mb12 (b[12], switches, OpB[12]);
		
		Mux_a_6x1 ma13 (a[13], switches, OpA[13]);
		Mux_b_6x1 mb13 (b[13], switches, OpB[13]);
		
		Mux_a_6x1 ma14 (a[14], switches, OpA[14]);
		Mux_b_6x1 mb14 (b[14], switches, OpB[14]);
		
		Mux_a_6x1 ma15 (a[15], switches, OpA[15]);
		Mux_b_6x1 mb15 (b[15], switches, OpB[15]);
		
	//addition circuit
		
		assign c[0] = (~switches[3] & ~switches[2] & switches[1]) | (~switches[3] & switches[2] & ~switches[1]);
		//first 8 bits
		full_adder a0 (result[0],  c[1], a[0], b[0], c[0]);
		full_adder a1 (result[1],  c[2], a[1], b[1], c[1]);
		full_adder a2 (result[2],  c[3], a[2], b[2], c[2]);
		full_adder a3 (result[3],  c[4], a[3], b[3], c[3]);
		full_adder a4 (result[4],  c[5], a[4], b[4], c[4]);
		full_adder a5 (result[5],  c[6], a[5], b[5], c[5]);
		full_adder a6 (result[6],  c[7], a[6], b[6], c[6]);
		full_adder a7 (result[7],  c[8],  a[7], b[7], c[7]);
		//second 8 bits
		full_adder a8  (result[8],  c[9],  a[8],  b[8],  c[8]);
		full_adder a9  (result[9],  c[10], a[9],  b[9],  c[9]);
		full_adder a10 (result[10], c[11], a[10], b[10], c[10]);
		full_adder a11 (result[11], c[12], a[11], b[11], c[11]);
		full_adder a12 (result[12], c[13], a[12], b[12], c[12]);
		full_adder a13 (result[13], c[14], a[13], b[13], c[13]);
		full_adder a14 (result[14], c[15], a[14], b[14], c[14]);
		full_adder a15 (result[15], co,    a[15], b[15], c[15]);

		
		assign v= (~OpA[15] & ~OpB[15] & result[15]) | (OpA[15] & OpB[15] & ~result[15]);
		
endmodule


// full adder design
	module full_adder (sum, cout, a, b, cin);   
		input a,b,cin;
		output sum, cout;

		assign sum = (~a&~b&cin) | (~a&b&~cin) | (a&~b&~cin) | (a&b&cin);
		assign cout= (a&b) | (a&cin) | (b&cin);

	endmodule

//MUX for A inputs
	module Mux_a_6x1 (f, sl, in);   
		input [3:0] sl;
		input in;
		output f;

		assign f= (~sl[3] & ~sl[2] & ~sl[1] & ~sl[0] & in) | (~sl[3] & ~sl[2] & ~sl[1] & sl[0] & in) | (~sl[3] & ~sl[2] & sl[1] & ~sl[0] & in)
		| (~sl[3] & sl[2] & ~sl[1] & ~sl[0] & ~in) | (~sl[3] & sl[2] & ~sl[1] & sl[0] & ~in);
	
	endmodule 	
		  
//MUX for binputs
	module Mux_b_6x1 (f, sl, in);     
		input [3:0] sl;
		input in;
		output f;

		assign f= (~sl[3] & ~sl[2] & ~sl[1] & ~sl[0] & in) | (~sl[3] & ~sl[2] & sl[1] & ~sl[0]&~in) | (~sl[3] & ~sl[2] & sl[1] & sl[0] & ~in) 
		| (~sl[3] & sl[2] & ~sl[1] & ~sl[0] & in);
	 
	endmodule 	

//////////////////////////////////////////////

//Logic section

module log (result, OpA, OpB, switches);
input [3:0] switches;
input [15:0] OpA, OpB;
output [15:0] result;
//8-bits
lmux m0 (result [0], switches, OpA[0], OpB[0]);
lmux m1 (result [1], switches, OpA[1], OpB[1]);
lmux m2 (result [2], switches, OpA[2], OpB[2]);
lmux m3 (result [3], switches, OpA[3], OpB[3]);
lmux m4 (result [4], switches, OpA[4], OpB[4]);
lmux m5 (result [5], switches, OpA[5], OpB[5]);
lmux m6 (result [6], switches, OpA[6], OpB[6]);
lmux m7 (result [7], switches, OpA[7], OpB[7]);
//16-bits
lmux m8 (result [8],  switches, OpA[8],  OpB[8]);
lmux m9 (result [9],  switches, OpA[9],  OpB[9]);
lmux m10(result [10], switches, OpA[10], OpB[10]);
lmux m11(result [11], switches, OpA[11], OpB[11]);
lmux m12(result [12], switches, OpA[12], OpB[12]);
lmux m13(result [13], switches, OpA[13], OpB[13]);
lmux m14(result [14], switches, OpA[14], OpB[14]);
lmux m15(result [15], switches, OpA[15], OpB[15]);


endmodule



module lmux (f, sl, a, b);
output f;
input [3:0] sl;
input a, b;
wire [1:0] i;

nand na (i[0], a, b);
nor  no (i[1], a, b);


assign f = (~sl[3] & sl[2] & sl[1] & ~sl[0] & i[0]) | (~sl[3] & sl[2] & sl[1] & sl[0] & i[1]) | (sl[3] & ~sl[2] & ~sl[1] & ~sl[0] & ~a);

endmodule

	
	
	
//////////////////////////////////////////////

//Shift Section

module shift (result, OpA, OpB, switches);
input [3:0] switches;
input [15:0] OpA, OpB;
output [15:0] result;

	muxs ms0 (result[0], switches, {OpB[15], OpB[1], OpB[2], OpB[0]});
	muxs ms1 (result[1], switches, {OpB[0], OpB[2], OpB[3], OpB[1]});
	muxs ms2 (result[2], switches, {OpB[1], OpB[3], OpB[4], OpB[2]});
	muxs ms3 (result[3], switches, {OpB[2], OpB[4], OpB[5], low});
	
	muxs ms4 (result[4], switches, {OpB[3], OpB[5], OpB[6], low});
	muxs ms5 (result[5], switches, {OpB[4], OpB[6], OpB[7], low});
	muxs ms6 (result[6], switches, {OpB[5], OpB[7], OpB[8], low});
	muxs ms7 (result[7], switches, {OpB[6], OpB[8], OpB[9], low});
	
	muxs ms8  (result [8], switches, {OpB[7], OpB[9], OpB[10], low});
	muxs ms9  (result [9], switches, {OpB[8], OpB[10],OpB[11], low});
	muxs ms10 (result[10], switches, {OpB[9], OpB[11], OpB[12],low});
	muxs ms11 (result[11], switches, {OpB[10], OpB[12], OpB[13],low});

	muxs ms12 (result[12], switches, {OpB[11], OpB[13], OpB[14],low});
	muxs ms13 (result[13], switches, {OpB[12], OpB[14], OpB[15],low});
	muxs ms14 (result[14], switches, {OpB[13], OpB[15], low,    low});
	muxs ms15 (result[15], switches, {OpB[14], OpB[0],  OpB[15],low});
	



endmodule


	module muxs (f, sl, in);
	output f;
	input [3:0] in, sl;

		assign f= (sl[3] & ~sl[2] & ~sl[1] & sl[0] & in[0]) | (sl[3] & ~sl[2] & sl[1] & ~sl[0] & in[1]) |  (sl[3] & ~sl[2] & sl[1] & sl[0] & in[2]) | (sl[3] & sl[2] & ~sl[1] & ~sl[0] & in[3]);



endmodule
