module reg_file (
input clk,
input reset,
input [4:0] read_register1,
input [4:0] read_register2,
input [4:0] write_register,
input [31:0] write_data,
input  write_en,

output [31:0] read_data1,
output [31:0] read_data2
);

//internal

reg [31:0] registers [31:0];




//read
assign read_data1= registers[read_register1];
assign read_data2= registers[read_register2];



//write
integer i;
always @(posedge clk or posedge reset) begin

    if (reset) begin
        for (i=0; i<32; i=i+1)begin
            registers[i]<= 32'b0;
          end
    end 
    
    else if (write_en && (write_register != 0)) begin

        registers[write_register] <= write_data;

     end


 registers[0] <= 0;


end



endmodule
