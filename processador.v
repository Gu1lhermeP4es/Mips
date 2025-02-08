module processador(input clk, input reset);

    //fios de controle da unidade de controle principal
    wire RegDst, Branch, MemRead, MemtoReg, MemWrite, RegWrite, ALUSrc;
    wire [1:0] ALUOp;
    wire [3:0]controle; //controle da ALUcontrol. 
    wire Zero;

    //entradas para o Registers, saida da alu, 
    wire [31:0] instrucao, readData1, readData2, writeData, operando2;
    wire [31:0] imediato, aluResult, memReadData; //memReadData é a saída da memória de dados
    wire [4:0] writeRegister; // esse é o do módulo Registradores

    //modulo que manipula o contador de programa (modificado em relação ao do prof, pois agora o pc pode receber valores em caso de desvio)
    FetchU fetch_unit (.clk(clk), .reset(reset), .Zero(Zero), .Branch(Branch), .instrucao(instrucao));

    //Unidade de controle principal
    UnidadeDeControle Ucontrole (.opCode(instrucao[31:26]), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp));

    //Mux que dirá qual a entrada writeRegister do módulo registrador
    assign writeRegister=(RegDst)? instrucao[15:11]: instrucao[20:16];

    // Banco de registradores (módulo do prof)
    Registradores reg_bank (.ReadRegister1(instrucao[25:21]), .ReadRegister2(instrucao[20:16]), .WriteRegister(writeRegister), .WriteData(writeData), .RegWrite(RegWrite),.clk(clk),.ReadData1(readData1), .ReadData2(readData2));
    
    //usando o módulo para extender a intrucao[15:0] que será a entrada imediata
    SignalExtend sign_extend (.in(instrucao[15:0]),.out(imediato));

    //mux que dirá se a entrada da alu vorá do banco de registradores ou do imediato(junyo à instrucao)
    assign operando2=(ALUSrc)? imediato:readData2;

    // Unidade de controle da ALU
    ula_controle alu_ctrl (.operacao(instrucao[5:0]), .aluOp(ALUOp), .controle(controle));

    //Unidade L/A
    ALU alu (.A(readData1),.B(operando2),.ALUOperation(controle),.ALUResult(aluResult),.Zero(Zero));

    // Memória de dados
    DataMemory data_mem (.clk(clk), .MemRead(MemRead), .MemWrite(MemWrite), .address(aluResult), .writeData(readData2), .readData(memReadData));

    // Multiplexador para selecionar dado a ser escrito no registrador
    assign writeData = (MemtoReg) ? memReadData : aluResult;


endmodule