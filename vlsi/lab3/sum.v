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


