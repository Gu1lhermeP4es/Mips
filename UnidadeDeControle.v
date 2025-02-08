module UnidadeDeControle(input [5:0]opCode, output reg RegDst, output reg ALUSrc, output reg MemtoReg, output reg RegWrite, output reg MemRead, output reg MemWrite, output reg Branch, output reg [1:0]ALUOp);
    always @(opCode)begin
        RegDst=0;
        ALUSrc=0;
        MemtoReg=0;
        RegWrite=0;
        MemRead=0;
        MemWrite=0;
        Branch=0;
        ALUOp=2'b00;
    

        case(opCode)
            6'b000000:begin
                RegDst=1;
                RegWrite=1;
                ALUOp=2'b10;
            end 

            6'b100011:begin
                ALUSrc=1;
                MemtoReg=1;
                RegWrite=1;
                MemRead=1;
                ALUOp=2'b00;
            end

            6'b101011:begin
                RegDst=0;
                ALUSrc=1;
                MemtoReg=0;
                MemWrite=1;
                ALUOp=2'b00;
            end

            6'b000100:begin
                RegDst=0;
                MemtoReg=0;
                Branch=1;
                ALUOp=2'b01;
            end

            default:begin
                RegDst=0;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                ALUOp = 2'b00;
                ALUSrc = 0;
                Branch = 0;
                MemtoReg = 0;
            end
        endcase
    end
endmodule
