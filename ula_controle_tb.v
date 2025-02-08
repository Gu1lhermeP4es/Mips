`include "ula_controle.v"
module ula_controle_tb;
    // Declarar variáveis para simular as entradas
    reg [5:0] operacao;
    reg [1:0] aluOp;
    wire [3:0] controle;

    
    ula_controle uut (
        .operacao(operacao),
        .aluOp(aluOp),
        .controle(controle)
    );

    initial begin
        
        $dumpfile("ula_controle_tb.vcd");
        $dumpvars(0, ula_controle_tb);

        
        $display("Iniciando a simulação");

       
        $monitor("aluOp = %b, operacao = %b, controle = %b", aluOp, operacao, controle);

        // Teste para o caso de load/store
        aluOp = 2'b00;
        operacao = 6'b000000; //dont care para operacao
        #10; // Esperado: controle = 4'b0010

        // Teste para o caso de branch equal
        aluOp = 2'b01;
        operacao = 6'b000000; 
        #10; 

        // Teste para os casos de operacoes especificas com aluOp = 2'b10
        aluOp = 2'b10;
        operacao = 6'b100000; #10; 
        operacao = 6'b100010; #10; 
        operacao = 6'b100100; #10; 
        operacao = 6'b100101; #10;
        operacao = 6'b101010; #10;
        operacao = 6'b000000; #10; 

        // Mensagem de depuração
        $display("Finalizando a simulação");

        $finish; // Finalizar a simulação
    end
endmodule
