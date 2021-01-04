`timescale 1ns/1ps
`include "iob_lib.vh"

module knn_core
  #(
    parameter DATA_W = 32
    )
   (
    `INPUT(KNN_ENABLE, 1),    
    `INPUT(clk, 1),
    `INPUT(rst, 1),
    `INPUT(Ax, 16),
    `INPUT(Ay, 16),
    `INPUT(Bx, 16),
    `INPUT(By, 16),
    `INPUT(label,8),
    `INPUT(writereg, 1),
    `INPUT(acesso, 4),
    `OUTPUT(Out, 80),
    `OUTPUT(Dist, 32),
    `OUTPUT(Out2, 32)
    );
   
    `SIGNAL_SIGNED(Dx, 16)
    `SIGNAL_SIGNED(Dy, 16)
    `SIGNAL(D1, 32)
    `SIGNAL(D2, 32)
    `SIGNAL(D,  32)
   
    `SIGNAL(smaller1, 1)
    `SIGNAL(smaller2, 1)
    `SIGNAL(smaller3, 1)
    `SIGNAL(smaller4, 1)
    `SIGNAL(smaller5, 1)
    `SIGNAL(smaller6, 1)
    `SIGNAL(smaller7, 1)
    `SIGNAL(smaller8, 1)
    `SIGNAL(smaller9, 1)
    `SIGNAL(smaller10, 1)

    `SIGNAL(MUX1, 1)
    `SIGNAL(MUX2, 1)
    `SIGNAL(MUX3, 1)
    `SIGNAL(MUX4, 1)
    `SIGNAL(MUX5, 1)
    `SIGNAL(MUX6, 1)
    `SIGNAL(MUX7, 1)
    `SIGNAL(MUX8, 1)
    `SIGNAL(MUX9, 1)
    `SIGNAL(MUX10, 1)
   
    `SIGNAL(Reg_in, 40)
    `SIGNAL(Reg_in2, 40)
    `SIGNAL(Reg_in3, 40)
    `SIGNAL(Reg_in4, 40)
    `SIGNAL(Reg_in5, 40)
    `SIGNAL(Reg_in6, 40)
    `SIGNAL(Reg_in7, 40)
    `SIGNAL(Reg_in8, 40)
    `SIGNAL(Reg_in9, 40)
    `SIGNAL(Reg_in10, 40)
   
    `SIGNAL(Reg_out1, 40)
    `SIGNAL(Reg_out2, 40)
    `SIGNAL(Reg_out3, 40)
    `SIGNAL(Reg_out4, 40)
    `SIGNAL(Reg_out5, 40)
    `SIGNAL(Reg_out6,40)
    `SIGNAL(Reg_out7,40)
    `SIGNAL(Reg_out8,40)
    `SIGNAL(Reg_out9, 40)
    `SIGNAL(Reg_out10,40)
   
   
  `COMB Dx=Ax-Bx;
  `COMB Dy=Ay-By;
  `COMB D1=Dx*Dx;
  `COMB D2=Dy*Dy;
  `COMB D=D1+D2;
  `SIGNAL2OUT(Dist, D)
   assign  Reg_in={label, D};
   
   always @* begin
    if(D<Reg_out1[31:0]) begin
       MUX2=0;
       MUX3=0;
       MUX4=0;
       MUX5=0;
       MUX6=0;
       MUX7=0;
       MUX8=0;
       MUX9=0;
       MUX10=0;
       smaller1=1;
       smaller2=1;
       smaller3=1;
       smaller4=1;
       smaller5=1;
       smaller6=1;
       smaller7=1;
       smaller8=1;
       smaller9=1;
       smaller10=1;
   end else if(D<Reg_out2[31:0]) begin
       MUX2=1;
       MUX3=0;
       MUX4=0;
       MUX5=0;
       MUX6=0;
       MUX7=0;
       MUX8=0;
       MUX9=0;
       MUX10=0;
       smaller1=0;
       smaller2=1;
       smaller3=1;
       smaller4=1;
       smaller5=1;
       smaller6=1;
       smaller7=1;
       smaller8=1;
       smaller9=1;
       smaller10=1;
   end else if(D<Reg_out3[31:0]) begin 
       MUX2=0;
       MUX3=1;
       MUX4=0;
       MUX5=0;
       MUX6=0;
       MUX7=0;
       MUX8=0;
       MUX9=0;
       MUX10=0;
       smaller1=0;
       smaller2=0;
       smaller3=1;
       smaller4=1;
       smaller5=1;
       smaller6=1;
       smaller7=1;
       smaller8=1;
       smaller9=1;
       smaller10=1;
   end else if(D<Reg_out4[31:0]) begin
       MUX2=0;
       MUX3=0;
       MUX4=1;
       MUX5=0;
       MUX6=0;
       MUX7=0;
       MUX8=0;
       MUX9=0;
       MUX10=0;
       smaller1=0;
       smaller2=0;
       smaller3=0;
       smaller4=1;
       smaller5=1;
       smaller6=1;
       smaller7=1;
       smaller8=1;
       smaller9=1;
       smaller10=1;
   end else if(D<Reg_out5[31:0]) begin
       MUX2=0;
       MUX3=0;
       MUX4=0;
       MUX5=1;
       MUX6=0;
       MUX7=0;
       MUX8=0;
       MUX9=0;
       MUX10=0;
       smaller1=0;
       smaller2=0;
       smaller3=0;
       smaller4=0;
       smaller5=1;
       smaller6=1;
       smaller7=1;
       smaller8=1;
       smaller9=1;
       smaller10=1;
      end else if(D<Reg_out6[31:0]) begin
       MUX2=0;
       MUX3=0;
       MUX4=0;
       MUX5=0;
       MUX6=1;
       MUX7=0;
       MUX8=0;
       MUX9=0;
       MUX10=0;
       smaller1=0;
       smaller2=0;
       smaller3=0;
       smaller4=0;
       smaller5=0;
       smaller6=1;
       smaller7=1;
       smaller8=1;
       smaller9=1;
       smaller10=1;
	 end else if(D<Reg_out7[31:0]) begin
       MUX2=0;
       MUX3=0;
       MUX4=0;
       MUX5=0;
       MUX6=0;
       MUX7=1;
       MUX8=0;
       MUX9=0;
       MUX10=0;
       smaller1=0;
       smaller2=0;
       smaller3=0;
       smaller4=0;
       smaller5=0;
       smaller6=0;
       smaller7=1;
       smaller8=1;
       smaller9=1;
       smaller10=1;
	    end else if(D<Reg_out8[31:0]) begin
       MUX2=0;
       MUX3=0;
       MUX4=0;
       MUX5=0;
       MUX6=0;
       MUX7=0;
       MUX8=1;
       MUX9=0;
       MUX10=0;
       smaller1=0;
       smaller2=0;
       smaller3=0;
       smaller4=0;
       smaller5=0;
       smaller6=0;
       smaller7=0;
       smaller8=1;
       smaller9=1;
       smaller10=1;
	       end else if(D<Reg_out9[31:0]) begin
       MUX2=0;
       MUX3=0;
       MUX4=0;
       MUX5=0;
       MUX6=0;
       MUX7=0;
       MUX8=0;
       MUX9=1;
       MUX10=0;
       smaller1=0;
       smaller2=0;
       smaller3=0;
       smaller4=0;
       smaller5=0;
       smaller6=0;
       smaller7=0;
       smaller8=0;
       smaller9=1;
       smaller10=1;
	end else if(D<Reg_out10[31:0]) begin
       MUX2=0;
       MUX3=0;
       MUX4=0;
       MUX5=0;
       MUX6=0;
       MUX7=0;
       MUX8=0;
       MUX9=0;
       MUX10=1;
       smaller1=1;
       smaller2=0;
       smaller3=0;
       smaller4=0;
       smaller5=0;
       smaller6=0;
       smaller7=0;
       smaller8=0;
       smaller9=0;
       smaller10=1;	  
	end else begin
       MUX2=0;
       MUX3=0;
       MUX4=0;
       MUX5=0;
       MUX6=0;
       MUX7=0;
       MUX8=0;
       MUX9=0;
       MUX10=0;
       smaller1=0;
       smaller2=0;
       smaller3=0;
       smaller4=0;
       smaller5=0;
       smaller6=0;
       smaller7=0;
       smaller8=0;
       smaller9=0;
       smaller10=0;
	end
   end // always @ *

   
always @ (Reg_out1 or Reg_in or MUX2) begin  
      case (MUX2)  
         1'b0 : Reg_in2 <= Reg_out1;  
         1'b1 : Reg_in2 <= Reg_in;   
      endcase  
end
always @ (Reg_out2 or Reg_in or MUX3) begin  
      case (MUX3)  
         1'b0 : Reg_in3 <= Reg_out2;  
         1'b1 : Reg_in3 <= Reg_in;   
      endcase  
end
always @ (Reg_out3 or Reg_in or MUX4) begin  
      case (MUX4)  
         1'b0 : Reg_in4 <= Reg_out3;  
         1'b1 : Reg_in4 <= Reg_in;   
      endcase  
end
   always @ (Reg_out4 or Reg_in or MUX5) begin  
      case (MUX5)  
         1'b0 : Reg_in5 <= Reg_out4;  
         1'b1 : Reg_in5 <= Reg_in;   
      endcase  
   end
   always @ (Reg_out5 or Reg_in or MUX6) begin  
      case (MUX6)  
         1'b0 : Reg_in6 <= Reg_out5;  
         1'b1 : Reg_in6 <= Reg_in;   
      endcase  
   end
   always @ (Reg_out6 or Reg_in or MUX7) begin  
      case (MUX7)  
         1'b0 : Reg_in7 <= Reg_out6;  
         1'b1 : Reg_in7 <= Reg_in;   
      endcase  
   end
   always @ (Reg_out7 or Reg_in or MUX8) begin  
      case (MUX8)  
         1'b0 : Reg_in8 <= Reg_out7;  
         1'b1 : Reg_in8 <= Reg_in;   
      endcase  
   end
   always @ (Reg_out8 or Reg_in or MUX9) begin  
      case (MUX9)  
         1'b0 : Reg_in9 <= Reg_out8;  
         1'b1 : Reg_in9 <= Reg_in;   
      endcase  
   end
   always @ (Reg_out9 or Reg_in or MUX10) begin  
      case (MUX10)  
         1'b0 : Reg_in10 <= Reg_out9;  
         1'b1 : Reg_in10 <= Reg_in;   
      endcase  
end
 `SIGNAL(fon, 32)
   assign fon=123;
   
   
   
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller1, Reg_out1, Reg_in)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller2, Reg_out2, Reg_in2)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller3, Reg_out3, fon)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller4, Reg_out4, Reg_in4)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller5, Reg_out5, fon)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller6, Reg_out6, Reg_in6)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller7, Reg_out7, Reg_in7)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller8, Reg_out8, Reg_in8)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller9, Reg_out9, Reg_in9)
  `REG_ARE(clk, rst, 32'b11111111111111111111111111111111, writereg && smaller10, Reg_out10, Reg_in10)
   
  `SIGNAL(Output, 80)
   assign Output={Reg_out10[39:32], Reg_out9[39:32], Reg_out8[39:32], Reg_out7[39:32], Reg_out6[39:32], Reg_out5[39:32], Reg_out4[39:32], Reg_out3[39:32], Reg_out2[39:32], Reg_out1[39:32]};
   `SIGNAL2OUT(Out, Output)


always @ (Reg_in or Reg_out1 or acesso) begin  
      case (acesso)  
        4'b0000 : Output2<=Reg_out1[31:0];
	4'b0001 : Output2<=Reg_out2[31:0];
	4'b0010 : Output2<=Reg_out3[31:0];
	4'b0011 : Output2<=Reg_out4[31:0];
	4'b0100 : Output2<=Reg_out5[31:0];
	4'b0101 : Output2<=Reg_out6[31:0];
	4'b0110 : Output2<=Reg_out7[31:0];
	4'b0111 : Output2<=Reg_out8[31:0];  
	4'b1000 : Output2<=Reg_out9[31:0];
	4'b1001 : Output2<=Reg_out10[31:0];
	4'b1010 : Output2<=Reg_out3[31:0];
	4'b1011 : Output2<=Reg_out4[31:0];
	4'b1100 : Output2<=Reg_out5[31:0];
	4'b1101 : Output2<=Reg_out6[31:0];
	4'b1110 : Output2<=Reg_out7[31:0];
	4'b1111 : Output2<=Reg_out8[31:0]; 
      endcase  
end // always @ (Reg_in or Reg_out1 or MUX10)
   `SIGNAL(Output2, 32)
   `SIGNAL2OUT(Out2, Output2)

   
endmodule

