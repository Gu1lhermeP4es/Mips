module ula_controle(input [5:0] operacao, input [1:0] aluOp, output reg [3:0] controle);
    always @(*)begin
        
        case(aluOp)
            2'b00:begin
                controle=4'b0010; // load/store
            end

            2'b01:begin
                controle=4'b0110; //branch equal
            end

            2'b10:begin
                case(operacao)
                   6'b100000:begin controle=4'b0010;end //soma
                   6'b100010:begin controle=4'b0110;end // sub
                   6'b100100:begin controle=4'b0000;end //and
                   6'b100101:begin controle=4'b0001;end //or
                   6'b101010:begin controle=4'b0111;end //set on less than
                   default: begin controle=4'b0000; end
                endcase
            end
            default : begin controle=4'b0000; end
        endcase
    end
endmodule