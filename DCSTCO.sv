module DCSTCO(
    // Input signals
	clk,
	rst_n,
    in_valid,
	target_product,
    // Output signals
    out_valid,
	ten,
	five,
	one,
	run_out_ing,
	// AHB-interconnect input signals
	ready_refri,
	ready_kitch,
	// AHB-interconnect output signals
	valid_refri,
	valid_kitch,
	product_out,
	number_out
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input        clk, rst_n ;
input        in_valid ;
input        [11:0] target_product ;
input        ready_refri ;
input        ready_kitch ;
output logic out_valid ;
output logic [3:0] ten ;
output logic five ;
output logic [2:0] one ;
output logic run_out_ing ;
output logic valid_refri ;
output logic valid_kitch ;
output logic product_out ;
output logic [5:0] number_out ; 

//---------------------------------------------------------------------
//   PARAMETER
//---------------------------------------------------------------------
parameter S_idle = 'd0;
parameter nfood = 'd1;
parameter S_master2 = 'd2;
parameter S_handshake = 'd3;
//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------
logic [1:0] cur_state,next_state;
logic out_temp;
logic product_out_temp;
logic [10:0] total;
logic valid_kitch_temp;
logic valid_refri_temp;
logic [5:0]number_out_temp;
logic [11:0] in_temp;
logic [3:0] ten_temp;
logic [2:0] one_temp;
logic five_temp;
logic haveapple,havefriedrice,havenugget,havepeach;
logic noapple,nofriedrice,nonugget,nopeach;
logic [2:0] d;
//---------------------------------------------------------------------
//   DON'T MODIFIED THE REGISTER'S NAME (PRODUCT REGISTER)
//---------------------------------------------------------------------
logic [6:0] nugget_in_shop, fried_rice_in_shop ,nugget_temp , fried_rice_temp,n,f,a,p;
logic [6:0] apple_in_shop , peach_in_shop ,apple_temp,peach_temp;
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//   FSM
//---------------------------------------------------------------------
always_comb begin
	case(cur_state)
		S_idle:
			if((haveapple && havefriedrice&& havenugget && havepeach)) begin
				next_state = S_idle;	
			end
			else if(!out_temp)
				next_state = nfood;
			else
				next_state = cur_state;
		nfood:
			if(in_valid & haveapple && havefriedrice && havepeach && havenugget) begin
				next_state = S_idle;	
			end
			else 
				next_state = nfood;
		default:
		next_state = cur_state;
	endcase
end
//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------
always_ff@ (posedge clk or negedge rst_n) begin
	if(!rst_n) 
		cur_state <= nfood;
	else
		cur_state <= next_state;
end
always_ff@ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		in_temp<=0;
	end
	else
		if(in_valid) begin
			in_temp <= target_product;
			total <= 3*target_product[11:9] + 5*target_product[8:6] + 2*target_product[5:3] + 4*target_product[2:0];
		end
end
/*assign a = in_temp[5:3];
assign p = in_temp[2:0];
assign n = in_temp[11:9];
assign f = in_temp[8:6];*/
assign handshake1 = valid_kitch && ready_kitch;
assign handshake2 = valid_refri && ready_refri;
always_ff@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		nugget_in_shop <= 0;
		fried_rice_in_shop <= 0;
		apple_in_shop <= 0;
		peach_in_shop <= 0;
	end
	else begin
		if(!out_temp && cur_state == S_idle && havenugget && havefriedrice && haveapple && havepeach)begin
			nugget_in_shop <= nugget_in_shop - in_temp[11:9];
			fried_rice_in_shop <= fried_rice_in_shop - in_temp[8:6];
			apple_in_shop <= apple_in_shop - in_temp[5:3];
			peach_in_shop <= peach_in_shop - in_temp[2:0];	
		end
		else  begin
			if(product_out && handshake1)
				nugget_in_shop <= 50;
			else if(product_out && handshake2)
				apple_in_shop <= 50;
			else if(!product_out && handshake1)
				fried_rice_in_shop <= 50;
			else if(!product_out && handshake2 )
				peach_in_shop <= 50;
		end	
	end
end

//assign 	
always_ff @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		out_valid <= 0;
		out_temp <= 0;
		run_out_ing <= 0;
	end
	else begin
	if(in_valid)begin
		out_valid <= 0;
		out_temp <= 0;
		run_out_ing <= 0;
	end
	else if(out_valid)begin
		out_valid <= 0;
		run_out_ing <= 0;
	end
	else if(next_state == S_idle && out_temp == 0)begin
		out_valid <= 1;
		out_temp <= 1;
	end
	else if(next_state == nfood)begin
		if(out_temp == 0 &&in_temp!=0 && havenugget && havefriedrice && haveapple && havepeach)begin
			out_valid <= 1;
			run_out_ing <= 1;
			out_temp <= 1;
		end
	end
	end
end
assign ten_temp = total/10;
assign havenugget = nugget_in_shop >= in_temp[11:9]||(product_out && handshake1);
assign haveapple = apple_in_shop >= in_temp[5:3]||(product_out && handshake2);
assign havepeach = peach_in_shop >= in_temp[2:0]||(!product_out && handshake2);
assign havefriedrice = fried_rice_in_shop >= in_temp[8:6] || (!product_out && handshake1);

assign nonugget = (nugget_in_shop < in_temp[11:9])&&!(product_out && handshake1);
assign noapple = (apple_in_shop < in_temp[5:3])&&!(product_out && handshake2);
assign nopeach = (peach_in_shop < in_temp[2:0])&&!(!product_out && handshake2);
assign nofriedrice = (fried_rice_in_shop < in_temp[8:6])&&!(!product_out && handshake1);

always_ff@(posedge clk or negedge rst_n) begin
	if(!rst_n)begin
		one <= 0;
		five <= 0;
		ten <= 0;
	end
	else begin
		if(cur_state == S_idle && out_temp == 0)begin
			if ( haveapple&&  havefriedrice&&havenugget&&havepeach)begin
				ten <= ten_temp;
				five <= (total%10 > 4)? 1:0;
				one <= total%5;
				//did <= 5;
			end
		end
		else begin
			ten <=0;
			five <= 0;
			one <= 0;
		end
	end
end
always_ff@(posedge clk or negedge rst_n) begin
		if(!rst_n)begin
		valid_kitch <= 0;
		valid_refri <= 0;
		d <= 4;
		product_out <= 0;
        number_out <= 0;
		end
		else begin

		
		if(next_state == nfood) begin
			if(nonugget)begin
				valid_kitch <= 1;
				valid_refri <= 0;
				product_out <= 1;
				number_out <= 50 - nugget_in_shop;
				d <= 0;
			end
			else if(noapple)begin
				valid_refri <= 1;
				valid_kitch <= 0;
				product_out <= 1;
				number_out <= 50 - apple_in_shop;
				d <= 1;
			end
			else if(nofriedrice)begin
				valid_kitch <= 1;
				valid_refri <= 0;
				product_out <= 0;
				number_out <= 50 - fried_rice_in_shop;
				d <= 2;
			end
			else if(nopeach)begin
				valid_refri <= 1;
				valid_kitch <= 0;
				product_out <= 0;
				number_out <= 50 - peach_in_shop;
				d <= 3;
			end
			else begin
				valid_refri <= 0;
				valid_kitch <= 0;
				number_out <= 0;
				d <= 4;
			end
			    
		end
		else begin
			valid_refri <= 0;
			valid_kitch <= 0;
			number_out <= 0;
			d <= 4;
		end		
		end

end
endmodule
