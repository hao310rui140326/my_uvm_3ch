module assoc_mem(
clk    ,
rst_n  ,
wen0   ,
wdin0  ,
wb0    ,
ren0   ,
waddr0 ,
raddr0 ,
rvld0  ,
rdout0 ,

wen1   ,
wdin1  ,
wb1    ,
ren1   ,
waddr1 ,
raddr1 ,
rvld1  ,
rdout1 ,

wen2   ,
wdin2  ,
wb2    ,
ren2   ,
waddr2 ,
raddr2 ,
rvld2  ,
rdout2 

);

 parameter MEM_ROW_ADDR_WIDTH   = 15         ;
 parameter MEM_COL_ADDR_WIDTH   = 10         ;
 parameter MEM_BADDR_WIDTH      = 3          ;
 parameter MEM_DQ_WIDTH         =  32        ;
 parameter MEM_DM_WIDTH         =  32/8      ;
 parameter MEM_DQS_WIDTH        =  32/8      ;
 parameter CTRL_ADDR_WIDTH     = MEM_ROW_ADDR_WIDTH + MEM_COL_ADDR_WIDTH + MEM_BADDR_WIDTH        ;

input         clk   ;
input         rst_n ;

input         wen0   ;
input         ren0   ;
input  [  MEM_DQ_WIDTH*8-1:0] wdin0   ;
input  [MEM_DQ_WIDTH*8/8-1:0] wb0     ;
input  [ CTRL_ADDR_WIDTH-1:0] waddr0  ;
input  [ CTRL_ADDR_WIDTH-1:0] raddr0  ;
output [  MEM_DQ_WIDTH*8-1:0] rdout0  ;
output                        rvld0   ;

input         wen1   ;
input         ren1   ;
input  [  MEM_DQ_WIDTH*8-1:0] wdin1   ;
input  [MEM_DQ_WIDTH*8/8-1:0] wb1     ;
input  [ CTRL_ADDR_WIDTH-1:0] waddr1  ;
input  [ CTRL_ADDR_WIDTH-1:0] raddr1  ;
output [  MEM_DQ_WIDTH*8-1:0] rdout1  ;
output                        rvld1   ;

input         wen2   ;
input         ren2   ;
input  [  MEM_DQ_WIDTH*8-1:0] wdin2   ;
input  [MEM_DQ_WIDTH*8/8-1:0] wb2     ;
input  [ CTRL_ADDR_WIDTH-1:0] waddr2  ;
input  [ CTRL_ADDR_WIDTH-1:0] raddr2  ;
output [  MEM_DQ_WIDTH*8-1:0] rdout2  ;
output                        rvld2   ;

////////////////////////////////////////////////////
reg    [  MEM_DQ_WIDTH*8-1:0] rdout0  ;
reg    [  MEM_DQ_WIDTH*8-1:0] rdout1  ;
reg    [  MEM_DQ_WIDTH*8-1:0] rdout2  ;
reg                           rvld0   ;
reg                           rvld1   ;
reg                           rvld2   ;
reg    [31:0]                 rvld_cnt0   ;
reg    [31:0]                 rvld_cnt1   ;
reg    [31:0]                 rvld_cnt2   ;
////////////////////////////////////////////////////

//bit [ MEM_DQ_WIDTH*8-1:0]  assoc[bit[63:0]],idx=1;
bit [ MEM_DQ_WIDTH*8-1:0]  assoc[bit[CTRL_ADDR_WIDTH-1:0]];
//bit [ MEM_DQ_WIDTH*8-1:0]  assoc[4096];

bit [ MEM_DQ_WIDTH*8-1:0]  assoc_mem0;
bit [ MEM_DQ_WIDTH*8-1:0]  assoc_mem1;
bit [ MEM_DQ_WIDTH*8-1:0]  assoc_mem2;

always @(*)
begin
	assoc_mem0 = assoc[waddr0];
	assoc_mem1 = assoc[waddr1];
	assoc_mem2 = assoc[waddr2];
	for (int i=0;i<MEM_DQ_WIDTH*8/8;i++) begin
		if (wen0&&wb0[i])	assoc_mem0[i*8+:8] = wdin0[i*8+:8];
		if (wen1&&wb1[i])	assoc_mem1[i*8+:8] = wdin1[i*8+:8];
		if (wen2&&wb2[i])	assoc_mem2[i*8+:8] = wdin2[i*8+:8];
	end
end


always @ (posedge clk or negedge rst_n)
begin
	if (wen0) begin
		assoc[waddr0]<=assoc_mem0;
	end
	if (wen1) begin
		assoc[waddr1]<=assoc_mem1;
	end
	if (wen2) begin
		assoc[waddr2]<=assoc_mem2;
	end
end

always @ (posedge clk or negedge rst_n)
begin
	if (ren0) begin
		rdout0<=assoc[raddr0];
	end
	if (ren1) begin
		rdout1<=assoc[raddr1];
	end
	if (ren2) begin
		rdout2<=assoc[raddr2];
	end
end


always @ (posedge clk or negedge rst_n)
begin
	rvld0 <= ren0 ; 
	rvld1 <= ren1 ; 
	rvld2 <= ren2 ; 
end

//rvld_cnt
always @ (posedge clk or negedge rst_n)
begin
	if (~rst_n) begin
		rvld_cnt0 <= 'd0 ;
	end
	else if (rvld0) begin
		rvld_cnt0 <= rvld_cnt0 + 'd1 ;
	end
end
always @ (posedge clk or negedge rst_n)
begin
	if (~rst_n) begin
		rvld_cnt1 <= 'd0 ;
	end
	else if (rvld1) begin
		rvld_cnt1 <= rvld_cnt1 + 'd1 ;
	end
end
always @ (posedge clk or negedge rst_n)
begin
	if (~rst_n) begin
		rvld_cnt2 <= 'd0 ;
	end
	else if (rvld2) begin
		rvld_cnt2 <= rvld_cnt2 + 'd1 ;
	end
end


endmodule



