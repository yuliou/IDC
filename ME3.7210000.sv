module ME(
    // Input signals
	clk,
	rst_n,
    block_valid,
	area_valid,
    in_data,
    // Output signals
    out_valid,
    out_vector
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input clk, rst_n, block_valid, area_valid;
input [7:0] in_data;

output logic out_valid;
output logic signed [2:0] out_vector;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------
logic [12:0] sad[24:0];
logic [10:0]min;
logic [3:0] count1;
logic [5:0] count2;
logic [7:0] cur_block [15:0]; 
logic [7:0] in_reg;
logic [1:0] out_temp;
logic signed [2:0] min_x ,min_y;
logic [7:0] abs [15:0];
logic [7:0] abs_t [15:0];
//------------:---------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------
always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        count1 <= 0;
    end
    else begin
        if(block_valid)begin
            count1 <= count1 + 1;
        end
    end
end

always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        count2 <= 0;
    end
    else begin
        if(area_valid)begin
            count2 <= count2 + 1;
        end
    end
end

always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        abs[0] <= 0;abs[1] <= 0;abs[2] <= 0;abs[3] <= 0;abs[4] <= 0;
        abs[5] <= 0;abs[6] <= 0;abs[7] <= 0;abs[8] <= 0;abs[9] <= 0;
        abs[10] <= 0;abs[11] <= 0;abs[12] <= 0;abs[13] <= 0;abs[14] <= 0;
        abs[15] <= 0;
    end
    else begin
        if(area_valid)begin
        abs[0] <= abs_t[0];abs[1] <= abs_t[1];abs[2] <= abs_t[2];abs[3] <= abs_t[3];abs[4] <= abs_t[4];
        abs[5] <= abs_t[5];abs[6] <= abs_t[6];abs[7] <= abs_t[7];abs[8] <= abs_t[8];abs[9] <= abs_t[9];
        abs[10] <= abs_t[10];abs[11] <= abs_t[11];abs[12] <= abs_t[12];abs[13] <= abs_t[13];abs[14] <= abs_t[14];
        abs[15] <= abs_t[15];
        end
    end
end
assign abs_t[0] = (cur_block[0] > in_data)? cur_block[0] - in_data : in_data - cur_block[0];
assign abs_t[1] = (cur_block[1] > in_data)? cur_block[1] - in_data : in_data - cur_block[1];
assign abs_t[2] = (cur_block[2] > in_data)? cur_block[2] - in_data : in_data - cur_block[2];
assign abs_t[3] = (cur_block[3] > in_data)? cur_block[3] - in_data : in_data - cur_block[3];
assign abs_t[4] = (cur_block[4] > in_data)? cur_block[4] - in_data : in_data - cur_block[4];
assign abs_t[5] = (cur_block[5] > in_data)? cur_block[5] - in_data : in_data - cur_block[5];
assign abs_t[6] = (cur_block[6] > in_data)? cur_block[6] - in_data : in_data - cur_block[6];
assign abs_t[7] = (cur_block[7] > in_data)? cur_block[7] - in_data : in_data - cur_block[7];
assign abs_t[8] = (cur_block[8] > in_data)? cur_block[8] - in_data : in_data - cur_block[8];
assign abs_t[9] = (cur_block[9] > in_data)? cur_block[9] - in_data : in_data - cur_block[9];
assign abs_t[10] = (cur_block[10] > in_data)? cur_block[10] - in_data : in_data - cur_block[10];
assign abs_t[11] = (cur_block[11] > in_data)? cur_block[11] - in_data : in_data - cur_block[11];
assign abs_t[12] = (cur_block[12] > in_data)? cur_block[12] - in_data : in_data - cur_block[12];
assign abs_t[13] = (cur_block[13] > in_data)? cur_block[13] - in_data : in_data - cur_block[13];
assign abs_t[14] = (cur_block[14] > in_data)? cur_block[14] - in_data : in_data - cur_block[14];
assign abs_t[15] = (cur_block[15] > in_data)? cur_block[15] - in_data : in_data - cur_block[15];

always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cur_block[0] <= 0;cur_block[1] <= 0;cur_block[2] <= 0;cur_block[3] <= 0;
        cur_block[4] <= 0;cur_block[5] <= 0;cur_block[6] <= 0;cur_block[7] <= 0;
        cur_block[8] <= 0;cur_block[9] <= 0;cur_block[10] <= 0;cur_block[11] <= 0;
        cur_block[12] <= 0;cur_block[13] <= 0;cur_block[14] <= 0;cur_block[15] <= 0;
    end
    else begin
        if(block_valid)begin
            cur_block[count1] <= in_data;
        end
    end
end

always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        sad[0] <= 0;sad[1] <= 0;sad[2] <= 0;sad[3] <= 0;sad[4] <= 0;
        sad[5] <= 0;sad[6] <= 0;sad[7] <= 0;sad[8] <= 0;sad[9] <= 0;
        sad[10] <= 0;sad[11] <= 0;sad[12] <= 0;sad[13] <= 0;sad[14] <= 0;
        sad[15] <= 0;sad[16] <= 0;sad[17] <= 0;sad[18] <= 0;sad[19] <= 0;
        sad[20] <= 0;sad[21] <= 0;sad[22] <= 0;sad[23] <= 0;sad[24] <= 0;
    end
    else begin
        if(area_valid)begin
        // sad[0] <= s_reg[0];sad[1] <= s_reg[1];sad[2] <= s_reg[2];sad[3] <= s_reg[3];sad[4] <= s_reg[4];
        // sad[5] <= s_reg[5];sad[6] <= s_reg[6];sad[7] <= s_reg[7];sad[8] <= s_reg[8];sad[9] <= s_reg[9];
        // sad[10] <= s_reg[10];sad[11] <= s_reg[11];sad[12] <= s_reg[12];sad[13] <= s_reg[13];sad[14] <= s_reg[14];
        // sad[15] <= s_reg[15];sad[16] <= s_reg[16];sad[17] <= s_reg[17];sad[18] <= s_reg[18];sad[19] <= s_reg[19];
        // sad[20] <= s_reg[20];sad[21] <= s_reg[21];sad[22] <= s_reg[22];sad[23] <= s_reg[23];sad[24] <= s_reg[24];
        case(count2)
        6'd1:
        begin
            sad[0] <= abs[0];
        end
        6'd2:
        begin
            sad[0] <= sad[0] + abs[1];
            sad[1] <= sad[1] + abs[0];
        end
        6'd3:
        begin
            sad[0] <= sad[0] + abs[2];
            sad[1] <= sad[1] + abs[1];
            sad[2] <= sad[2] + abs[0];
        end
        6'd4:
        begin
            sad[0] <= sad[0] + abs[3];
            sad[1] <= sad[1] + abs[2];
            sad[2] <= sad[2] + abs[1];
            sad[3] <= sad[3] + abs[0];
        end       
        6'd5:
        begin
            sad[1] <= sad[1] + abs[3];
            sad[2] <= sad[2] + abs[2];
            sad[3] <= sad[3] + abs[1];
            sad[4] <= sad[4] + abs[0];
        end          
        6'd6:
        begin
            sad[2] <= sad[2] + abs[3];
            sad[3] <= sad[3] + abs[2];
            sad[4] <= sad[4] + abs[1];
        end        
        6'd7:
        begin
            sad[3] <= sad[3] + abs[3];
            sad[4] <= sad[4] + abs[2];
        end
        6'd8:
        begin
            sad[4] <= sad[4] + abs[3];
        end


        6'd9:
        begin
            sad[0] <= sad[0] + abs[4];
            sad[5] <= sad[5] + abs[0];
        end
        6'd10:
        begin
            sad[0] <= sad[0] + abs[5];
            sad[1] <= sad[1] + abs[4];
            sad[5] <= sad[5] + abs[1];
            sad[6] <= sad[6] + abs[0];
        end    
        6'd11:
        begin
            sad[0] <= sad[0] + abs[6];
            sad[1] <= sad[1] + abs[5];
            sad[2] <= sad[2] + abs[4];           
            sad[5] <= sad[5] + abs[2];
            sad[6] <= sad[6] + abs[1];
            sad[7] <= sad[7] + abs[0];
        end
        6'd12:
        begin
            sad[0] <= sad[0] + abs[7];
            sad[1] <= sad[1] + abs[6];
            sad[2] <= sad[2] + abs[5];
            sad[3] <= sad[3] + abs[4];
            sad[5] <= sad[5] + abs[3];
            sad[6] <= sad[6] + abs[2];
            sad[7] <= sad[7] + abs[1];
            sad[8] <= sad[8] + abs[0];
        end
        6'd13:
        begin
            sad[1] <= sad[1] + abs[7];
            sad[2] <= sad[2] + abs[6];
            sad[3] <= sad[3] + abs[5];
            sad[4] <= sad[4] + abs[4];
            sad[6] <= sad[6] + abs[3];
            sad[7] <= sad[7] + abs[2];
            sad[8] <= sad[8] + abs[1];
            sad[9] <= sad[9] + abs[0];
        end
        6'd14:
        begin
            sad[2] <= sad[2] + abs[7];
            sad[3] <= sad[3] + abs[6];
            sad[4] <= sad[4] + abs[5];            
            sad[7] <= sad[7] + abs[3];
            sad[8] <= sad[8] + abs[2];
            sad[9] <= sad[9] + abs[1];
        end    
        6'd15:
        begin
            sad[3] <= sad[3] + abs[7];
            sad[4] <= sad[4] + abs[6];
            sad[8] <= sad[8] + abs[3];
            sad[9] <= sad[9] + abs[2];
        end
        6'd16:
        begin
            sad[4] <= sad[4] + abs[7];            
            sad[9] <= sad[9] + abs[3];
        end

        6'd17:
        begin
            sad[0] <= sad[0] + abs[8];
            sad[5] <= sad[5] + abs[4];
            sad[10] <= sad[10] + abs[0];             
        end
        6'd18:
        begin
            sad[0] <= sad[0] + abs[9];
            sad[1] <= sad[1] + abs[8];            
            sad[5] <= sad[5] + abs[5];
            sad[6] <= sad[6] + abs[4];
            sad[10] <= sad[10] + abs[1];
            sad[11] <= sad[11] + abs[0];            
        end
        6'd19:
        begin
            sad[0] <= sad[0] + abs[10];
            sad[1] <= sad[1] + abs[9];
            sad[2] <= sad[2] + abs[8];  
            sad[5] <= sad[5] + abs[6];
            sad[6] <= sad[6] + abs[5];
            sad[7] <= sad[7] + abs[4];           
            sad[10] <= sad[10] + abs[2];
            sad[11] <= sad[11] + abs[1];
            sad[12] <= sad[12] + abs[0];
        end
        6'd20:
        begin
            sad[0] <= sad[0] + abs[11];
            sad[1] <= sad[1] + abs[10];
            sad[2] <= sad[2] + abs[9];
            sad[3] <= sad[3] + abs[8];            
            sad[5] <= sad[5] + abs[7];
            sad[6] <= sad[6] + abs[6];
            sad[7] <= sad[7] + abs[5];
            sad[8] <= sad[8] + abs[4];
            sad[10] <= sad[10] + abs[3];
            sad[11] <= sad[11] + abs[2];
            sad[12] <= sad[12] + abs[1];
            sad[13] <= sad[13] + abs[0];
        end
        6'd21:
        begin
            sad[1] <= sad[1] + abs[11];
            sad[2] <= sad[2] + abs[10];
            sad[3] <= sad[3] + abs[9];
            sad[4] <= sad[4] + abs[8];
            sad[6] <= sad[6] + abs[7];
            sad[7] <= sad[7] + abs[6];
            sad[8] <= sad[8] + abs[5];
            sad[9] <= sad[9] + abs[4];
            sad[11] <= sad[11] + abs[3];
            sad[12] <= sad[12] + abs[2];
            sad[13] <= sad[13] + abs[1];
            sad[14] <= sad[14] + abs[0];
        end 
        6'd22:
        begin
            sad[2] <= sad[2] + abs[11];
            sad[3] <= sad[3] + abs[10];
            sad[4] <= sad[4] + abs[9];             
            sad[7] <= sad[7] + abs[7];
            sad[8] <= sad[8] + abs[6];
            sad[9] <= sad[9] + abs[5];            
            sad[12] <= sad[12] + abs[3];
            sad[13] <= sad[13] + abs[2];
            sad[14] <= sad[14] + abs[1];        
        end
        6'd23:
        begin
            sad[3] <= sad[3] + abs[11];
            sad[4] <= sad[4] + abs[10];
            sad[8] <= sad[8] + abs[7];
            sad[9] <= sad[9] + abs[6];
            sad[13] <= sad[13] + abs[3];
            sad[14] <= sad[14] + abs[2];
        end        
        6'd24:
        begin
            sad[4] <= sad[4] + abs[11]; 
            sad[9] <= sad[9] + abs[7];            
            sad[14] <= sad[14] + abs[3];
        end

        6'd25:
        begin
            sad[0] <= sad[0] + abs[12];
            sad[5] <= sad[5] + abs[8];
            sad[10] <= sad[10] + abs[4];
            sad[15] <= sad[15] + abs[0];             
        end
        6'd26:
        begin
            sad[0] <= sad[0] + abs[13];
            sad[1] <= sad[1] + abs[12];     
            sad[5] <= sad[5] + abs[9];
            sad[6] <= sad[6] + abs[8];            
            sad[10] <= sad[10] + abs[5];
            sad[11] <= sad[11] + abs[4];
            sad[15] <= sad[15] + abs[1];
            sad[16] <= sad[16] + abs[0];            
        end
        6'd27:
        begin
            sad[0] <= sad[0] + abs[14];
            sad[1] <= sad[1] + abs[13];
            sad[2] <= sad[2] + abs[12]; 
            sad[5] <= sad[5] + abs[10];
            sad[6] <= sad[6] + abs[9];
            sad[7] <= sad[7] + abs[8];  
            sad[10] <= sad[10] + abs[6];
            sad[11] <= sad[11] + abs[5];
            sad[12] <= sad[12] + abs[4];           
            sad[15] <= sad[15] + abs[2];
            sad[16] <= sad[16] + abs[1];
            sad[17] <= sad[17] + abs[0];
        end
        6'd28:
        begin
            sad[0] <= sad[0] + abs[15];
            sad[1] <= sad[1] + abs[14];
            sad[2] <= sad[2] + abs[13];
            sad[3] <= sad[3] + abs[12];
            sad[5] <= sad[5] + abs[11];
            sad[6] <= sad[6] + abs[10];
            sad[7] <= sad[7] + abs[9];
            sad[8] <= sad[8] + abs[8];
            sad[10] <= sad[10] + abs[7];
            sad[11] <= sad[11] + abs[6];
            sad[12] <= sad[12] + abs[5];
            sad[13] <= sad[13] + abs[4];
            sad[15] <= sad[15] + abs[3];
            sad[16] <= sad[16] + abs[2];
            sad[17] <= sad[17] + abs[1];
            sad[18] <= sad[18] + abs[0];
        end
        6'd29:
        begin
            sad[1] <= sad[1] + abs[15];
            sad[2] <= sad[2] + abs[14];
            sad[3] <= sad[3] + abs[13];
            sad[4] <= sad[4] + abs[12];
            sad[6] <= sad[6] + abs[11];
            sad[7] <= sad[7] + abs[10];
            sad[8] <= sad[8] + abs[9];
            sad[9] <= sad[9] + abs[8];
            sad[11] <= sad[11] + abs[7];
            sad[12] <= sad[12] + abs[6];
            sad[13] <= sad[13] + abs[5];
            sad[14] <= sad[14] + abs[4];
            sad[16] <= sad[16] + abs[3];
            sad[17] <= sad[17] + abs[2];
            sad[18] <= sad[18] + abs[1];
            sad[19] <= sad[19] + abs[0];
        end 
        6'd30:
        begin
            sad[2] <= sad[2] + abs[15];
            sad[3] <= sad[3] + abs[14];
            sad[4] <= sad[4] + abs[13];   
            sad[7] <= sad[7] + abs[11];
            sad[8] <= sad[8] + abs[10];
            sad[9] <= sad[9] + abs[9];             
            sad[12] <= sad[12] + abs[7];
            sad[13] <= sad[13] + abs[6];
            sad[14] <= sad[14] + abs[5];            
            sad[17] <= sad[17] + abs[3];
            sad[18] <= sad[18] + abs[2];
            sad[19] <= sad[19] + abs[1];        
        end
        6'd31:
        begin
            sad[3] <= sad[3] + abs[15];
            sad[4] <= sad[4] + abs[14];
            sad[8] <= sad[8] + abs[11];
            sad[9] <= sad[9] + abs[10];
            sad[13] <= sad[13] + abs[7];
            sad[14] <= sad[14] + abs[6];
            sad[18] <= sad[18] + abs[3];
            sad[19] <= sad[19] + abs[2];
        end        
        6'd32:
        begin
            sad[4] <= sad[4] + abs[15]; 
            sad[9] <= sad[9] + abs[11]; 
            sad[14] <= sad[14] + abs[7];            
            sad[19] <= sad[19] + abs[3];
        end
      
        6'd33:
        begin
            sad[5] <= sad[5] + abs[12];
            sad[10] <= sad[10] + abs[8];
            sad[15] <= sad[15] + abs[4];
            sad[20] <= sad[20] + abs[0];             
        end
        6'd34:
        begin
            sad[5] <= sad[5] + abs[13];
            sad[6] <= sad[6] + abs[12];     
            sad[10] <= sad[10] + abs[9];
            sad[11] <= sad[11] + abs[8];            
            sad[15] <= sad[15] + abs[5];
            sad[16] <= sad[16] + abs[4];
            sad[20] <= sad[20] + abs[1];
            sad[21] <= sad[21] + abs[0];            
        end
        6'd35:
        begin
            sad[5] <= sad[5] + abs[14];
            sad[6] <= sad[6] + abs[13];
            sad[7] <= sad[7] + abs[12]; 
            sad[10] <= sad[10] + abs[10];
            sad[11] <= sad[11] + abs[9];
            sad[12] <= sad[12] + abs[8];  
            sad[15] <= sad[15] + abs[6];
            sad[16] <= sad[16] + abs[5];
            sad[17] <= sad[17] + abs[4];           
            sad[20] <= sad[20] + abs[2];
            sad[21] <= sad[21] + abs[1];
            sad[22] <= sad[22] + abs[0];
        end
        6'd36:
        begin
            sad[5] <= sad[5] + abs[15];
            sad[6] <= sad[6] + abs[14];
            sad[7] <= sad[7] + abs[13];
            sad[8] <= sad[8] + abs[12];
            sad[10] <= sad[10] + abs[11];
            sad[11] <= sad[11] + abs[10];
            sad[12] <= sad[12] + abs[9];
            sad[13] <= sad[13] + abs[8];
            sad[15] <= sad[15] + abs[7];
            sad[16] <= sad[16] + abs[6];
            sad[17] <= sad[17] + abs[5];
            sad[18] <= sad[18] + abs[4];
            sad[20] <= sad[20] + abs[3];
            sad[21] <= sad[21] + abs[2];
            sad[22] <= sad[22] + abs[1];
            sad[23] <= sad[23] + abs[0];
        end
        6'd37:
        begin
            sad[6] <= sad[6] + abs[15];
            sad[7] <= sad[7] + abs[14];
            sad[8] <= sad[8] + abs[13];
            sad[9] <= sad[9] + abs[12];
            sad[11] <= sad[11] + abs[11];
            sad[12] <= sad[12] + abs[10];
            sad[13] <= sad[13] + abs[9];
            sad[14] <= sad[14] + abs[8];
            sad[16] <= sad[16] + abs[7];
            sad[17] <= sad[17] + abs[6];
            sad[18] <= sad[18] + abs[5];
            sad[19] <= sad[19] + abs[4];
            sad[21] <= sad[21] + abs[3];
            sad[22] <= sad[22] + abs[2];
            sad[23] <= sad[23] + abs[1];
            sad[24] <= sad[24] + abs[0];
        end 
        6'd38:
        begin
            sad[7] <= sad[7] + abs[15];
            sad[8] <= sad[8] + abs[14];
            sad[9] <= sad[9] + abs[13];   
            sad[12] <= sad[12] + abs[11];
            sad[13] <= sad[13] + abs[10];
            sad[14] <= sad[14] + abs[9];             
            sad[17] <= sad[17] + abs[7];
            sad[18] <= sad[18] + abs[6];
            sad[19] <= sad[19] + abs[5];            
            sad[22] <= sad[22] + abs[3];
            sad[23] <= sad[23] + abs[2];
            sad[24] <= sad[24] + abs[1];        
        end
        6'd39:
        begin
            sad[8] <= sad[8] + abs[15];
            sad[9] <= sad[9] + abs[14];
            sad[13] <= sad[13] + abs[11];
            sad[14] <= sad[14] + abs[10];
            sad[18] <= sad[18] + abs[7];
            sad[19] <= sad[19] + abs[6];
            sad[23] <= sad[23] + abs[3];
            sad[24] <= sad[24] + abs[2];
        end        
        6'd40:
        begin
            sad[9] <= sad[9] + abs[15]; 
            sad[14] <= sad[14] + abs[11]; 
            sad[19] <= sad[19] + abs[7];            
            sad[24] <= sad[24] + abs[3];
        end

        6'd41:
        begin
            sad[10] <= sad[10] + abs[12];
            sad[15] <= sad[15] + abs[8];
            sad[20] <= sad[20] + abs[4];           
        end
        6'd42:
        begin
            sad[10] <= sad[10] + abs[13];
            sad[11] <= sad[11] + abs[12];     
            sad[15] <= sad[15] + abs[9];
            sad[16] <= sad[16] + abs[8];            
            sad[20] <= sad[20] + abs[5];
            sad[21] <= sad[21] + abs[4];      
        end
        6'd43:
        begin
            sad[10] <= sad[10] + abs[14];
            sad[11] <= sad[11] + abs[13];
            sad[12] <= sad[12] + abs[12]; 
            sad[15] <= sad[15] + abs[10];
            sad[16] <= sad[16] + abs[9];
            sad[17] <= sad[17] + abs[8];  
            sad[20] <= sad[20] + abs[6];
            sad[21] <= sad[21] + abs[5];
            sad[22] <= sad[22] + abs[4];           
        end
        6'd44:
        begin
            sad[10] <= sad[10] + abs[15];
            sad[11] <= sad[11] + abs[14];
            sad[12] <= sad[12] + abs[13];
            sad[13] <= sad[13] + abs[12];
            sad[15] <= sad[15] + abs[11];
            sad[16] <= sad[16] + abs[10];
            sad[17] <= sad[17] + abs[9];
            sad[18] <= sad[18] + abs[8];
            sad[20] <= sad[20] + abs[7];
            sad[21] <= sad[21] + abs[6];
            sad[22] <= sad[22] + abs[5];
            sad[23] <= sad[23] + abs[4];
        end
        6'd45:
        begin
            sad[11] <= sad[11] + abs[15];
            sad[12] <= sad[12] + abs[14];
            sad[13] <= sad[13] + abs[13];
            sad[14] <= sad[14] + abs[12];
            sad[16] <= sad[16] + abs[11];
            sad[17] <= sad[17] + abs[10];
            sad[18] <= sad[18] + abs[9];
            sad[19] <= sad[19] + abs[8];
            sad[21] <= sad[21] + abs[7];
            sad[22] <= sad[22] + abs[6];
            sad[23] <= sad[23] + abs[5];
            sad[24] <= sad[24] + abs[4];
        end 
        6'd46:
        begin
            sad[12] <= sad[12] + abs[15];
            sad[13] <= sad[13] + abs[14];
            sad[14] <= sad[14] + abs[13];   
            sad[17] <= sad[17] + abs[11];
            sad[18] <= sad[18] + abs[10];
            sad[19] <= sad[19] + abs[9];             
            sad[22] <= sad[22] + abs[7];
            sad[23] <= sad[23] + abs[6];
            sad[24] <= sad[24] + abs[5];            
 
        end
        6'd47:
        begin
            sad[13] <= sad[13] + abs[15];
            sad[14] <= sad[14] + abs[14];
            sad[18] <= sad[18] + abs[11];
            sad[19] <= sad[19] + abs[10];
            sad[23] <= sad[23] + abs[7];
            sad[24] <= sad[24] + abs[6];
        end        
        6'd48:
        begin
            sad[14] <= sad[14] + abs[15]; 
            sad[19] <= sad[19] + abs[11]; 
            sad[24] <= sad[24] + abs[7];            
        end

        6'd49:
        begin
            sad[15] <= sad[15] + abs[12];
            sad[20] <= sad[20] + abs[8];          
        end
        6'd50:
        begin
            sad[15] <= sad[15] + abs[13];
            sad[16] <= sad[16] + abs[12];     
            sad[20] <= sad[20] + abs[9];
            sad[21] <= sad[21] + abs[8];            
    
        end
        6'd51:
        begin
            sad[15] <= sad[15] + abs[14];
            sad[16] <= sad[16] + abs[13];
            sad[17] <= sad[17] + abs[12]; 
            sad[20] <= sad[20] + abs[10];
            sad[21] <= sad[21] + abs[9];
            sad[22] <= sad[22] + abs[8];          
        end
        6'd52:
        begin
            sad[15] <= sad[15] + abs[15];
            sad[16] <= sad[16] + abs[14];
            sad[17] <= sad[17] + abs[13];
            sad[18] <= sad[18] + abs[12];
            sad[20] <= sad[20] + abs[11];
            sad[21] <= sad[21] + abs[10];
            sad[22] <= sad[22] + abs[9];
            sad[23] <= sad[23] + abs[8];

        end
        6'd53:
        begin
            sad[16] <= sad[16] + abs[15];
            sad[17] <= sad[17] + abs[14];
            sad[18] <= sad[18] + abs[13];
            sad[19] <= sad[19] + abs[12];
            sad[21] <= sad[21] + abs[11];
            sad[22] <= sad[22] + abs[10];
            sad[23] <= sad[23] + abs[9];
            sad[24] <= sad[24] + abs[8];
        end 
        6'd54:
        begin
            sad[17] <= sad[17] + abs[15];
            sad[18] <= sad[18] + abs[14];
            sad[19] <= sad[19] + abs[13];   
            sad[22] <= sad[22] + abs[11];
            sad[23] <= sad[23] + abs[10];
            sad[24] <= sad[24] + abs[9];                       
 
        end
        6'd55:
        begin
            sad[18] <= sad[18] + abs[15];
            sad[19] <= sad[19] + abs[14];
            sad[23] <= sad[23] + abs[11];
            sad[24] <= sad[24] + abs[10];

        end        
        6'd56:
        begin
            sad[19] <= sad[19] + abs[15]; 
            sad[24] <= sad[24] + abs[11];         
        end

        6'd57:
        begin
            sad[20] <= sad[20] + abs[12];       
        end
        6'd58:
        begin
            sad[20] <= sad[20] + abs[13];
            sad[21] <= sad[21] + abs[12];     
        end
        6'd59:
        begin
            sad[20] <= sad[20] + abs[14];
            sad[21] <= sad[21] + abs[13];
            sad[22] <= sad[22] + abs[12]; 
         
        end
        6'd60:
        begin
            sad[20] <= sad[20] + abs[15];
            sad[21] <= sad[21] + abs[14];
            sad[22] <= sad[22] + abs[13];
            sad[23] <= sad[23] + abs[12];
        end
        6'd61:
        begin
            sad[21] <= sad[21] + abs[15];
            sad[22] <= sad[22] + abs[14];
            sad[23] <= sad[23] + abs[13];
            sad[24] <= sad[24] + abs[12];

        end 
        6'd62:
        begin
            sad[22] <= sad[22] + abs[15];
            sad[23] <= sad[23] + abs[14];
            sad[24] <= sad[24] + abs[13];                        
 
        end
        6'd63:
        begin
            sad[23] <= sad[23] + abs[15];
            sad[24] <= sad[24] + abs[14];

        end        
        // 6'd0:
        // begin
        //   //  sad[24] <= sad[24] + abs[15];      
        // end
        endcase
        end
        else if(block_valid)begin
            sad[0] <= 0;
            sad[1] <= 0;
            sad[2] <= 0;
            sad[3] <= 0;
            sad[4] <= 0;
            sad[5] <= 0;
            sad[6] <= 0;
            sad[7] <= 0;
            sad[8] <= 0;
            sad[9] <= 0;
            sad[10] <= 0;
            sad[11] <= 0;
            sad[12] <= 0;
            sad[13] <= 0;
            sad[14] <= 0;
            sad[15] <= 0;
            sad[16] <= 0;
            sad[17] <= 0;
            sad[18] <= 0;
            sad[19] <= 0;
            sad[20] <= 0;
            sad[21] <= 0;
            sad[22] <= 0;
            sad[23] <= 0;
            sad[24] <= 0;
        end
    end
end

always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        min_x <= 0;
        min_y <= 0;
        min <= 0;
    end
    else begin
        if(area_valid)begin
            case(count2)
                6'd28:
                begin
                    min <= sad[0]+abs[15];
                    min_x <= -2;
                    min_y <= 2; 
                end
                6'd29:
                begin
                    min <= (min < sad[1]+abs[15])? min : sad[1]+abs[15];
                    min_x <= (min < sad[1]+abs[15])? min_x : -1;
                end
                6'd30:
                begin
                    min <= (min < sad[2]+abs[15] )? min : sad[2]+abs[15];
                    min_x <= (min < sad[2]+abs[15] )? min_x : 0;                    
                end
                6'd31:
                begin
                    min <= (min < sad[3]+abs[15])? min : sad[3]+abs[15];
                    min_x <= (min < sad[3]+abs[15])? min_x : 1;                    
                end
                6'd32:
                begin
                    min <= (min < sad[4]+abs[15])? min : sad[4]+abs[15];
                    min_x <= (min < sad[4]+abs[15])? min_x : 2;                    
                end

                6'd36:
                begin
                    min <= (min < sad[5]+abs[15])? min : sad[5]+abs[15];
                    min_x <= (min < sad[5]+abs[15])? min_x : -2;     
                    min_y <= (min < sad[5]+abs[15])? min_y : 1;  
                end
                6'd37:
                begin
                    min <= (min < sad[6]+abs[15])? min : sad[6]+abs[15];
                    min_x <= (min < sad[6]+abs[15])? min_x : -1;     
                    min_y <= (min < sad[6]+abs[15])? min_y : 1;  
                end
                6'd38:
                begin
                    min <= (min < sad[7]+abs[15])? min : sad[7]+abs[15];
                    min_x <= (min < sad[7]+abs[15])? min_x : 0;     
                    min_y <= (min < sad[7]+abs[15])? min_y : 1;  
                end
                6'd39:
                begin
                    min <= (min < sad[8]+abs[15])? min : sad[8]+abs[15];
                    min_x <= (min < sad[8]+abs[15])? min_x : 1;     
                    min_y <= (min < sad[8]+abs[15])? min_y : 1;  
                end
                6'd40:
                begin
                    min <= (min < sad[9]+abs[15])? min : sad[9]+abs[15];
                    min_x <= (min < sad[9]+abs[15])? min_x : 2;     
                    min_y <= (min < sad[9]+abs[15])? min_y : 1;  
                end
                6'd44:
                begin
                    min <= (min < sad[10]+abs[15])? min : sad[10]+abs[15];
                    min_x <= (min < sad[10]+abs[15])? min_x : -2;     
                    min_y <= (min < sad[10]+abs[15])? min_y : 0;  
                end
                6'd45:
                begin
                    min <= (min < sad[11]+abs[15])? min : sad[11]+abs[15];
                    min_x <= (min < sad[11]+abs[15])? min_x : -1;     
                    min_y <= (min < sad[11]+abs[15])? min_y : 0;  
                end
                6'd46:
                begin
                    min <= (min < sad[12]+abs[15])? min : sad[12]+abs[15];
                    min_x <= (min < sad[12]+abs[15])? min_x : 0;     
                    min_y <= (min < sad[12]+abs[15])? min_y : 0;  
                end
                6'd47:
                begin
                    min <= (min < sad[13]+abs[15])? min : sad[13]+abs[15];
                    min_x <= (min < sad[13]+abs[15])? min_x : 1;     
                    min_y <= (min < sad[13]+abs[15])? min_y : 0;  
                end
                6'd48:
                begin
                    min <= (min < sad[14]+abs[15])? min : sad[14]+abs[15];
                    min_x <= (min < sad[14]+abs[15])? min_x : 2;     
                    min_y <= (min < sad[14]+abs[15])? min_y : 0;  
                end


                6'd52:
                begin
                    min <= (min < sad[15]+abs[15])? min : sad[15]+abs[15];
                    min_x <= (min < sad[15]+abs[15])? min_x : -2;     
                    min_y <= (min < sad[15]+abs[15])? min_y : -1;  
                end
                6'd53:
                begin
                    min <= (min < sad[16]+abs[15])? min : sad[16]+abs[15];
                    min_x <= (min < sad[16]+abs[15])? min_x : -1;     
                    min_y <= (min < sad[16]+abs[15])? min_y : -1;  
                end
                6'd54:
                begin
                    min <= (min < sad[17]+abs[15])? min : sad[17]+abs[15];
                    min_x <= (min < sad[17]+abs[15])? min_x : 0;     
                    min_y <= (min < sad[17]+abs[15])? min_y : -1;  
                end
                6'd55:
                begin
                    min <= (min < sad[18]+abs[15])? min : sad[18]+abs[15];
                    min_x <= (min < sad[18]+abs[15])? min_x : 1;     
                    min_y <= (min < sad[18]+abs[15])? min_y : -1;  
                end
                6'd56:
                begin
                    min <= (min < sad[19]+abs[15])? min : sad[19]+abs[15];
                    min_x <= (min < sad[19]+abs[15])? min_x : 2;     
                    min_y <= (min < sad[19]+abs[15])? min_y : -1;  
                end


                6'd60:
                begin
                    min <= (min < sad[20]+abs[15])? min : sad[20]+abs[15];
                    min_x <= (min < sad[20]+abs[15])? min_x : -2;     
                    min_y <= (min < sad[20]+abs[15])? min_y : -2;  
                end
                6'd61:
                begin
                    min <= (min < sad[21]+abs[15])? min : sad[21]+abs[15];
                    min_x <= (min < sad[21]+abs[15])? min_x : -1;     
                    min_y <= (min < sad[21]+abs[15])? min_y : -2;  
                end
                6'd62:
                begin
                    min <= (min < sad[22]+abs[15])? min : sad[22]+abs[15];
                    min_x <= (min < sad[22]+abs[15])? min_x : 0;     
                    min_y <= (min < sad[22]+abs[15])? min_y : -2;  
                end
                6'd63:
                begin
                    min <= (min < sad[23]+abs[15])? min : sad[23]+abs[15];
                    min_x <= (min < sad[23]+abs[15])? min_x : 1;     
                    min_y <= (min < sad[23]+abs[15])? min_y : -2;  
                end


                default:
                begin
                    min <= min;
                    min_x <= min_x;
                    min_y <= min_y;
                end
            endcase
        end
    end
end

always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        out_valid <= 0;
        out_temp <= 0;
        out_vector <= 0;
    end
    else begin
        if(count2 == 63)begin
            out_temp <= 2;
        end
        else 
            begin
                if(out_temp == 2)begin
                    out_valid <= 1;
                    out_vector <= (min < sad[24]+abs[15])? min_x : 2;
                    out_temp <= out_temp - 1;
                end
                else if(out_temp == 1)begin
                    out_valid <= 1;
                    out_vector <=  (min < sad[24]+abs[15])? min_y : -2;
                    out_temp <= out_temp  - 1;
                end
                else begin
                    out_valid <=0;
                    out_vector <= 0;
                    out_temp <=out_temp;
                end
        end
    end
end

endmodule