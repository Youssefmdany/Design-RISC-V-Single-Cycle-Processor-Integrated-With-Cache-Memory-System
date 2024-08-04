 module RISCV_Top (
                    input clk,
                    input reset
                                 );
                                 
                                 

wire[31:0] Wdata,Rdata;
wire[11:0] Data_addr;
wire we,re,Stall;


 
RISCV risc_v (.clk(clk),.reset(reset),.Wdata(Wdata),.Rdata(Rdata),.Data_addr(Data_addr),.we(we),.re(re),.Stall(Stall));
                                                                              
 
Data_Memory_System data_mem_sys (.clk(clk),.reset(reset),.mem_read(re),.mem_write(we),.byte_address(Data_addr),.DataIn(Wdata),.DataOut(Rdata),.Stall(Stall));
  

                                 
                                 
endmodule 