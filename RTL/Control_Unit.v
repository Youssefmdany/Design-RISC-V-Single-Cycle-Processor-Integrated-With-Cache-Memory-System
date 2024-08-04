
module Control_Unit(input[6:0] op_code,input[2:0] funct3 ,input[6:0] funct7,input zero,output reg[3:0] ALUControl,output reg[2:0] immsrc ,output reg MemtoReg,MemWrite,ALUSrc,RegWrite,PCsrc);
  




    always@* begin
    
    if(op_code ==  7'b0000011 || op_code ==  7'b0010011 || op_code ==  7'b0010111 || op_code ==  7'b0110011 || op_code ==  7'b0110111 || op_code == 7'b1100111 || op_code == 7'b1101111 ) 
      
           RegWrite = 1;
           
    else
           RegWrite = 0;                
               
    
    end 








    always@* begin
    
   
       if(op_code == 7'b0000011 || op_code == 7'b1100111 || op_code == 7'b0010011)
                  
                      immsrc = 3'b000;

       else if(op_code == 7'b0100011 )
                  
                      immsrc = 3'b001;
                      
       else if(op_code == 7'b0010111 || op_code == 7'b0110111)
                  
                      immsrc = 3'b010;                                      
           
       else if(op_code == 7'b1101111)
                  
                      immsrc = 3'b011;               
               
       else if(op_code == 7'b1100011)
                  
                      immsrc = 3'b100;    
                      
                      
       else if(op_code == 7'b0110111)
                  
                      immsrc = 3'b101; 
                      
       else 
                      immsrc = 3'b111;   //dont care     
                                           
    end 







  always@* begin
    
    if ( (op_code ==  7'b0110011  || op_code ==  7'b0010011 ) &&  funct7 == 7'b0000000)  begin
    
          if(funct3 == 3'b000 || op_code ==  7'b1100111 || op_code ==  7'b1101111 )
                 
                 ALUControl = 4'b0000 ;
                 
         else if (funct3 == 3'b001)  
         
                 ALUControl = 4'b0001 ;
         
         else if (funct3 == 3'b010)
         
                 ALUControl = 4'b0010 ;
                 
         else if (funct3 == 3'b011)
                
                ALUControl = 4'b0011 ;
         
         else if (funct3 == 3'b100)
         
                ALUControl = 4'b0100 ;
         
         else if (funct3 == 3'b101)
           
               ALUControl = 4'b0101 ;
               
         else if (funct3 == 3'b110)
           
               ALUControl = 4'b0110 ;               
               
         else 
           
               ALUControl = 4'b0111 ; 
           
           
         end
           
           
    else if((op_code ==  7'b0110011  || op_code ==  7'b0010011 ) &&  funct7 == 7'b0100000) begin
      
                        
          if(funct3 == 3'b000)
                 
                 ALUControl = 4'b1000 ;
                 
         else if (funct3 == 3'b101)  
         
                 ALUControl = 4'b1101 ;
         else 
               ALUControl = 4'b000; // don't care value               
     end
     
     
    

     else if (op_code ==  7'b0100011 || op_code ==  7'b1100111 || op_code ==  7'b1101111 )
               ALUControl = 4'b0000;

     else if (op_code ==  7'b1100011)
               ALUControl = 4'b1000;
               
     else 
               ALUControl = 4'b000; // don't care value
               
    

end






  always@* begin
    
    if(op_code ==  7'b0000011 || op_code ==  7'b0010011 || op_code ==  7'b0100011 || op_code ==  7'b0010111 || op_code == 7'b0110111 ) 
      
           ALUSrc = 1;
           
    else
           ALUSrc = 0;                
               
    
    end






  
  
  always@* begin
    
    if(op_code ==  7'b0000011 ) 
      
           MemtoReg = 1;
           
    else
           MemtoReg = 0;                
               
    
    end
  
  
  
  
  
  
  
  always@* begin
    
    if(op_code ==  7'b0100011 ) 
      
           MemWrite = 1;
           
    else
           MemWrite = 0;                
               
    
    end
  
 
 


  
  
  
  
    always@* begin
    
    if(op_code ==  7'b1100111 || op_code ==  7'b1101111 ) 
      
           PCsrc = 1;
           
    else if(op_code ==  7'b1100011 && funct3 == 000 && zero)
      
           PCsrc = 1;   
                        
    else if(op_code ==  7'b1100011 && funct3 == 001 && !zero)
      
           PCsrc = 1;  
           
    else
     
           PCsrc = 0;  
                
    
    end 
  
  
  
  
  
  
  
  
endmodule 
