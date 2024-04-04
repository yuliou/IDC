module IDC(
    // Input signals
	clk,
	rst_n,
	in_valid,
    in_id,
    // Output signals
    out_valid,
    out_legal_id
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input clk, rst_n, in_valid;
input [5:0] in_id;

output logic out_valid;
output logic out_legal_id;
logic [5:0] n1,in_temp;
logic out_legal_id_temp;
logic out_valid_temp;
logic invalid;
logic [3:0] count2,t ;
logic [3:0] store;
logic [5:0] temp;
logic [3:0] multi;
logic [3:0] dev;
logic [3:0] pa;
logic [8:0] m1,m2,m3,m4,m5,m6,m7,m9,m8;
mul mm(.in1(count2),.in2(pa),.out(multi));
mo mmm(in_temp,pa);
mo mmmm(temp,t);
//inv inin(in_temp,store,multi);
//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------
always_ff @(posedge clk ,negedge rst_n) begin
	if(!rst_n)
		begin
            //out_legal_id <= 0;
			out_valid <= 0;
            //out_legal_id_temp <= 0;
			//out_valid_temp <= 0;
			n1 <= 0;
            invalid <= 0;
            temp <= 0;
            in_temp <= 0;
            count2 <= 10;
            //multi <= 0;
            //dev <= 0;
		end
	else
		begin
            in_temp <= in_id;
            if(in_valid) begin
                count2 <= count2 - 1;
                //multi <= count2*pa;
                //dev <= in_id/10;
                temp <= (t + store); 
				out_valid <= 0;
            end
            if(count2 == 1)begin
                out_valid <= 1;
                temp <= (t + in_id+store);
            end           
            if(out_valid) begin
                out_valid <= 0;
                temp <= 0;
                count2 <= 10;
            end
		end
end

//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------
always_comb begin
    if(count2<10)begin
		case(in_temp)
			8'd10: store=1;
			8'd11:store=0;
			8'd12:store=9;
			8'd13:store=8;
			8'd14:store=7;
			8'd15:store=6;
            8'd16:store=5;
			8'd17:store=4;
            8'd18:store=3;
			8'd19:store=2;
            8'd20:store=2;
			8'd21:store=1;
            8'd22:store=0;
			8'd23:store=9;
            8'd24:store=8;
			8'd25:store=7;
            8'd26:store=6;
			8'd27:store=5;
            8'd28:store=4;
			8'd29:store=3;
            8'd30:store=3;
			8'd31:store=2;
            8'd32:store=1;
			8'd33:store=0;
			8'd34:store=9;
            8'd35:store=8;
			8'd1:store=multi;
			8'd2:store=multi;
            8'd3:store=multi;
			8'd4:store=multi;
            8'd5:store=multi;
			8'd6:store=multi;
            8'd7:store=multi;
			8'd8:store=multi;
            8'd9:store=multi;
			default:store=0;
		endcase
	end
	else 
		store = 0;
    
end

always_comb begin
    out_legal_id = ((t == 0) && out_valid)? 1:0;
end

endmodule

module mul(in1,in2,out);

input logic [3:0] in1,in2;
output logic [3:0] out;

	always_comb begin
		case({in1,in2})
			8'h00: out = 0;
			8'h01: out = 0;
			8'h02: out = 0;
			8'h03: out = 0;
			8'h04: out = 0;
			8'h05: out = 0;
			8'h06: out = 0;
			8'h07: out = 0;
			8'h08: out = 0;
			8'h09: out = 0;
			
			8'h10: out = 0;
			8'h11: out = 1;
			8'h12: out = 2;
			8'h13: out = 3;
			8'h14: out = 4;
			8'h15: out = 5;
			8'h16: out = 6;
			8'h17: out = 7;
			8'h18: out = 8;
			8'h19: out = 9;
			
			8'h20: out = 0;
			8'h21: out = 2;
			8'h22: out = 4;
			8'h23: out = 6;
			8'h24: out = 8;
			8'h25: out = 0;
			8'h26: out = 2;
			8'h27: out = 4;
			8'h28: out = 6;
			8'h29: out = 8;
			
			8'h30: out = 0;
			8'h31: out = 3;
			8'h32: out = 6;
			8'h33: out = 9;
			8'h34: out = 2;
			8'h35: out = 5;
			8'h36: out = 8;
			8'h37: out = 1;
			8'h38: out = 4;
			8'h39: out = 7;
			
			8'h40: out = 0;
			8'h41: out = 4;
			8'h42: out = 8;
			8'h43: out = 2;
			8'h44: out = 6;
			8'h45: out = 0;
			8'h46: out = 4;
			8'h47: out = 8;
			8'h48: out = 2;
			8'h49: out = 6;
			
			8'h50: out = 0;
			8'h51: out = 5;
			8'h52: out = 0;
			8'h53: out = 5;
			8'h54: out = 0;
			8'h55: out = 5;
			8'h56: out = 0;
			8'h57: out = 5;
			8'h58: out = 0;
			8'h59: out = 5;
			
			8'h60: out = 0;
			8'h61: out = 6;
			8'h62: out = 2;
			8'h63: out = 8;
			8'h64: out = 4;
			8'h65: out = 0;
			8'h66: out = 6;
			8'h67: out = 2;
			8'h68: out = 8;
			8'h69: out = 4;
			
			8'h70: out = 0;
			8'h71: out = 7;
			8'h72: out = 4;
			8'h73: out = 1;
			8'h74: out = 8;
			8'h75: out = 5;
			8'h76: out = 2;
			8'h77: out = 9;
			8'h78: out = 6;
			8'h79: out = 3;
			
			8'h80: out = 0;
			8'h81: out = 8;
			8'h82: out = 6;
			8'h83: out = 4;
			8'h84: out = 2;
			8'h85: out = 0;
			8'h86: out = 8;
			8'h87: out = 6;
			8'h88: out = 4;
			8'h89: out = 2;
			
			8'h90: out = 0;
			8'h91: out = 9;
			8'h92: out = 8;
			8'h93: out = 7;
			8'h94: out = 6;
			8'h95: out = 5;
			8'h96: out = 4;
			8'h97: out = 3;
			8'h98: out = 2;
			8'h99: out = 1;
			default: out = 0;
		endcase
	end
endmodule

module mo (value_in , value_out);

input logic [5:0] value_in;
output logic [3:0] value_out;

always_comb begin
	case(value_in)
			8'd1:value_out=1;
			8'd2:value_out=2;
            8'd3:value_out=3;
			8'd4:value_out=4;
            8'd5:value_out=5;
			8'd6:value_out=6;
            8'd7:value_out=7;
			8'd8:value_out=8;
            8'd9:value_out=9;
			8'd10:value_out=0;
			8'd11:value_out=1;
			8'd12:value_out=2;
            8'd13:value_out=3;
			8'd14:value_out=4;
            8'd15:value_out=5;
			8'd16:value_out=6;
            8'd17:value_out=7;
			8'd18:value_out=8;
			8'd19:value_out=9;
			8'd20:value_out=0;
			8'd21:value_out=1;
			8'd22:value_out=2;
			8'd23:value_out=3;
			8'd24:value_out=4;
			8'd25:value_out=5;
			8'd26:value_out=6;
			8'd27:value_out=7;
			8'd28:value_out=8;
			8'd29:value_out=9;
            default:value_out=0;
	endcase
end

endmodule

/*module inv(inv1,outv1,h);

input logic [5:0] inv1;
output logic [3:0] outv1;
input logic [3:0] h;
always_comb begin
		case(inv1)
			8'd10:outv1=1;
			8'd11:outv1=0;
			8'd12:outv1=9;
			8'd13:outv1=8;
			8'd14:outv1=7;
			8'd15:outv1=6;
            8'd16:outv1=5;
			8'd17:outv1=4;
            8'd18:outv1=3;
			8'd19:outv1=2;
            8'd20:outv1=2;
			8'd21:outv1=1;
            8'd22:outv1=0;
			8'd23:outv1=9;
            8'd24:outv1=8;
			8'd25:outv1=7;
            8'd26:outv1=6;
			8'd27:outv1=5;
            8'd28:outv1=4;
			8'd29:outv1=3;
            8'd30:outv1=3;
			8'd31:outv1=2;
            8'd32:outv1=1;
			8'd33:outv1=0;
			8'd34:outv1=9;
            8'd35:outv1=8;
            8'd0:outv1=0;
			8'd1:outv1=h;
			8'd2:outv1=h;
            8'd3:outv1=h;
			8'd4:outv1=h;
            8'd5:outv1=h;
			8'd6:outv1=h;
            8'd7:outv1=h;
			8'd8:outv1=h;
            8'd9:outv1=h;
			default:outv1=0;
		endcase
end
endmodule*/