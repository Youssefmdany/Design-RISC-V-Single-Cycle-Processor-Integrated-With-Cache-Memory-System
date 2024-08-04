 module RISCV (
                    input clk,
                    input reset,Stall,
                    input[31:0] Rdata,
                    output[11:0] Data_addr,
                    output we,re,
                    output[31:0] Wdata
              
                                 );
                                 
                                 





 
wire[31:0] PC_Out,PC;
wire[31:0] inst_data; 
wire[31:0] reg1,reg2;
wire zero;
wire[3:0] ALUControl;
wire[2:0] immsrc;
wire MemtoReg,MemWrite,ALUSrc,RegWrite,PCsrc;
wire[31:0] ALUResult;
wire[31:0] immgen;
wire PC_sel;               
wire[1:0] branch;




//assign imm_sel = (inst_data[6:0]==7'b0000011 || inst_data[6:0]==7'b0010011 || inst_data[6:0]==7'b0100011 || inst_data[6:0]==7'b0010111 || inst_data[6:0]==7'b0110111 );

assign PC_sel = ( inst_data[6:0]==7'b0010111 );

assign Wdata = (inst_data[14:12]==3'b000) ? reg2 & 32'h0000_00ff :(inst_data[14:12]==3'b001) ? reg2 & 32'h0000_ffff : reg2;

assign branch = ( inst_data[6:0]==7'b1100011) ? 2'b00 : ( inst_data[6:0]==7'b1100111) ? 2'b01 : ( inst_data[6:0]==7'b1101111) ? 2'b10 : 2'b11;

assign Data_addr = (re || we) ? ALUResult : 0;

assign we = MemWrite;

assign re = ( inst_data[6:0]==7'b0000011);

assign PC = (branch==2'b00 && PCsrc) ? PC_Out+immgen : (branch==2'b01  && PCsrc ) ? reg1+immgen : (branch==2'b10 && PCsrc) ? PC_Out+immgen : PC_Out+4 ;




PC Program_counter (.clk(clk),.reset(reset),.PC( Stall ? PC_Out : PC ),.PC_Out(PC_Out));

 
 
instr_mem Instr_mem (.addr(PC_Out),.inst(inst_data));



Control_Unit Contrl_Unit (.op_code(inst_data[6:0]),.funct3(inst_data[14:12]),.funct7(inst_data[31:25]),.zero(zero),.ALUControl(ALUControl),.immsrc(immsrc),.MemtoReg(MemtoReg),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite),.PCsrc(PCsrc));                           



ImmGen Immdiate_gen (.imm(immsrc),.inst_data(inst_data),.immgen(immgen) );


                                 
reg_file Reg_File (.clk(clk),.reset(reset),.read_register1(inst_data[19:15]),.read_register2(inst_data[24:20]),.write_register(inst_data[11:7]),.write_data(MemtoReg ? Rdata : ((branch==2'b10 && PCsrc) ? PC_Out+4 : ALUResult)),.write_en(RegWrite),.read_data1(reg1),.read_data2(reg2));



ALU alu (.A( (PC_sel)? PC_Out : reg1),.B( ALUSrc ? immgen : ( ( branch==2'b01 || branch==2'b10 ) ? 4 : reg2) ),.ALUControl(ALUControl),.zero(zero),.ALUResult(ALUResult));
  
                                                               


                                 
                                 
endmodule 

