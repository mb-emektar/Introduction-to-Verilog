module design3(clk, fill, consume, error, height);
input clk, fill, consume ;
output reg error;
output reg [7:0] height;
integer amount=0, only_activate=0;

initial begin
error=1;
height=3'd000;
end

always @(posedge clk)begin

if(only_activate==0)begin

  if(amount<40)begin
  error=1;
  only_activate=1;
  amount = amount + 8;
  end
  
  else if(amount<=240 && amount>=40)begin
  error = 0;
  amount = amount + 8*fill - 4*consume; 
  only_activate = 0;
  end
 
  else if(amount>240)begin
  error = 1;
  amount = amount - 4; 
  only_activate = 1;
  end
  
  if(amount<=40) begin
  height = (amount/4)*3;
  end
  else if(amount<120 && amount>40) begin
  height = 30 + ((amount-40)/2);
  end
  else if(amount<248 && amount>=120)begin
  height = 30 + 40 + ((amount-120)/4);
   end
  end
  
else if(only_activate==1)begin
  
  if(amount<=40)begin
    if(amount>=40)begin
    error=0;
    end
  amount = amount + 8; 
  only_activate = 0;
  end
  
  else if(amount>=240)begin
    if(amount<=240)begin
    error=0;
    end
  amount = amount - 4; 
  only_activate = 0;
  end
  
  
  if(amount<=40) begin
  height = (amount/4)*3;
  end
  else if(amount<120 && amount>40) begin
  height = 30 + ((amount-40)/2);
  end
  else if(amount<248 && amount>=120)begin
  height = 30 + 40 + ((amount-120)/4);
   end
  
  end
 if(height<30||height>100)begin
  error=1;
  end
  else begin
  error=0;
  end
end

endmodule