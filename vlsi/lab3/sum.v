//descriere functionala a semi-sumatorului
module semi_sumator(a,b,sum,cout);
input a,b;
output sum,cout;
assign sum = a^b;
assign cout= a&&b;
endmodule

module test_semi_sumator;
reg a,b;
wire sum, cout;
semi_sumator SUM1 (a,b,sum,cout);
initial begin
a=0; b=0; // 0+0 = 00
#10 b=1; // 0+1 = 01
#10 a=1; b=0; // 1+0 = 01
#10 b=1; // 1+1 = 10 -> cout = 1 sum = 0
end
endmodule
//descriere structurala a sumatorului complet
module sum_complet(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
//contruim circuitul
wire sum_s1, cout_s1, cout_s2;
semi_sumator s1 (a,b,sum_s1,cout_s1);
semi_sumator s2 (cin,sum_s1,sum,cout_s2);
or p1(cout,cout_s1,cout_s2);
endmodule

module test_sum_complet;
reg a,b,cin;
wire sum,cout;
sum_complet sum2(a,b,cin,sum,cout);
initial begin
a=0; b=0; cin=0; // 00
#10 a=1; // 1+0+0 = 01
#10 b=1; // 1+1+0=10 
#10 cin=1; // 1+1+1=3=11
end
endmodule
//descriere comportamentala a sumatorului
module sum (a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
assign {cout,sum}=a + b + cin; //{ concatenare
endmodule



module test_sum;
reg a,b,cin;
wire sum,cout;
sum sum3(a,b,cin,sum,cout);
initial begin
a=0; b=0; cin=0; // 00
#10 a=1; // 1+0+0 = 01
#10 b=1; // 1+1+0=10 
#10 cin=1; // 1+1+1=3=11
end
endmodule

module sum_parametru (a,b,cin,sum,cout);
parameter MSB=4;
input  [MSB-1:0] a,b;
input cin;
output [MSB-1:0]sum;
output cout;
assign {cout,sum}=a + b + cin; //{ concatenare
endmodule


module test_sum_parametru;
parameter MSB=4;
reg [MSB-1:0] a,b;
reg cin;
wire [MSB-1:0] sum;
wire cout;
sum_parametru sum4(a,b,cin,sum,cout);
initial begin
a=7; b=5; cin=0; // 12
#10 b=10; // 17 = 1001 cout = 1 sum= 001
end
endmodule
//descriere sumator pe 4 biti
module sum_4b (A,B,Cin,S,Cout);
input [3:0] A,B;
input Cin;
output [3:0] S;
output Cout;
//construim circuitul din 4 sumatoare
wire C0,C1,C2;
sum S0(A[0],B[0],Cin,S[0],C0);
sum S1(A[1],B[1],C0,S[1],C1);
sum S2(A[2],B[2],C1,S[2],C2);
sum S3(A[3],B[3],C2,S[3],Cout);
endmodule

module test_sum_4b;
reg [3:0] A,B;
reg Cin;
wire [3:0] S;
wire Cout;
sum_4b SUM5 (A,B,Cin,S,Cout);
initial begin
A=15; B=15; Cin=1; // 31=11111 Cout=1(16) + S=1111 15
#10 A=5; B=7; // 13 = 11001 Cout = 0 + S= 1101
end			//^Cin=1             ^Cin=1
endmodule

module sum_sub_4b (A,B,CTR,S,Cout);
input [3:0] A,B;

input CTR;
output [3:0] S;
output Cout;
//construim circuitul din 4 sumatoare
wire C0,C1,C2;
wire x0,x1,x2,x3;
assign x0 = B[0]^CTR;
assign x1 = B[1]^CTR;
assign x2 = B[2]^CTR;
assign x3 = B[3]^CTR;
sum S0(A[0],x0,CTR,S[0],C0);
sum S1(A[1],x1,C0,S[1],C1);
sum S2(A[2],x2,C1,S[2],C2);
sum S3(A[3],x3,C2,S[3],Cout);
endmodule

module test_sum_sub_4b;
reg [3:0] A,B;
reg CTR;
wire [3:0] S;
wire Cout;
sum_sub_4b SUM6 (A,B,CTR,S,Cout);
initial begin
A=13; B=15; CTR=0; 
#10 A=8; B=8; CTR=1; 
end			
endmodule
