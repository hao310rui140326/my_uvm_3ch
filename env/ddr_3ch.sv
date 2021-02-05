module ddr_3ch(/*AUTOARG*/
   // Outputs
   pll_lock, debug_data, debug_calib_ctrl, ddrphy_cpd_lock,
   ddr_init_done, core_clk, axi2_wusero_last, axi2_wusero_id,
   axi2_wready, axi2_rvalid, axi2_rlast, axi2_rid, axi2_rdata,
   axi2_awready, axi2_arready, axi1_wusero_last, axi1_wusero_id,
   axi1_wready, axi1_rvalid, axi1_rlast, axi1_rid, axi1_rdata,
   axi1_awready, axi1_arready, axi0_wusero_last, axi0_wusero_id,
   axi0_wready, axi0_rvalid, axi0_rlast, axi0_rid, axi0_rdata,
   axi0_awready, axi0_arready, apb_ready, apb_rdata,
   // Inputs
   resetn, ref_clk, axi2_wstrb, axi2_wdata, axi2_awvalid,
   axi2_awuser_id, axi2_awuser_ap, axi2_awlen, axi2_awaddr,
   axi2_arvalid, axi2_aruser_id, axi2_aruser_ap, axi2_arlen,
   axi2_araddr, axi1_wstrb, axi1_wdata, axi1_awvalid, axi1_awuser_id,
   axi1_awuser_ap, axi1_awlen, axi1_awaddr, axi1_arvalid,
   axi1_aruser_id, axi1_aruser_ap, axi1_arlen, axi1_araddr,
   axi0_wstrb, axi0_wdata, axi0_awvalid, axi0_awuser_id,
   axi0_awuser_ap, axi0_awlen, axi0_awaddr, axi0_arvalid,
   axi0_aruser_id, axi0_aruser_ap, axi0_arlen, axi0_araddr, apb_write,
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
input [CTRL_ADDR_WIDTH-1:0] axi0_araddr;	// To u_ddr_0 of ddr_wrapper.v
input [3:0]		axi0_arlen;		// To u_ddr_0 of ddr_wrapper.v
input			axi0_aruser_ap;		// To u_ddr_0 of ddr_wrapper.v
input [3:0]		axi0_aruser_id;		// To u_ddr_0 of ddr_wrapper.v
input			axi0_arvalid;		// To u_ddr_0 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi0_awaddr;	// To u_ddr_0 of ddr_wrapper.v
input [3:0]		axi0_awlen;		// To u_ddr_0 of ddr_wrapper.v
input			axi0_awuser_ap;		// To u_ddr_0 of ddr_wrapper.v
input [3:0]		axi0_awuser_id;		// To u_ddr_0 of ddr_wrapper.v
input			axi0_awvalid;		// To u_ddr_0 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8-1:0] axi0_wdata;		// To u_ddr_0 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8/8-1:0] axi0_wstrb;	// To u_ddr_0 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi1_araddr;	// To u_ddr_1 of ddr_wrapper.v
input [3:0]		axi1_arlen;		// To u_ddr_1 of ddr_wrapper.v
input			axi1_aruser_ap;		// To u_ddr_1 of ddr_wrapper.v
input [3:0]		axi1_aruser_id;		// To u_ddr_1 of ddr_wrapper.v
input			axi1_arvalid;		// To u_ddr_1 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi1_awaddr;	// To u_ddr_1 of ddr_wrapper.v
input [3:0]		axi1_awlen;		// To u_ddr_1 of ddr_wrapper.v
input			axi1_awuser_ap;		// To u_ddr_1 of ddr_wrapper.v
input [3:0]		axi1_awuser_id;		// To u_ddr_1 of ddr_wrapper.v
input			axi1_awvalid;		// To u_ddr_1 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8-1:0] axi1_wdata;		// To u_ddr_1 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8/8-1:0] axi1_wstrb;	// To u_ddr_1 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi2_araddr;	// To u_ddr_2 of ddr_wrapper.v
input [3:0]		axi2_arlen;		// To u_ddr_2 of ddr_wrapper.v
input			axi2_aruser_ap;		// To u_ddr_2 of ddr_wrapper.v
input [3:0]		axi2_aruser_id;		// To u_ddr_2 of ddr_wrapper.v
input			axi2_arvalid;		// To u_ddr_2 of ddr_wrapper.v
input [CTRL_ADDR_WIDTH-1:0] axi2_awaddr;	// To u_ddr_2 of ddr_wrapper.v
input [3:0]		axi2_awlen;		// To u_ddr_2 of ddr_wrapper.v
input			axi2_awuser_ap;		// To u_ddr_2 of ddr_wrapper.v
input [3:0]		axi2_awuser_id;		// To u_ddr_2 of ddr_wrapper.v
input			axi2_awvalid;		// To u_ddr_2 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8-1:0] axi2_wdata;		// To u_ddr_2 of ddr_wrapper.v
input [MEM_DQ_WIDTH*8/8-1:0] axi2_wstrb;	// To u_ddr_2 of ddr_wrapper.v
input			ref_clk;		// To u_ddr_0 of ddr_wrapper.v, ...
input			resetn;			// To u_ddr_0 of ddr_wrapper.v, ...
// End of automatics
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output [15:0]		apb_rdata;		// From u_ddr_0 of ddr_wrapper.v
output			apb_ready;		// From u_ddr_0 of ddr_wrapper.v
output			axi0_arready;		// From u_ddr_0 of ddr_wrapper.v
output			axi0_awready;		// From u_ddr_0 of ddr_wrapper.v
output [MEM_DQ_WIDTH*8-1:0] axi0_rdata;		// From u_ddr_0 of ddr_wrapper.v
output [3:0]		axi0_rid;		// From u_ddr_0 of ddr_wrapper.v
output			axi0_rlast;		// From u_ddr_0 of ddr_wrapper.v
output			axi0_rvalid;		// From u_ddr_0 of ddr_wrapper.v
output			axi0_wready;		// From u_ddr_0 of ddr_wrapper.v
output [3:0]		axi0_wusero_id;		// From u_ddr_0 of ddr_wrapper.v
output			axi0_wusero_last;	// From u_ddr_0 of ddr_wrapper.v
output			axi1_arready;		// From u_ddr_1 of ddr_wrapper.v
output			axi1_awready;		// From u_ddr_1 of ddr_wrapper.v
output [MEM_DQ_WIDTH*8-1:0] axi1_rdata;		// From u_ddr_1 of ddr_wrapper.v
output [3:0]		axi1_rid;		// From u_ddr_1 of ddr_wrapper.v
output			axi1_rlast;		// From u_ddr_1 of ddr_wrapper.v
output			axi1_rvalid;		// From u_ddr_1 of ddr_wrapper.v
output			axi1_wready;		// From u_ddr_1 of ddr_wrapper.v
output [3:0]		axi1_wusero_id;		// From u_ddr_1 of ddr_wrapper.v
output			axi1_wusero_last;	// From u_ddr_1 of ddr_wrapper.v
output			axi2_arready;		// From u_ddr_2 of ddr_wrapper.v
output			axi2_awready;		// From u_ddr_2 of ddr_wrapper.v
output [MEM_DQ_WIDTH*8-1:0] axi2_rdata;		// From u_ddr_2 of ddr_wrapper.v
output [3:0]		axi2_rid;		// From u_ddr_2 of ddr_wrapper.v
output			axi2_rlast;		// From u_ddr_2 of ddr_wrapper.v
output			axi2_rvalid;		// From u_ddr_2 of ddr_wrapper.v
output			axi2_wready;		// From u_ddr_2 of ddr_wrapper.v
output [3:0]		axi2_wusero_id;		// From u_ddr_2 of ddr_wrapper.v
output			axi2_wusero_last;	// From u_ddr_2 of ddr_wrapper.v
output			core_clk;		// From u_ddr_0 of ddr_wrapper.v
output			ddr_init_done;		// From u_ddr_0 of ddr_wrapper.v
output			ddrphy_cpd_lock;	// From u_ddr_0 of ddr_wrapper.v
output [29:0]		debug_calib_ctrl;	// From u_ddr_0 of ddr_wrapper.v
output [66*MEM_DQS_WIDTH-1:0] debug_data;	// From u_ddr_0 of ddr_wrapper.v
output			pll_lock;		// From u_ddr_0 of ddr_wrapper.v
// End of automatics
/*AUTOWIRE*/



/* ddr_wrapper AUTO_TEMPLATE(
	.axi\(.*\) (axi@\1[]),
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
	   .axi_arready			(axi0_arready),		 // Templated
	   .axi_awready			(axi0_awready),		 // Templated
	   .axi_rdata			(axi0_rdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_rid			(axi0_rid[3:0]),	 // Templated
	   .axi_rlast			(axi0_rlast),		 // Templated
	   .axi_rvalid			(axi0_rvalid),		 // Templated
	   .axi_wready			(axi0_wready),		 // Templated
	   .axi_wusero_id		(axi0_wusero_id[3:0]),	 // Templated
	   .axi_wusero_last		(axi0_wusero_last),	 // Templated
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
	   .axi_araddr			(axi0_araddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_arlen			(axi0_arlen[3:0]),	 // Templated
	   .axi_aruser_ap		(axi0_aruser_ap),	 // Templated
	   .axi_aruser_id		(axi0_aruser_id[3:0]),	 // Templated
	   .axi_arvalid			(axi0_arvalid),		 // Templated
	   .axi_awaddr			(axi0_awaddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_awlen			(axi0_awlen[3:0]),	 // Templated
	   .axi_awuser_ap		(axi0_awuser_ap),	 // Templated
	   .axi_awuser_id		(axi0_awuser_id[3:0]),	 // Templated
	   .axi_awvalid			(axi0_awvalid),		 // Templated
	   .axi_wdata			(axi0_wdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_wstrb			(axi0_wstrb[MEM_DQ_WIDTH*8/8-1:0]), // Templated
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
	   .axi_arready			(axi1_arready),		 // Templated
	   .axi_awready			(axi1_awready),		 // Templated
	   .axi_rdata			(axi1_rdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_rid			(axi1_rid[3:0]),	 // Templated
	   .axi_rlast			(axi1_rlast),		 // Templated
	   .axi_rvalid			(axi1_rvalid),		 // Templated
	   .axi_wready			(axi1_wready),		 // Templated
	   .axi_wusero_id		(axi1_wusero_id[3:0]),	 // Templated
	   .axi_wusero_last		(axi1_wusero_last),	 // Templated
	   // Inputs
	   .apb_addr			(apb_addr[7:0]),
	   .apb_clk			(apb_clk),
	   .apb_rst_n			(apb_rst_n),
	   .apb_wdata			(apb_wdata[15:0]),
	   .apb_write			(apb_write),
	   .axi_araddr			(axi1_araddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_arlen			(axi1_arlen[3:0]),	 // Templated
	   .axi_aruser_ap		(axi1_aruser_ap),	 // Templated
	   .axi_aruser_id		(axi1_aruser_id[3:0]),	 // Templated
	   .axi_arvalid			(axi1_arvalid),		 // Templated
	   .axi_awaddr			(axi1_awaddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_awlen			(axi1_awlen[3:0]),	 // Templated
	   .axi_awuser_ap		(axi1_awuser_ap),	 // Templated
	   .axi_awuser_id		(axi1_awuser_id[3:0]),	 // Templated
	   .axi_awvalid			(axi1_awvalid),		 // Templated
	   .axi_wdata			(axi1_wdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_wstrb			(axi1_wstrb[MEM_DQ_WIDTH*8/8-1:0]), // Templated
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
	   .axi_arready			(axi2_arready),		 // Templated
	   .axi_awready			(axi2_awready),		 // Templated
	   .axi_rdata			(axi2_rdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_rid			(axi2_rid[3:0]),	 // Templated
	   .axi_rlast			(axi2_rlast),		 // Templated
	   .axi_rvalid			(axi2_rvalid),		 // Templated
	   .axi_wready			(axi2_wready),		 // Templated
	   .axi_wusero_id		(axi2_wusero_id[3:0]),	 // Templated
	   .axi_wusero_last		(axi2_wusero_last),	 // Templated
	   // Inputs
	   .apb_addr			(apb_addr[7:0]),
	   .apb_clk			(apb_clk),
	   .apb_rst_n			(apb_rst_n),
	   .apb_wdata			(apb_wdata[15:0]),
	   .apb_write			(apb_write),
	   .axi_araddr			(axi2_araddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_arlen			(axi2_arlen[3:0]),	 // Templated
	   .axi_aruser_ap		(axi2_aruser_ap),	 // Templated
	   .axi_aruser_id		(axi2_aruser_id[3:0]),	 // Templated
	   .axi_arvalid			(axi2_arvalid),		 // Templated
	   .axi_awaddr			(axi2_awaddr[CTRL_ADDR_WIDTH-1:0]), // Templated
	   .axi_awlen			(axi2_awlen[3:0]),	 // Templated
	   .axi_awuser_ap		(axi2_awuser_ap),	 // Templated
	   .axi_awuser_id		(axi2_awuser_id[3:0]),	 // Templated
	   .axi_awvalid			(axi2_awvalid),		 // Templated
	   .axi_wdata			(axi2_wdata[MEM_DQ_WIDTH*8-1:0]), // Templated
	   .axi_wstrb			(axi2_wstrb[MEM_DQ_WIDTH*8/8-1:0]), // Templated
	   .ref_clk			(ref_clk),
	   .resetn			(resetn));

// Local Variables:                                                                 
// verilog-auto-inst-param-value:t                                                  
// End:           

endmodule

