module MIPS(
    //INPUT
    clk,
    rst_n,
    in_valid,
    instruction,

    //OUTPUT
    out_valid,
    instruction_fail,
    out_0,
    out_1,
    out_2,
    out_3,
    out_4,
    out_5
);
// INPUT
input clk;
input rst_n;
input in_valid;
input [31:0] instruction;

// OUTPUT
output logic out_valid, instruction_fail;
output logic [15:0] out_0, out_1, out_2, out_3, out_4, out_5;

//================================================================
// DESIGN 
//================================================================
logic [5:0] fun,fun_reg,opcode,opcode_reg;
logic [4:0] rs,rt,rd,shame,shame_reg;
logic [15:0] rs_value,rt_value,rd_value,r_out_reg,rs_value_reg,rt_value_reg;
logic [16:0] immediate,immediate_reg;
logic [4:0] r_address;
logic instruction_fail_reg,in_valid_1;
assign opcode_reg = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign fun_reg = (instruction[31:26] == 6'b001000)? 6'b100000 : instruction[5:0];
assign shame_reg = instruction[10:6];
assign immediate_reg = instruction[15:0];
// assign rs_value = ((!rs[4]&&rs[3])? out_2 : ((rs[0]&&!rs[1])? out_0 : ((!rs[2]&&rs[1])? out_1 :( (!rs[3]&&rs[2])? out_3 : ((rs[3]&&rs[2])? out_4 : out_5)))));
// assign rt_value = ((!rt[4]&&rt[3])? out_2 : ((rt[0]&&!rt[1])? out_0 : ((!rt[2]&&rt[1])? out_1 :( (!rt[3]&&rt[2])? out_3 : ((rt[3]&&rt[2])? out_4 : out_5)))));
always_comb begin
    case(rs)
    5'b10001:rs_value_reg = out_0;
    5'b10010:rs_value_reg = out_1;
    5'b01000:rs_value_reg = out_2;
    5'b10111:rs_value_reg = out_3;
    5'b11111:rs_value_reg = out_4;
    5'b10000:rs_value_reg = out_5;
    default: rs_value_reg = 0;
    endcase
end
always_comb begin

    case(rt)
    5'b10001:rt_value_reg = out_0;
    5'b10010:rt_value_reg = out_1;
    5'b01000:rt_value_reg = out_2;
    5'b10111:rt_value_reg = out_3;
    5'b11111:rt_value_reg = out_4;
    5'b10000:rt_value_reg = out_5;
    default :rt_value_reg = 0;
    endcase
end
always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        in_valid_1 <= 0;
        instruction_fail_reg <= 0;
        r_address<=0;
    end
    else begin
        in_valid_1 <= in_valid;
        rs_value <= rs_value_reg;
        r_address <= (instruction[29])? rt : rd;  
        rt_value<= (instruction[29])? immediate_reg: rt_value_reg;    

        shame <= shame_reg;
        opcode <= opcode_reg;
        fun<=fun_reg;
        if(in_valid)begin
        
        if(instruction[31] || instruction[30] || instruction[28] || instruction[27] ||instruction[26])begin
            instruction_fail_reg <= 1;
        end
        else begin
            instruction_fail_reg <= 0;
        end
 
        end

    end
end
always_comb begin
        case(fun)
        6'b100000:r_out_reg = rs_value+rt_value;
        6'b100100:r_out_reg = rs_value&rt_value;
        6'b100101:r_out_reg = rs_value|rt_value;
        6'b100111:r_out_reg = ~(rs_value|rt_value);
        6'b000000:r_out_reg = rt_value<<shame;
        6'b000010:r_out_reg = rt_value>>shame;
        default:r_out_reg = 0;
        endcase
    
end
always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_0 <= 0;
        out_1 <= 0;
        out_2 <= 0;
        out_3 <= 0;
        out_4 <= 0;
        out_5 <= 0;
        out_valid <= 0;
        instruction_fail <= 0;
    end
    else begin

        if(in_valid_1)begin
            instruction_fail <= instruction_fail_reg;
            out_valid <= 1;
            if (!instruction_fail_reg)begin
            case(r_address)
            5'b10001:out_0 <= r_out_reg;
            5'b10010:out_1 <= r_out_reg;
            5'b01000:out_2 <= r_out_reg;
            5'b10111:out_3 <= r_out_reg;
            5'b11111:out_4 <= r_out_reg;
            5'b10000:out_5 <= r_out_reg;
            endcase
            end
        end
        else begin
        out_0 <= 0;
        out_1 <= 0;
        out_2 <= 0;
        out_3 <= 0;
        out_4 <= 0;
        out_5 <= 0;
        out_valid <= 0;
        instruction_fail <= 0;
        end
    end
end
endmodule

// module get_value (address,out0,out1,out2,out3,out4,out5,value_1);
//     input logic [4:0] address;
//     input logic [15:0] out0,out1,out2,out3,out4,out5;
//     output logic [15:0] value_1;
// always_comb begin
//     case(address)
//     5'b10001:value_1 = out0;
//     5'b10010:value_1 = out1;
//     5'b01000:value_1 = out2;
//     5'b10111:value_1 = out3;
//     5'b11111:value_1 = out4;
//     5'b10000:value_1 = out5;
//     endcase
// end
// endmodule

// module func (fun,first,second,sham,value_2);
//     input logic [5:0] fun;
//     input logic [4:0] sham;
//     input logic [15:0] first,second;
//     output logic [15:0] value_2;
// always_comb begin
//     case(fun)
//     6'b100000:value_2 = first+second;
//     6'b100100:value_2 = first&second;
//     6'b100101:value_2 = first|second;
//     6'b100111:value_2 = ~(first|second);
//     6'b000000:value_2 = second<<sham;
//     6'b000010:value_2 = second>>sham;
//     endcase
// end
// endmodule