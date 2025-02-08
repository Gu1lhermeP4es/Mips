`include "UnidadeDeControle.v"
module UnidadeDeControle_tb;
    // Declarar variáveis para simular as entradas
    reg [5:0] opCode;
    wire RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
    wire [1:0] ALUOp;

    // Instanciar o módulo que você quer testar
    UnidadeDeControle uut (
        .opCode(opCode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    initial begin
        // Ativar a geração do arquivo VCD
        $dumpfile("UnidadeDeControle_tb.vcd");
        $dumpvars(0, UnidadeDeControle_tb);

        // Mensagem de depuração
        $display("Iniciando a simulação");

        // Monitorar as mudanças nas variáveis
        $monitor("opCode = %b, RegDst = %b, ALUSrc = %b, MemtoReg = %b, RegWrite = %b, MemRead = %b, MemWrite = %b, Branch = %b, ALUOp = %b", 
            opCode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);

        // Teste para o caso de R-type
        opCode = 6'b000000;
        #10; // Esperado: RegDst=1, ALUSrc=0, MemtoReg=0, RegWrite=1, MemRead=0, MemWrite=0, Branch=0, ALUOp=2'b10

        // Teste para o caso de LW
        opCode = 6'b100011;
        #10; // Esperado: RegDst=0, ALUSrc=1, MemtoReg=1, RegWrite=1, MemRead=1, MemWrite=0, Branch=0, ALUOp=2'b00

        // Teste para o caso de SW
        opCode = 6'b101011;
        #10; // Esperado: RegDst=0, ALUSrc=1, MemtoReg=0, RegWrite=0, MemRead=0, MemWrite=1, Branch=0, ALUOp=2'b00

        // Teste para o caso de BEQ
        opCode = 6'b000100;
        #10; // Esperado: RegDst=0, ALUSrc=0, MemtoReg=0, RegWrite=0, MemRead=0, MemWrite=0, Branch=1, ALUOp=2'b01

        // Teste para o caso padrão (default)
        opCode = 6'b111111;
        #10; // Esperado: RegDst=0, ALUSrc=0, MemtoReg=0, RegWrite=0, MemRead=0, MemWrite=0, Branch=0, ALUOp=2'b00

        // Mensagem de depuração
        $display("Finalizando a simulação");

        $finish; // Finalizar a simulação
    end
endmodule
