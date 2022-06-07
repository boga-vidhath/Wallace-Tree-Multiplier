
module WallaceTreeMult(
    input [4:0] A,
    input [4:0] B,
    output [9:0] Out
    );
    
    
    
    wire HA1_sum,HA2_sum,FA1_sum,FA2_sum,FA3_sum,FA4_sum;
    wire HA1_carry,HA2_carry,FA1_carry,FA2_carry,FA3_carry,FA4_carry;
    //Step-1
    HalfAdder HA1 (A[2]&B[0], A[1]&B[1], HA1_sum, HA1_carry);
    FullAdder FA1 (A[3]&B[0],A[2]&B[1],A[1]&B[2], FA1_sum, FA1_carry);
    FullAdder FA2 (A[4]&B[0],A[3]&B[1],A[2]&B[2], FA2_sum, FA2_carry);
    HalfAdder HA2 (A[1]&B[3],A[0]&B[4],HA2_sum,HA2_carry);
    FullAdder FA3 (A[1]&B[4],A[4]&B[1],A[3]&B[2], FA3_sum,FA3_carry);
    FullAdder FA4 (A[2]&B[4], A[3]&B[3], A[4]&B[2], FA4_sum, FA4_carry);   
    
    //Step-2
    wire HA_2_1_sum,FA_2_1_sum,FA_2_2_sum,HA_2_2_sum,FA_2_3_sum;
    wire HA_2_1_carry,FA_2_1_carry,FA_2_2_carry,HA_2_2_carry,FA_2_3_carry;
    
    HalfAdder HA_2_1 (FA1_sum,HA1_carry,HA_2_1_sum,HA_2_1_carry);//Checked
    FullAdder FA_2_1 (FA1_carry,FA2_sum,HA2_sum,FA_2_1_sum,FA_2_1_carry);//Checked
    FullAdder FA_2_2 (FA3_sum,FA2_carry,HA2_carry,FA_2_2_sum,FA_2_2_carry);//Checked    
    HalfAdder HA_2_2 (FA4_sum,FA3_carry,HA_2_2_sum,HA_2_2_carry);//Checked
    FullAdder FA_2_3 (A[3]&B[4],A[4]&B[3],FA4_carry,FA_2_3_sum,FA_2_3_carry);//Checked
    
    
    //Step-3
    wire HA_3_1_sum, HA_3_2_sum, HA_3_3_sum, HA_3_4_sum;
    wire HA_3_1_carry, HA_3_2_carry, HA_3_3_carry, HA_3_4_carry;
    HalfAdder HA_3_1 (FA_2_2_sum,FA_2_1_carry,HA_3_1_sum,HA_3_1_carry);
    HalfAdder HA_3_2 (HA_2_2_sum,FA_2_2_carry,HA_3_2_sum,HA_3_2_carry);
    HalfAdder HA_3_3 (FA_2_3_sum,HA_2_2_carry,HA_3_3_sum,HA_3_3_carry);
    HalfAdder HA_3_4 (A[4]&B[4],FA_2_3_carry,HA_3_4_sum,HA_3_4_carry);
    //Step-4 Final Addition Stage
    wire [9:0] arg1 = {1'b0,HA_3_4_sum,HA_3_3_sum,HA_3_2_sum,HA_3_1_sum,FA_2_1_sum,HA_2_1_sum,HA1_sum,A[1]&B[0],A[0]&B[0]};
    wire [9:0] arg2 = {HA_3_4_carry,HA_3_3_carry,HA_3_2_carry,HA_3_1_carry,A[2]&B[3],HA_2_1_carry,A[0]&B[3],A[0]&B[2],A[0]&B[1],1'b0};
    assign Out = arg1 + arg2;
    
    
endmodule
