module DataMem (

                     input clk,reset,miss,hit,
                     input [11:0] Data_addr,
                     input [31:0] Wdata,
                     input  we,re,		
                     output reg [127:0] Rdata,
                     output reg ready
		                                           );
		 
		 
		 
		 
reg [7:0] memory [2**12-1:0];
reg[2:0] c_r,c_w;




 


always@(posedge clk,posedge reset) begin
  
  
  if(reset) begin
    
    c_r<= 0;
    c_w<= 0;
    ready <=0;
    
  end
  
  

 //ready <= 0;
  
 if(we && (miss || hit) && !re && !ready) begin
     

      if(c_w == 3 ) begin 
    
       memory[Data_addr+3]= Wdata[31:24];
       memory[Data_addr+2]= Wdata[23:16] ;
       memory[Data_addr+1]= Wdata[15:8] ;
       memory[Data_addr]= Wdata[7:0] ;                        
        ready <= 1;
        c_w <= 0;  
         end
      
      else  begin
             ready <= 0;
             c_w <= c_w + 1;   
        end
        
  end






else if(re && miss && !we && !ready) begin
   

  
    if(c_r == 3 ) begin 
          Rdata <= {memory[Data_addr+15], memory[Data_addr+14], memory[Data_addr+13], memory[Data_addr+12], 
                     memory[Data_addr+11], memory[Data_addr+10], memory[Data_addr+9], memory[Data_addr+8], 
                     memory[Data_addr+7], memory[Data_addr+6], memory[Data_addr+5], memory[Data_addr+4], 
                     memory[Data_addr+3], memory[Data_addr+2], memory[Data_addr+1], memory[Data_addr]};
          ready <= 1;
          c_r <= 0;
     end
     
           
    else  begin
             ready <= 0;
             c_r <= c_r + 1;   
        end
   
  end
  
  
  
  
else 
      ready <= 0;





end

   


	
	
endmodule









/* module mem_tb();
  
   
reg clk,reset,miss,hit;
reg [31:0] Data_addr;
reg [31:0] Wdata;
reg  we,re;
wire[127:0] Rdata;
wire ready;
		                                           
  
initial begin

clk =0;

  forever begin
  
    clk = #10 ~clk;
  
  end


end  



DataMem dut(.clk(clk),.reset(reset),.miss(miss),.hit(hit),.Data_addr(Data_addr),.Wdata(Wdata),.we(we),.re(re),.Rdata(Rdata),.ready(ready));




initial begin
reset = 1;
#20
reset = 0;
#20
Data_addr = 1;
we = 1;
Wdata =7;
miss = 1; 
  
 #100 
we = 0; 
Data_addr = 1;
re = 1;
miss = 1;

#100 
re = 0;
miss = 0;
Data_addr = 3;
we = 1;
Wdata =10;
hit = 1; 
  

 #100
 hit = 0; 
we = 0; 
Data_addr = 3;
re = 1;
miss = 1; 
  
  
  
end


  
  
endmodule */
