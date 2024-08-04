module Cache_Memory (addr,mem_block,mem_read,mem_write,data_in,data_out,fill,miss,hit);
  
  
  
  parameter line_size = 128;
  parameter lines = 32;
  parameter word = 2;
  
    
  input fill,miss,hit;
  input[6:0] addr;
  input[127:0] mem_block;
  input[31:0] data_in;
  input mem_read,mem_write;
  output reg[31:0] data_out;
  
  
  reg[line_size-1:0] cache_mem [lines-1:0];

  
  
  
  
  
  
  
  always@(*) begin
    
 
    if(mem_read && !miss && hit) begin
      
         
         //data_out = cache_mem[addr[6:2]] >> (addr[1:0] * 32);
          if(addr[1:0] == 2'b00) 
              data_out = cache_mem[addr[6:2]][31:0]; 
                 
          else if (addr[1:0] == 2'b01) 
              data_out = cache_mem[addr[6:2]][63:32];
              
          else if (addr[1:0] == 2'b10) 
              data_out = cache_mem[addr[6:2]][95:64];              

          else  
              data_out = cache_mem[addr[6:2]][127:96];    

                          
    end
    
   
   
    
    if(mem_write && !miss) begin
      
         if(addr[1:0] == 2'b00) 
             cache_mem[addr[6:2]][31:0] = data_in; 
                 
          else if (addr[1:0] == 2'b01) 
              cache_mem[addr[6:2]][63:32] = data_in;
              
          else if (addr[1:0] == 2'b10) 
              cache_mem[addr[6:2]][95:64]  = data_in;              

          else if (addr[1:0] == 2'b11) 
              cache_mem[addr[6:2]][127:96]  = data_in;   
         
          else
               cache_mem[addr[6:2]] =  cache_mem[addr[6:2]];
    end
     
     
  else if (fill) begin
    
          cache_mem[addr[6:2]] = mem_block; 
          
          if(addr[1:0] == 2'b00) 
              data_out = mem_block[31:0]; 
                 
          else if (addr[1:0] == 2'b01) 
              data_out = mem_block[63:32];
              
          else if (addr[1:0] == 2'b10) 
              data_out = mem_block[95:64];              

          else 
              data_out = mem_block[127:96];    
                 
    end          
     
    
  end
  
  
  
         
           

  
  
  
  
  
  
  
  
  
endmodule







/* module test_bench();
  
  reg fill;
  reg[9:0] addr;
  reg[127:0] mem_block;
  reg[31:0] data_in;
  reg mem_read,mem_write;
  reg miss;
  wire[31:0] data_out; 
  
  
  Cache_Memory dut (.fill(fill),.addr(addr),.mem_block(mem_block),.data_in(data_in),.mem_read(mem_read),.mem_write(mem_write),.miss(miss),.data_out(data_out));
  
  
  

  
  
  
  
  
  
  initial begin
    
  
    
    #100
    fill = 0;
    miss =0;
    addr = 10'b1110000000;
    mem_read = 1;
    
    #100
    
    fill = 1;
    mem_block = 7;
    
    
    
    #25
    
    fill =0;
    
    
    
    
    addr = 10'b1110000000;
    mem_read = 1;
    
 
 
 
 
     #100
    fill = 0;
    miss =1;
        mem_read = 0;
    addr = 10'b1000000000;
    mem_write = 1;
    data_in = 2024;
    
    #100
    
    
    addr = 10'b1000000000;
    mem_read = 1;
    
    


     #100
    fill = 0;
    miss = 0;
        mem_read = 0;
    addr = 10'b1110000000;
    mem_write = 1;
    data_in = 10;
    
    #100
    
    
    addr = 10'b1110000000;
    mem_read = 1;
    
    
    
    
    
  end
  
  
  
  
  
  
endmodule
*/
