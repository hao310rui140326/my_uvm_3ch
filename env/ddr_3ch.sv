module ddr_3ch(/*AUTOARG*/
   // Outputs
   pll_lock, debug_data, debug_calib_ctrl, ddrphy_cpd_lock,
   ddr_init_done, core_clk, axi_slv2_wusero_last, axi_slv2_wusero_id,
   axi_slv2_wready, axi_slv2_rvalid, axi_slv2_rlast, axi_slv2_rid,
   axi_slv2_rdata, axi_slv2_awready, axi_slv2_arready,
   axi_slv1_wusero_last, axi_slv1_wusero_id, axi_slv1_wready,
   axi_slv1_rvalid, axi_slv1_rlast, axi_slv1_rid, axi_slv1_rdata,
   axi_slv1_awready, axi_slv1_arready, axi_slv0_wusero_last,
   axi_slv0_wusero_id, axi_slv0_wready, axi_slv0_rvalid,
   axi_slv0_rlast, axi_slv0_rid, axi_slv0_rdata, axi_slv0_awready,
   axi_slv0_arready, apb_ready, apb_rdata,
   // Inputs
   resetn, ref_clk, axi_slv2_wstrb, axi_slv2_wdata, axi_slv2_awvalid,
   axi_slv2_awuser_id, axi_slv2_awuser_ap, axi_slv2_awlen,
   axi_slv2_awaddr, axi_slv2_arvalid, axi_slv2_aruser_id,
   axi_slv2_aruser_ap, axi_slv2_arlen, axi_slv2_araddr,
   axi_slv1_wstrb, axi_slv1_wdata, axi_slv1_awvalid,
   axi_slv1_awuser_id, axi_slv1_awuser_ap, axi_slv1_awlen,
   axi_slv1_awaddr, axi_slv1_arvalid, axi_slv1_aruser_id,
   axi_slv1_aruser_ap, axi_slv1_arlen, axi_slv1_araddr,
   axi_slv0_wstrb, axi_slv0_wdata, axi_slv0_awvalid,
   axi_slv0_awuser_id, axi_slv0_awuser_ap, axi_slv0_awlen,
   axi_slv0_awaddr, axi_slv0_arvalid, axi_slv0_aruser_id,
   axi_slv0_aruser_ap, axi_slv0_arlen, axi_slv0_araddr, apb_write,
   apb_wdata, apb_sel, apb_rst_n, apb_enable, apb_clk, apb_addr
   );

  parameter MEM_ROW_ADDR_WIDTH   = 15         ;
  parameter MEM_COL_ADDR_WIDTH   = 10         ;
  parameter MEM_BADDR_WIDTH      = 3          ;
  parameter MEM_DQ_WIDTH         =  32        ;
  parameter MEM_DQS_WIDTH        =  32/8      ;
  parameter CTRL_ADDR_WIDTH = MEM_ROW_ADDR_WIDTH + MEM_BADDR_WIDTH + MEM_COL_ADDR_WIDTH;
  parameter TH_1S = 27'd33000000;

`ifdef SIMULATION
parameter MEM_SPACE_AW = 13; //to reduce simulation time
`else
parameter MEM_SPACE_AW = CTRL_ADDR_WIDTH;
`endif

/*AUTOINPUT*/
// Beginning of automatic inputs (from unused autoinst inputs)
input [7:0]		apb_addr;		// To u_ddr_0 of ddr_wrapper.v, ...
input			apb_clk;		// To u_ddr_0 of ddr_wrapper.v, ...
input			apb_enable;		// To u_ddr_0 of ddr_wrapper.v
input			apb_rst_n;		// To u_ddr_0 of ddr_wrapper.v, ...
input			apb_sel;		// To u_ddr_0 of ddr_wrapper.v
input [15:0]		apb_wdata;		// To u_ddr_0 of ddr_wrapper.v, ...
input			apb_write;		// To u_ddr_0 of ddr_wrapper.v, ...
input [CTRL_ADDR_WIDTH-1:0] axi_slv0_araddr;	// To u_ddr_0 of ddr_wrapper.v
input [3:0]		axi_slv0_arlen;		// To u_ddr_0 of ddr_wrapper.v
input			axi_slv0_aruser_ap;	// To u_ddr_0 of ddr_wrapper.v
input [3:0]		axi_slv0_aruser_id;	// To u_ddr_0 of ddr_wrapper.v
input			axi_slv0_arvalid;	// To u_ddr_0 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi_slv0_awaddr;	// To u_ddr_0 of ddr_wrapper.v
input [3:0]		axi_slv0_awlen;		// To u_ddr_0 of ddr_wrapper.v
input			axi_slv0_awuser_ap;	// To u_ddr_0 of ddr_wrapper.v
input [3:0]		axi_slv0_awuser_id;	// To u_ddr_0 of ddr_wrapper.v
input			axi_slv0_awvalid;	// To u_ddr_0 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8-1:0] axi_slv0_wdata;	// To u_ddr_0 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8/8-1:0] axi_slv0_wstrb;	// To u_ddr_0 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi_slv1_araddr;	// To u_ddr_1 of ddr_wrapper.v
input [3:0]		axi_slv1_arlen;		// To u_ddr_1 of ddr_wrapper.v
input			axi_slv1_aruser_ap;	// To u_ddr_1 of ddr_wrapper.v
input [3:0]		axi_slv1_aruser_id;	// To u_ddr_1 of ddr_wrapper.v
input			axi_slv1_arvalid;	// To u_ddr_1 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi_slv1_awaddr;	// To u_ddr_1 of ddr_wrapper.v
input [3:0]		axi_slv1_awlen;		// To u_ddr_1 of ddr_wrapper.v
input			axi_slv1_awuser_ap;	// To u_ddr_1 of ddr_wrapper.v
input [3:0]		axi_slv1_awuser_id;	// To u_ddr_1 of ddr_wrapper.v
input			axi_slv1_awvalid;	// To u_ddr_1 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8-1:0] axi_slv1_wdata;	// To u_ddr_1 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8/8-1:0] axi_slv1_wstrb;	// To u_ddr_1 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi_slv2_araddr;	// To u_ddr_2 of ddr_wrapper.v
input [3:0]		axi_slv2_arlen;		// To u_ddr_2 of ddr_wrapper.v
input			axi_slv2_aruser_ap;	// To u_ddr_2 of ddr_wrapper.v
input [3:0]		axi_slv2_aruser_id;	// To u_ddr_2 of ddr_wrapper.v
input			axi_slv2_arvalid;	// To u_ddr_2 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi_slv2_awaddr;	// To u_ddr_2 of ddr_wrapper.v
input [3:0]		axi_slv2_awlen;		// To u_ddr_2 of ddr_wrapper.v
input			axi_slv2_awuser_ap;	// To u_ddr_2 of ddr_wrapper.v
input [3:0]		axi_slv2_awuser_id;	// To u_ddr_2 of ddr_wrapper.v
input			axi_slv2_awvalid;	// To u_ddr_2 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8-1:0] axi_slv2_wdata;	// To u_ddr_2 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8/8-1:0] axi_slv2_wstrb;	// To u_ddr_2 of ddr_wrapper.v
input			ref_clk;		// To u_ddr_0 of ddr_wrapper.v, ...
input			resetn;			// To u_ddr_0 of ddr_wrapper.v, ...
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output [15:0]		apb_rdata;		// From u_ddr_0 of ddr_wrapper.v
output			apb_ready;		// From u_ddr_0 of ddr_wrapper.v
output			axi_slv0_arready;	// From u_ddr_0 of ddr_wrapper.v
output			axi_slv0_awready;	// From u_ddr_0 of ddr_wrapper.v
output [MEM_DQ_WIDTH*8-1:0] axi_slv0_rdata;	// From u_ddr_0 of ddr_wrapper.v
output [3:0]		axi_slv0_rid;		// From u_ddr_0 of ddr_wrapper.v
output			axi_slv0_rlast;		// From u_ddr_0 of ddr_wrapper.v
output			axi_slv0_rvalid;	// From u_ddr_0 of ddr_wrapper.v
output			axi_slv0_wready;	// From u_ddr_0 of ddr_wrapper.v
output [3:0]		axi_slv0_wusero_id;	// From u_ddr_0 of ddr_wrapper.v
output			axi_slv0_wusero_last;	// From u_ddr_0 of ddr_wrapper.v
output			axi_slv1_arready;	// From u_ddr_1 of ddr_wrapper.v
output			axi_slv1_awready;	// From u_ddr_1 of ddr_wrapper.v
output [MEM_DQ_WIDTH*8-1:0] axi_slv1_rdata;	// From u_ddr_1 of ddr_wrapper.v
output [3:0]		axi_slv1_rid;		// From u_ddr_1 of ddr_wrapper.v
output			axi_slv1_rlast;		// From u_ddr_1 of ddr_wrapper.v
output			axi_slv1_rvalid;	// From u_ddr_1 of ddr_wrapper.v
output			axi_slv1_wready;	// From u_ddr_1 of ddr_wrapper.v
output [3:0]		axi_slv1_wusero_id;	// From u_ddr_1 of ddr_wrapper.v
output			axi_slv1_wusero_last;	// From u_ddr_1 of ddr_wrapper.v
output			axi_slv2_arready;	// From u_ddr_2 of ddr_wrapper.v
output			axi_slv2_awready;	// From u_ddr_2 of ddr_wrapper.v
output [MEM_DQ_WIDTH*8-1:0] axi_slv2_rdata;	// From u_ddr_2 of ddr_wrapper.v
output [3:0]		axi_slv2_rid;		// From u_ddr_2 of ddr_wrapper.v
output			axi_slv2_rlast;		// From u_ddr_2 of ddr_wrapper.v
output			axi_slv2_rvalid;	// From u_ddr_2 of ddr_wrapper.v
output			axi_slv2_wready;	// From u_ddr_2 of ddr_wrapper.v
output [3:0]		axi_slv2_wusero_id;	// From u_ddr_2 of ddr_wrapper.v
output			axi_slv2_wusero_last;	// From u_ddr_2 of ddr_wrapper.v
output			core_clk;		// From u_ddr_0 of ddr_wrapper.v
output			ddr_init_done;		// From u_ddr_0 of ddr_wrapper.v
output			ddrphy_cpd_lock;	// From u_ddr_0 of ddr_wrapper.v
output [29:0]		debug_calib_ctrl;	// From u_ddr_0 of ddr_wrapper.v
output [66*MEM_DQS_WIDTH-1:0] debug_data;	// From u_ddr_0 of ddr_wrapper.v
output			pll_lock;		// From u_ddr_0 of ddr_wrapper.v
// End of automatics
/*AUTOWIRE*/



/* ddr_wrapper AUTO_TEMPLATE(
	.axi\(.*\) (axi_slv@\1[]),
);*/

ddr_wrapper #(
   .MEM_ROW_ADDR_WIDTH (MEM_ROW_ADDR_WIDTH),
   .MEM_COL_ADDR_WIDTH (MEM_COL_ADDR_WIDTH),
   .MEM_BADDR_WIDTH    (MEM_BADDR_WIDTH),
   .MEM_DQ_WIDTH       (MEM_DQ_WIDTH),
   .MEM_DM_WIDTH       (MEM_DQS_WIDTH),
   .MEM_DQS_WIDTH      (MEM_DQS_WIDTH),
   .CTRL_ADDR_WIDTH    (CTRL_ADDR_WIDTH)
  )u_ddr_0(
	/*AUTOINST*/
	   // Outputs
	   .apb_rdata			(apb_rdata[15:0]),
	   .apb_ready			(apb_ready),
	   .axi_arready			(axi_slv0_arready),	 // Templated
	   .axi_awready			(axi_slv0_awready),	 // Templated
	   .axi_rdata			(axi_slv0_rdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_rid			(axi_slv0_rid[3:0]),	 // Templated
	   .axi_rlast			(axi_slv0_rlast),	 // Templated
	   .axi_rvalid			(axi_slv0_rvalid),	 // Templated
	   .axi_wready			(axi_slv0_wready),	 // Templated
	   .axi_wusero_id		(axi_slv0_wusero_id[3:0]), // Templated
	   .axi_wusero_last		(axi_slv0_wusero_last),	 // Templated
	   .core_clk			(core_clk),
	   .ddr_init_done		(ddr_init_done),
	   .ddrphy_cpd_lock		(ddrphy_cpd_lock),
	   .debug_calib_ctrl		(debug_calib_ctrl[29:0]),
	   .debug_data			(debug_data[66*MEM_DQS_WIDTH-1:0]),
	   .pll_lock			(pll_lock),
	   // Inputs
	   .apb_addr			(apb_addr[7:0]),
	   .apb_clk			(apb_clk),
	   .apb_enable			(apb_enable),
	   .apb_rst_n			(apb_rst_n),
	   .apb_sel			(apb_sel),
	   .apb_wdata			(apb_wdata[15:0]),
	   .apb_write			(apb_write),
	   .axi_araddr			(axi_slv0_araddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_arlen			(axi_slv0_arlen[3:0]),	 // Templated
	   .axi_aruser_ap		(axi_slv0_aruser_ap),	 // Templated
	   .axi_aruser_id		(axi_slv0_aruser_id[3:0]), // Templated
	   .axi_arvalid			(axi_slv0_arvalid),	 // Templated
	   .axi_awaddr			(axi_slv0_awaddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_awlen			(axi_slv0_awlen[3:0]),	 // Templated
	   .axi_awuser_ap		(axi_slv0_awuser_ap),	 // Templated
	   .axi_awuser_id		(axi_slv0_awuser_id[3:0]), // Templated
	   .axi_awvalid			(axi_slv0_awvalid),	 // Templated
	   .axi_wdata			(axi_slv0_wdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_wstrb			(axi_slv0_wstrb[MEM_DQ_WIDTH*8/8-1:0]), // Templated
	   .ref_clk			(ref_clk),
	   .resetn			(resetn));

ddr_wrapper #(
   .MEM_ROW_ADDR_WIDTH (MEM_ROW_ADDR_WIDTH),
   .MEM_COL_ADDR_WIDTH (MEM_COL_ADDR_WIDTH),
   .MEM_BADDR_WIDTH    (MEM_BADDR_WIDTH),
   .MEM_DQ_WIDTH       (MEM_DQ_WIDTH),
   .MEM_DM_WIDTH       (MEM_DQS_WIDTH),
   .MEM_DQS_WIDTH      (MEM_DQS_WIDTH),
   .CTRL_ADDR_WIDTH    (CTRL_ADDR_WIDTH)
  )u_ddr_1(
	   .core_clk			(),
	   .ddr_init_done		(),
	   .ddrphy_cpd_lock		(),
	   .debug_calib_ctrl		(),
	   .debug_data			(),
	   .pll_lock			(),
	   .apb_rdata			(),
	   .apb_ready			(),
	   .apb_enable			(1'd0),
	   .apb_sel			(1'd0),
	/*AUTOINST*/
	   // Outputs
	   .axi_arready			(axi_slv1_arready),	 // Templated
	   .axi_awready			(axi_slv1_awready),	 // Templated
	   .axi_rdata			(axi_slv1_rdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_rid			(axi_slv1_rid[3:0]),	 // Templated
	   .axi_rlast			(axi_slv1_rlast),	 // Templated
	   .axi_rvalid			(axi_slv1_rvalid),	 // Templated
	   .axi_wready			(axi_slv1_wready),	 // Templated
	   .axi_wusero_id		(axi_slv1_wusero_id[3:0]), // Templated
	   .axi_wusero_last		(axi_slv1_wusero_last),	 // Templated
	   // Inputs
	   .apb_addr			(apb_addr[7:0]),
	   .apb_clk			(apb_clk),
	   .apb_rst_n			(apb_rst_n),
	   .apb_wdata			(apb_wdata[15:0]),
	   .apb_write			(apb_write),
	   .axi_araddr			(axi_slv1_araddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_arlen			(axi_slv1_arlen[3:0]),	 // Templated
	   .axi_aruser_ap		(axi_slv1_aruser_ap),	 // Templated
	   .axi_aruser_id		(axi_slv1_aruser_id[3:0]), // Templated
	   .axi_arvalid			(axi_slv1_arvalid),	 // Templated
	   .axi_awaddr			(axi_slv1_awaddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_awlen			(axi_slv1_awlen[3:0]),	 // Templated
	   .axi_awuser_ap		(axi_slv1_awuser_ap),	 // Templated
	   .axi_awuser_id		(axi_slv1_awuser_id[3:0]), // Templated
	   .axi_awvalid			(axi_slv1_awvalid),	 // Templated
	   .axi_wdata			(axi_slv1_wdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_wstrb			(axi_slv1_wstrb[MEM_DQ_WIDTH*8/8-1:0]), // Templated
	   .ref_clk			(ref_clk),
	   .resetn			(resetn));

ddr_wrapper #(
   .MEM_ROW_ADDR_WIDTH (MEM_ROW_ADDR_WIDTH),
   .MEM_COL_ADDR_WIDTH (MEM_COL_ADDR_WIDTH),
   .MEM_BADDR_WIDTH    (MEM_BADDR_WIDTH),
   .MEM_DQ_WIDTH       (MEM_DQ_WIDTH),
   .MEM_DM_WIDTH       (MEM_DQS_WIDTH),
   .MEM_DQS_WIDTH      (MEM_DQS_WIDTH),
   .CTRL_ADDR_WIDTH    (CTRL_ADDR_WIDTH)
  )u_ddr_2(
	   .core_clk			(),
	   .ddr_init_done		(),
	   .ddrphy_cpd_lock		(),
	   .debug_calib_ctrl		(),
	   .debug_data			(),
	   .pll_lock			(),
	   .apb_rdata			(),
	   .apb_ready			(),
	   .apb_enable			(1'd0),
	   .apb_sel			(1'd0),

	/*AUTOINST*/
	   // Outputs
	   .axi_arready			(axi_slv2_arready),	 // Templated
	   .axi_awready			(axi_slv2_awready),	 // Templated
	   .axi_rdata			(axi_slv2_rdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_rid			(axi_slv2_rid[3:0]),	 // Templated
	   .axi_rlast			(axi_slv2_rlast),	 // Templated
	   .axi_rvalid			(axi_slv2_rvalid),	 // Templated
	   .axi_wready			(axi_slv2_wready),	 // Templated
	   .axi_wusero_id		(axi_slv2_wusero_id[3:0]), // Templated
	   .axi_wusero_last		(axi_slv2_wusero_last),	 // Templated
	   // Inputs
	   .apb_addr			(apb_addr[7:0]),
	   .apb_clk			(apb_clk),
	   .apb_rst_n			(apb_rst_n),
	   .apb_wdata			(apb_wdata[15:0]),
	   .apb_write			(apb_write),
	   .axi_araddr			(axi_slv2_araddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_arlen			(axi_slv2_arlen[3:0]),	 // Templated
	   .axi_aruser_ap		(axi_slv2_aruser_ap),	 // Templated
	   .axi_aruser_id		(axi_slv2_aruser_id[3:0]), // Templated
	   .axi_arvalid			(axi_slv2_arvalid),	 // Templated
	   .axi_awaddr			(axi_slv2_awaddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_awlen			(axi_slv2_awlen[3:0]),	 // Templated
	   .axi_awuser_ap		(axi_slv2_awuser_ap),	 // Templated
	   .axi_awuser_id		(axi_slv2_awuser_id[3:0]), // Templated
	   .axi_awvalid			(axi_slv2_awvalid),	 // Templated
	   .axi_wdata			(axi_slv2_wdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_wstrb			(axi_slv2_wstrb[MEM_DQ_WIDTH*8/8-1:0]), // Templated
	   .ref_clk			(ref_clk),
	   .resetn			(resetn));

// Local Variables:                                                                 
// verilog-auto-inst-param-value:t                                                  
// End:           

endmodule

