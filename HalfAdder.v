module HalfAdder 
  (
   A,
   B,
   sum,
   carry
   );
 
  input  A;
  input  B;
  output sum;
  output carry;
 
  assign sum   = A ^ B;  // bitwise xor
  assign carry = A & B;  // bitwise and
 
endmodule // half_adder