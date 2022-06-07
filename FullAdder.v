module FullAdder (input a, b, c, output sum, cout);
  wire w1, w2, w3;

  HalfAdder HA1 (a, b, w2, w1);
  HalfAdder HA2 (w2, c, sum, w3);
  assign cout = w1 | w3; 

endmodule
