`include "ALU.v"

module ALU_tb;
    // Declarar variáveis para simular as entradas
    reg [31:0] A;
    reg [31:0] B;
    reg [3:0] ALUOperation;
    wire [31:0] ALUResult;
    wire Zero;

    // Instanciar o módulo que você quer testar
    ALU uut (
        .A(A),
        .B(B),
        .ALUOperation(ALUOperation),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    initial begin
        // Ativar a geração do arquivo VCD
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);

        // Mensagem de depuração
        $display("Iniciando a simulação");

        // Monitorar as mudanças nas variáveis
        $monitor("ALUOperation = %b, A = %h, B = %h, ALUResult = %h, Zero = %b", ALUOperation, A, B, ALUResult, Zero);

        // Teste para o caso AND
        A = 32'hFFFFFFFF;
        B = 32'h00000000;
        ALUOperation = 4'b0000;
        #10; // Esperado: ALUResult = 32'h00000000, Zero = 1

        // Teste para o caso OR
        A = 32'hFFFFFFFF;
        B = 32'h00000000;
        ALUOperation = 4'b0001;
        #10; // Esperado: ALUResult = 32'hFFFFFFFF, Zero = 0

        // Teste para o caso Soma
        A = 32'h00000001;
        B = 32'h00000001;
        ALUOperation = 4'b0010;
        #10; // Esperado: ALUResult = 32'h00000002, Zero = 0

        // Teste para o caso Subtração
        A = 32'h00000002;
        B = 32'h00000001;
        ALUOperation = 4'b0110;
        #10; // Esperado: ALUResult = 32'h00000001, Zero = 0

        // Teste para o caso SLT
        A = 32'h00000001;
        B = 32'h00000002;
        ALUOperation = 4'b0111;
        #10; // Esperado: ALUResult = 32'h00000001, Zero = 0

        // Teste para o caso NOR
        A = 32'hFFFFFFFF;
        B = 32'h00000000;
        ALUOperation = 4'b1100;
        #10; // Esperado: ALUResult = 32'h00000000, Zero = 1

        // Teste para o caso inválido
        A = 32'h00000000;
        B = 32'h00000000;
        ALUOperation = 4'b1111;
        #10; // Esperado: ALUResult = 32'h00000000, Zero = 1

        // Mensagem de depuração
        $display("Finalizando a simulação");

        $finish; // Finalizar a simulação
    end
endmodule
