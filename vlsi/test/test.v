module poarta_nor(input a,b,c, output f);

assign f = ~ ( a | b | c );

endmodule

module test_poarta_nor;

wire f; // fir de iesire 
reg a,b,c; // registru variabil

poarta_nor p1 (a,b,c,f); // apelare 
initial
begin
// 000
a=0; b=0; c=0;
// 001
#5 c = 1;
// 010
#5 b = 1; c = 0;
// 011
#5 c = 1;
// 100
#5 a = 1; b= 0; c=0;
// 101
#5 c = 1;
// 110
#5 b = 1; c = 0;
// 111
#5 c = 1;
end
endmodule