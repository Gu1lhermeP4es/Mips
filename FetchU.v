module FetchU(
    input wire clk,                 // Clock
    input wire reset,               // Reset para inicializar o PC
    input Zero,                     //sinal de ssaída da alu
    input Branch,                   //sinal da Unidade de Controle
    output wire [31:0] instrucao    // Instrução buscada da memória
);

    // Registrador do PC
    reg [31:0] pc;

    // Fios para conexão entre módulos
    wire [31:0] pc_incrementado;
    wire [31:0] desvio;
    wire [31:0] ExtendOffset;
    wire [31:0]ExtendShiftOffset;
    wire [31:0] pcProximo;


    // Instancia o módulo Add4 para incrementar o PC
    Add4 somador (
        .in(pc),
        .out(pc_incrementado)
    );

    // Instancia o módulo MemoriaDeInstrucoes para buscar instruções
    MemoriaDeInstrucoes memoria (
        .addr(pc),
        .instrucao(instrucao)
    );
    SignalExtend extensor(.in(instrucao[15:0]), .out(ExtendOffset));
    ShiftLeft2 desloca(.in(ExtendOffset), .out(ExtendShiftOffset)); 
    assign desvio=ExtendShiftOffset+pc_incrementado;

    //mux que dirá qual a saída será a do pc; Se pc+4 ou se o pc+ endereco de desvio
    assign pcProximo=(Branch & Zero)? desvio: pc_incrementado;

    // Lógica do PC: Incrementa ou reseta
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Inicializa o PC no reset
            pc <= 32'b0;            
        end else begin
            // Atualiza o PC com o próximo endereço (desviado com beq ou pc+4)
            pc <= pcProximo;  
        end
    end

endmodule
