module axi_sva(
  tvip_axi_if axi0,
  tvip_axi_if axi1,
  tvip_axi_if axi2
);

//wire         arb_en       =  tb_top.u_ddr3_reg.arb_mode[0];
//wire   [1:0] arb_mode     =  tb_top.u_ddr3_reg.arb_mode[2:1];
wire            arb_en     =  'd1;
//wire     [1:0]  arb_mode   =  'd0;
wire     [1:0]  arb_mode   =  'd1;
//wire     [1:0]  arb_mode   =  'd2;

wire   [15:0]    weight_setting0  = tb_top.u_ddr3_reg.WEIGHT_SETTING0[15:0];
wire   [15:0]    weight_setting1  = tb_top.u_ddr3_reg.WEIGHT_SETTING1[15:0];
wire   [15:0]    weight_setting2  = tb_top.u_ddr3_reg.WEIGHT_SETTING2[15:0];


wire clk      = axi0.aclk    ;
wire rst_n    = axi0.areset_n    ;

wire waready0 = axi0.awready  ;
wire waready1 = axi1.awready  ;
wire waready2 = axi2.awready  ;

wire wavalid0 =  axi0.awvalid ;
wire wavalid1 =  axi1.awvalid ;
wire wavalid2 =  axi2.awvalid ;

wire wasuc0 = axi0.awready && axi0.awvalid ;
wire wasuc1 = axi1.awready && axi1.awvalid ;
wire wasuc2 = axi2.awready && axi2.awvalid ;

reg  wavalid0_dly  ;
reg  wavalid1_dly  ;
reg  wavalid2_dly  ;

reg   [16:0]  axi0_wacnt ;
reg   [16:0]  axi1_wacnt ;
reg   [16:0]  axi2_wacnt ;

/////////////////////////////////////////////////////////////////////////
//
always @ (posedge clk or negedge rst_n)
begin
	if (~rst_n) begin
		axi0_wacnt <= 'd0 ;
	end
	else if (wasuc0&&arb_en) begin
		axi0_wacnt <= axi0_wacnt + 'd1 ;		
	end
	else if (wasuc1||wasuc2) begin
		axi0_wacnt <= 'd0 ;
	end
end

always @ (posedge clk or negedge rst_n)
begin
	if (~rst_n) begin
		axi1_wacnt <= 'd0 ;
	end
	else if (wasuc1&&arb_en) begin
		axi1_wacnt <= axi1_wacnt + 'd1 ;		
	end
	else if (wasuc0||wasuc2) begin
		axi1_wacnt <= 'd0 ;
	end
end

always @ (posedge clk or negedge rst_n)
begin
	if (~rst_n) begin
		axi2_wacnt <= 'd0 ;
	end
	else if (wasuc2&&arb_en) begin
		axi2_wacnt <= axi2_wacnt + 'd1 ;		
	end
	else if (wasuc1||wasuc0) begin
		axi2_wacnt <= 'd0 ;
	end
end

//wavalid0_dly
always @ (posedge clk or negedge rst_n)
begin
	if (~rst_n) begin
		wavalid0_dly <= 'd0 ;
		wavalid1_dly <= 'd0 ;
		wavalid2_dly <= 'd0 ;
	end
	else begin
		wavalid0_dly <=  wavalid0 ;
		wavalid1_dly <=  wavalid1 ;
		wavalid2_dly <=  wavalid2 ;
	end
end

/////////////////////////////////////////////////////////////////////////



//property pmode1;
//	@(posedge clk)  wasuc0 |-> ##[1:$]  (wasuc1&&~wasuc0&&~wasuc2)   ##[0:$] (wasuc2&&~wasuc0&&~wasuc1) ;
//endproperty

property perror;
	@(posedge clk)    (  !( (wasuc1&&wasuc0) || (wasuc2&&wasuc1) || (wasuc2&&wasuc0)  )  ) ;
endproperty


//amode1 : assert property(pmode1)
//	$display("amode1 correct!!!");
//else
//	$display("amode1 fail!!!");


aerror : assert property(perror);
//	$display("aerror  fail!!!");

/////////////////////////////////////////////////////////////////////////
property pnarbitor;
	@(posedge clk)    (~arb_en)  ?  ((!wasuc1)&&(!wasuc2)) : 1    ;
endproperty
anarbitor : assert property(pnarbitor);
/////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
property pmode0_0;
	@(posedge clk)   ((arb_mode=='d0)&&arb_en)  ?  (!( wavalid0 && (wasuc1||wasuc2))) : 1    ;
endproperty
property pmode0_1;
	@(posedge clk)   ((arb_mode=='d0)&&arb_en)  ?  (!( wavalid1 && (wasuc2))) : 1    ;
endproperty
amode0_0 : assert property(pmode0_0);
amode0_1 : assert property(pmode0_1);

/////////////////////////////////////////////////////////////////////////
property pmode1_0;
	@(posedge clk)   ((arb_mode=='d1)&&arb_en)  ?  (!( wavalid0_dly&&(  ((axi1_wacnt>1)&&wasuc1)  || ((axi2_wacnt>1)&&wasuc2) )  )) : 1    ;
endproperty
property pmode1_1;
	@(posedge clk)   ((arb_mode=='d1)&&arb_en)  ?  (!( wavalid1_dly&&(  ((axi0_wacnt>1)&&wasuc0)  || ((axi2_wacnt>1)&&wasuc2) )  )) : 1    ;
endproperty
property pmode1_2;
	@(posedge clk)   ((arb_mode=='d1)&&arb_en)  ?  (!( wavalid2_dly&&(  ((axi0_wacnt>1)&&wasuc0)  || ((axi1_wacnt>1)&&wasuc1) )  )) : 1    ;
endproperty
amode1_0 : assert property(pmode1_0 );
amode1_1 : assert property(pmode1_1 );
amode1_2 : assert property(pmode1_2 );
/////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
property pmode2_0;
	@(posedge clk)   ((arb_mode=='d2)&&arb_en)  ?  (!( wavalid0_dly&&(  ((axi1_wacnt>weight_setting1)&&wasuc1)  || ((axi2_wacnt>weight_setting2)&&wasuc2) )  )) : 1    ;
endproperty
property pmode2_1;
	@(posedge clk)   ((arb_mode=='d2)&&arb_en)  ?  (!( wavalid1_dly&&(  ((axi0_wacnt>weight_setting0)&&wasuc0)  || ((axi2_wacnt>weight_setting2)&&wasuc2) )  )) : 1    ;
endproperty
property pmode2_2;
	@(posedge clk)   ((arb_mode=='d2)&&arb_en)  ?  (!( wavalid2_dly&&(  ((axi0_wacnt>weight_setting0)&&wasuc0)  || ((axi1_wacnt>weight_setting1)&&wasuc1) )  )) : 1    ;
endproperty
amode2_0 : assert property(pmode2_0 );
amode2_1 : assert property(pmode2_1 );
amode2_2 : assert property(pmode2_2 );
/////////////////////////////////////////////////////////////////////////

endmodule

