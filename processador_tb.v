
`timescale 1ns/1ns

`include "FetchU.v"
`include "UnidadeDeControle.v"
//`include "muxA.v"
`include "Registradores.v"
`include "SignalExtend.v"
`include "ShiftLeft2.v"
//`include "muxB.v"
`include "ula_controle.v"
`include "ALU.v"
`include "DataMemory.v"
`include "Add4.v"
`include "Adder32.v"
//`include "beq.v"
`include "MemoriaDeInstrucoes.v"
`include "processador.v"



module tb_processador;
    reg clk;
    reg reset;

    // Instancia o módulo de processador
    processador proc (
        .clk(clk),
        .reset(reset)
    );

    // Gera o clock
    always #5 clk = ~clk;

    integer i;
    initial begin
        $dumpfile("processador.vcd"); // Nome do arquivo de saída
        $dumpvars(0, tb_processador); // Registrar todas as variáveis deste módulo

        // Monitorar as entradas e saídas principais
        $dumpvars(0, proc.clk);
        $dumpvars(0, proc.reset);

        // Monitorar sinais internos principais
        $dumpvars(1, proc.RegDst);
        $dumpvars(1, proc.Branch);
        $dumpvars(1, proc.MemRead);
        $dumpvars(1, proc.MemtoReg);
        $dumpvars(1, proc.MemWrite);
        $dumpvars(1, proc.RegWrite);
        $dumpvars(1, proc.ALUSrc);
        $dumpvars(1, proc.ALUOp);
        $dumpvars(1, proc.controle);
        $dumpvars(1, proc.Zero);
        $dumpvars(1, proc.instrucao);
        $dumpvars(1, proc.readData1);
        $dumpvars(1, proc.readData2);
        $dumpvars(1, proc.writeData);
        $dumpvars(1, proc.operando2);
        $dumpvars(1, proc.imediato);
        $dumpvars(1, proc.aluResult);
        $dumpvars(1, proc.memReadData);
        $dumpvars(1, proc.writeRegister);

        // Monitorar os registradores internos
        for (i = 0; i < 32; i = i + 1) begin
            $dumpvars(1, tb_processador.proc.reg_bank.registers[i]); // Monitora cada registrador com escape
        end

        // Monitorar a memória de dados
        for (i = 0; i < 256; i = i + 1) begin
            $dumpvars(2, tb_processador.proc.data_mem.memory[i]); // Monitora a memória com escape
        end

        // Inicializa sinais
        clk = 0;
        reset = 0;  // Desabilita o reset inicialmente
        #10
        reset = 1;  // Aplica o reset
        #10
        reset = 0;  // Desabilita o reset

        // Adicione monitoramento para depuração
        $monitor("Time=%0d clk=%b reset=%b instrucao=%h readData1=%h readData2=%h aluResult=%h", $time, clk, reset, proc.instrucao, proc.readData1, proc.readData2, proc.aluResult);

        // Executa alguns ciclos de clock para verificar a operação
        #100;
        $finish;
    end

endmodule
