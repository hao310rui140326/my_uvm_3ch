`timescale 1ns/1ps 


`include  "../../env/apb_transaction.sv"
`include  "../../env/axi_transaction.sv"
`include  "../../env/apb_driver.sv"
`include  "../../env/axi_driver.sv"
`include  "../../env/apb_monitor.sv"
`include  "../../env/axi_monitor.sv"
`include  "../../env/apb_model.sv"
`include  "../../env/axi_model.sv"
`include  "../../env/apb_scoreboard.sv"
`include  "../../env/axi_scoreboard.sv"
`include  "../../env/apb_sequencer.sv"
`include  "../../env/axi_sequencer.sv"
`include  "../../env/my_env.sv"
`include  "../../env/base_test.sv"
`include  "../../env/apb_case0.sv"
`include  "../../env/apb_pd_wone.sv"
`include  "../../env/apb_pd_state.sv"
`include  "../../env/apb_mrs_state.sv"
`include  "../../env/apb_sr_state.sv"
`include  "../../env/apb_case_rall.sv"
`include  "../../env/apb_case_wall.sv"
`include  "../../env/apb_case_wrall.sv"
`include  "../../env/axi_normal.sv"
`include  "../../env/axi_test.sv"
`include  "../../env/axi_3ch_test.sv"


module tb_top(/*AUTOARG*/
   // Outputs
   debug_data, debug_calib_ctrl
   );

  parameter MEM_ROW_ADDR_WIDTH   = 15         ;
  parameter MEM_COL_ADDR_WIDTH   = 10         ;
  parameter MEM_BADDR_WIDTH      = 3          ;
  parameter MEM_DQ_WIDTH         =  32        ;
  parameter MEM_DQS_WIDTH        =  32/8      ;
  parameter CTRL_ADDR_WIDTH = MEM_ROW_ADDR_WIDTH + MEM_BADDR_WIDTH + MEM_COL_ADDR_WIDTH;
  parameter TH_1S = 27'd33000000;

/*AUTOINPUT*/
/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
output [29:0]		debug_calib_ctrl;	// From u_ddr_wrapper of ddr_3ch.v
output [66*MEM_DQS_WIDTH-1:0] debug_data;	// From u_ddr_wrapper of ddr_3ch.v
// End of automatics
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			core_clk;		// From u_ddr_wrapper of ddr_3ch.v
wire			ref_clk;		// From u_clk_gen of clk_gen.v
wire			rst_n;			// From u_rst_gen of rst_gen.v
// End of automatics

`include "ddr3_parameters.vh"

 tvip_reg_if   areg(ref_clk,rst_n);
 tvip_apb_if   apbd(ref_clk,rst_n);
 tvip_axi_if   axid0(core_clk,rst_n);
 tvip_axi_if   axid1(core_clk,rst_n);
 tvip_axi_if   axid2(core_clk,rst_n);
 tvip_ini_if   inid(ref_clk,rst_n);
 tvip_mem_if   memd0(core_clk,rst_n);
 tvip_mem_if   memd1(core_clk,rst_n);
 tvip_mem_if   memd2(core_clk,rst_n);


/*ddr3_reg AUTO_TEMPLATE(
      .aclk          		(ref_clk),
      .areset_n      		(rst_n),
      .apb_addr			(apbd.apb_addr[7:0]),
      .apb_enable		(apbd.apb_enable),
      .apb_sel			(apbd.apb_sel),
      .apb_wdata		(apbd.apb_wdata[15:0]),
      .apb_write		(apbd.apb_write),
      .apb_rdata		(apbd.apb_rdata[15:0]),
      .apb_ready		(apbd.apb_ready),
      .reg_rdata     		(areg.reg_rdata),
      .reg_vld       		(areg.reg_vld  ),
      .reg_raddr       		(areg.reg_raddr),
);*/

/*ddr_3ch  AUTO_TEMPLATE(
    .resetn		(rst_n), 
    .apb_clk		(ref_clk),	 
    .apb_rst_n		(rst_n),	 

    .axi_slv0_awaddr     (axid0.awaddr),            
    .axi_slv0_awuser_ap  (1'd0),
    .axi_slv0_awuser_id  (axid0.awid),
    .axi_slv0_awlen      (axid0.awlen),
    .axi_slv0_awready    (axid0.awready),
    .axi_slv0_awvalid    (axid0.awvalid),
    .axi_slv0_wdata      (axid0.wdata),
    .axi_slv0_wstrb      (axid0.wstrb),
    .axi_slv0_wready     (axid0.wready),
    .axi_slv0_wusero_id  (axid0.bid),
    .axi_slv0_wusero_last(axid0.wlast),
    .axi_slv0_araddr     (axid0.araddr),
    .axi_slv0_aruser_ap  (1'd0),
    .axi_slv0_aruser_id  (axid0.arid),
    .axi_slv0_arlen      (axid0.arlen),
    .axi_slv0_arready    (axid0.arready),
    .axi_slv0_arvalid    (axid0.arvalid),
    .axi_slv0_rdata      (axid0.rdata),
    .axi_slv0_rid        (axid0.rid),
    .axi_slv0_rlast      (axid0.rlast),
    .axi_slv0_rvalid     (axid0.rvalid),

    .axi_slv1_awaddr     (axid1.awaddr),            
    .axi_slv1_awuser_ap  (1'd0),
    .axi_slv1_awuser_id  (axid1.awid),
    .axi_slv1_awlen      (axid1.awlen),
    .axi_slv1_awready    (axid1.awready),
    .axi_slv1_awvalid    (axid1.awvalid),
    .axi_slv1_wdata      (axid1.wdata),
    .axi_slv1_wstrb      (axid1.wstrb),
    .axi_slv1_wready     (axid1.wready),
    .axi_slv1_wusero_id  (axid1.bid),
    .axi_slv1_wusero_last(axid1.wlast),
    .axi_slv1_araddr     (axid1.araddr),
    .axi_slv1_aruser_ap  (1'd0),
    .axi_slv1_aruser_id  (axid1.arid),
    .axi_slv1_arlen      (axid1.arlen),
    .axi_slv1_arready    (axid1.arready),
    .axi_slv1_arvalid    (axid1.arvalid),
    .axi_slv1_rdata      (axid1.rdata),
    .axi_slv1_rid        (axid1.rid),
    .axi_slv1_rlast      (axid1.rlast),
    .axi_slv1_rvalid     (axid1.rvalid),


    .axi_slv2_awaddr     (axid2.awaddr),            
    .axi_slv2_awuser_ap  (1'd0),
    .axi_slv2_awuser_id  (axid2.awid),
    .axi_slv2_awlen      (axid2.awlen),
    .axi_slv2_awready    (axid2.awready),
    .axi_slv2_awvalid    (axid2.awvalid),
    .axi_slv2_wdata      (axid2.wdata),
    .axi_slv2_wstrb      (axid2.wstrb),
    .axi_slv2_wready     (axid2.wready),
    .axi_slv2_wusero_id  (axid2.bid),
    .axi_slv2_wusero_last(axid2.wlast),
    .axi_slv2_araddr     (axid2.araddr),
    .axi_slv2_aruser_ap  (1'd0),
    .axi_slv2_aruser_id  (axid2.arid),
    .axi_slv2_arlen      (axid2.arlen),
    .axi_slv2_arready    (axid2.arready),
    .axi_slv2_arvalid    (axid2.arvalid),
    .axi_slv2_rdata      (axid2.rdata),
    .axi_slv2_rid        (axid2.rid),
    .axi_slv2_rlast      (axid2.rlast),
    .axi_slv2_rvalid     (axid2.rvalid),

    .apb_addr		(apbd.apb_addr[7:0]),
    .apb_enable		(apbd.apb_enable),
    .apb_sel		(apbd.apb_sel),
    .apb_wdata		(apbd.apb_wdata[15:0]),
    .apb_write		(apbd.apb_write),
    .apb_rdata		(apbd.apb_rdata[15:0]),
    .apb_ready		(apbd.apb_ready),

    .ddr_init_done	(inid.ini_done),
    .ddrphy_cpd_lock	(inid.ini_phy_lock),
    .pll_lock		(inid.ini_pll_lock),

);*/

/*assoc_mem  AUTO_TEMPLATE(
    .rst_n		(rst_n), 
    .clk		(core_clk),
    .wen0                (memd0.we),
    .wdin0               (memd0.wdata),
    .wb0                 (memd0.wb),
    .ren0                (memd0.re),
    .waddr0              (memd0.waddr),
    .raddr0              (memd0.raddr),
    .rvld0               (memd0.rvld),
    .rdout0              (memd0.rdout),  

    .wen1                (memd1.we),
    .wdin1               (memd1.wdata),
    .wb1                 (memd1.wb),
    .ren1                (memd1.re),
    .waddr1              (memd1.waddr),
    .raddr1              (memd1.raddr),
    .rvld1               (memd1.rvld),
    .rdout1              (memd1.rdout),  

    .wen2                (memd2.we),
    .wdin2               (memd2.wdata),
    .wb2                 (memd2.wb),
    .ren2                (memd2.re),
    .waddr2              (memd2.waddr),
    .raddr2              (memd2.raddr),
    .rvld2               (memd2.rvld),
    .rdout2              (memd2.rdout),  

);*/



ddr3_reg  u_ddr3_reg(/*AUTOINST*/
		     // Outputs
		     .reg_rdata		(areg.reg_rdata),	 // Templated
		     .reg_raddr		(areg.reg_raddr),	 // Templated
		     .reg_vld		(areg.reg_vld  ),	 // Templated
		     // Inputs
		     .aclk		(ref_clk),		 // Templated
		     .areset_n		(rst_n),		 // Templated
		     .apb_sel		(apbd.apb_sel),		 // Templated
		     .apb_enable	(apbd.apb_enable),	 // Templated
		     .apb_addr		(apbd.apb_addr[7:0]),	 // Templated
		     .apb_write		(apbd.apb_write),	 // Templated
		     .apb_ready		(apbd.apb_ready),	 // Templated
		     .apb_wdata		(apbd.apb_wdata[15:0]),	 // Templated
		     .apb_rdata		(apbd.apb_rdata[15:0]));	 // Templated

assoc_mem u_assoc_mem(/*AUTOINST*/
		      // Outputs
		      .rdout0		(memd0.rdout),		 // Templated
		      .rvld0		(memd0.rvld),		 // Templated
		      .rdout1		(memd1.rdout),		 // Templated
		      .rvld1		(memd1.rvld),		 // Templated
		      .rdout2		(memd2.rdout),		 // Templated
		      .rvld2		(memd2.rvld),		 // Templated
		      // Inputs
		      .clk		(core_clk),		 // Templated
		      .rst_n		(rst_n),		 // Templated
		      .wen0		(memd0.we),		 // Templated
		      .ren0		(memd0.re),		 // Templated
		      .wdin0		(memd0.wdata),		 // Templated
		      .wb0		(memd0.wb),		 // Templated
		      .waddr0		(memd0.waddr),		 // Templated
		      .raddr0		(memd0.raddr),		 // Templated
		      .wen1		(memd1.we),		 // Templated
		      .ren1		(memd1.re),		 // Templated
		      .wdin1		(memd1.wdata),		 // Templated
		      .wb1		(memd1.wb),		 // Templated
		      .waddr1		(memd1.waddr),		 // Templated
		      .raddr1		(memd1.raddr),		 // Templated
		      .wen2		(memd2.we),		 // Templated
		      .ren2		(memd2.re),		 // Templated
		      .wdin2		(memd2.wdata),		 // Templated
		      .wb2		(memd2.wb),		 // Templated
		      .waddr2		(memd2.waddr),		 // Templated
		      .raddr2		(memd2.raddr));		 // Templated

ddr_3ch u_ddr_wrapper(/*AUTOINST*/
		      // Outputs
		      .apb_rdata	(apbd.apb_rdata[15:0]),	 // Templated
		      .apb_ready	(apbd.apb_ready),	 // Templated
		      .axi_slv0_arready	(axid0.arready),	 // Templated
		      .axi_slv0_awready	(axid0.awready),	 // Templated
		      .axi_slv0_rdata	(axid0.rdata),		 // Templated
		      .axi_slv0_rid		(axid0.rid),		 // Templated
		      .axi_slv0_rlast	(axid0.rlast),		 // Templated
		      .axi_slv0_rvalid	(axid0.rvalid),		 // Templated
		      .axi_slv0_wready	(axid0.wready),		 // Templated
		      .axi_slv0_wusero_id	(axid0.bid),		 // Templated
		      .axi_slv0_wusero_last	(axid0.wlast),		 // Templated
		      .axi_slv1_arready	(axid1.arready),	 // Templated
		      .axi_slv1_awready	(axid1.awready),	 // Templated
		      .axi_slv1_rdata	(axid1.rdata),		 // Templated
		      .axi_slv1_rid		(axid1.rid),		 // Templated
		      .axi_slv1_rlast	(axid1.rlast),		 // Templated
		      .axi_slv1_rvalid	(axid1.rvalid),		 // Templated
		      .axi_slv1_wready	(axid1.wready),		 // Templated
		      .axi_slv1_wusero_id	(axid1.bid),		 // Templated
		      .axi_slv1_wusero_last	(axid1.wlast),		 // Templated
		      .axi_slv2_arready	(axid2.arready),	 // Templated
		      .axi_slv2_awready	(axid2.awready),	 // Templated
		      .axi_slv2_rdata	(axid2.rdata),		 // Templated
		      .axi_slv2_rid		(axid2.rid),		 // Templated
		      .axi_slv2_rlast	(axid2.rlast),		 // Templated
		      .axi_slv2_rvalid	(axid2.rvalid),		 // Templated
		      .axi_slv2_wready	(axid2.wready),		 // Templated
		      .axi_slv2_wusero_id	(axid2.bid),		 // Templated
		      .axi_slv2_wusero_last	(axid2.wlast),		 // Templated
		      .core_clk		(core_clk),
		      .ddr_init_done	(inid.ini_done),	 // Templated
		      .ddrphy_cpd_lock	(inid.ini_phy_lock),	 // Templated
		      .debug_calib_ctrl	(debug_calib_ctrl[29:0]),
		      .debug_data	(debug_data[66*MEM_DQS_WIDTH-1:0]),
		      .pll_lock		(inid.ini_pll_lock),	 // Templated
		      // Inputs
		      .apb_addr		(apbd.apb_addr[7:0]),	 // Templated
		      .apb_clk		(ref_clk),		 // Templated
		      .apb_enable	(apbd.apb_enable),	 // Templated
		      .apb_rst_n	(rst_n),		 // Templated
		      .apb_sel		(apbd.apb_sel),		 // Templated
		      .apb_wdata	(apbd.apb_wdata[15:0]),	 // Templated
		      .apb_write	(apbd.apb_write),	 // Templated
		      .axi_slv0_araddr	(axid0.araddr),		 // Templated
		      .axi_slv0_arlen	(axid0.arlen),		 // Templated
		      .axi_slv0_aruser_ap	(1'd0),			 // Templated
		      .axi_slv0_aruser_id	(axid0.arid),		 // Templated
		      .axi_slv0_arvalid	(axid0.arvalid),	 // Templated
		      .axi_slv0_awaddr	(axid0.awaddr),		 // Templated
		      .axi_slv0_awlen	(axid0.awlen),		 // Templated
		      .axi_slv0_awuser_ap	(1'd0),			 // Templated
		      .axi_slv0_awuser_id	(axid0.awid),		 // Templated
		      .axi_slv0_awvalid	(axid0.awvalid),	 // Templated
		      .axi_slv0_wdata	(axid0.wdata),		 // Templated
		      .axi_slv0_wstrb	(axid0.wstrb),		 // Templated
		      .axi_slv1_araddr	(axid1.araddr),		 // Templated
		      .axi_slv1_arlen	(axid1.arlen),		 // Templated
		      .axi_slv1_aruser_ap	(1'd0),			 // Templated
		      .axi_slv1_aruser_id	(axid1.arid),		 // Templated
		      .axi_slv1_arvalid	(axid1.arvalid),	 // Templated
		      .axi_slv1_awaddr	(axid1.awaddr),		 // Templated
		      .axi_slv1_awlen	(axid1.awlen),		 // Templated
		      .axi_slv1_awuser_ap	(1'd0),			 // Templated
		      .axi_slv1_awuser_id	(axid1.awid),		 // Templated
		      .axi_slv1_awvalid	(axid1.awvalid),	 // Templated
		      .axi_slv1_wdata	(axid1.wdata),		 // Templated
		      .axi_slv1_wstrb	(axid1.wstrb),		 // Templated
		      .axi_slv2_araddr	(axid2.araddr),		 // Templated
		      .axi_slv2_arlen	(axid2.arlen),		 // Templated
		      .axi_slv2_aruser_ap	(1'd0),			 // Templated
		      .axi_slv2_aruser_id	(axid2.arid),		 // Templated
		      .axi_slv2_arvalid	(axid2.arvalid),	 // Templated
		      .axi_slv2_awaddr	(axid2.awaddr),		 // Templated
		      .axi_slv2_awlen	(axid2.awlen),		 // Templated
		      .axi_slv2_awuser_ap	(1'd0),			 // Templated
		      .axi_slv2_awuser_id	(axid2.awid),		 // Templated
		      .axi_slv2_awvalid	(axid2.awvalid),	 // Templated
		      .axi_slv2_wdata	(axid2.wdata),		 // Templated
		      .axi_slv2_wstrb	(axid2.wstrb),		 // Templated
		      .ref_clk		(ref_clk),
		      .resetn		(rst_n));		 // Templated
rst_gen u_rst_gen(/*AUTOINST*/
		  // Outputs
		  .rst_n		(rst_n));
clk_gen u_clk_gen(/*AUTOINST*/
		  // Outputs
		  .ref_clk		(ref_clk));
dump dump();
monitor monitor();
forcelist forcelist();

GTP_GRS GRS_INST(
		.GRS_N (rst_n)
	);

initial begin
   run_test();
end

initial begin
   uvm_config_db#(virtual tvip_apb_if)::set(null, "uvm_test_top.env.apb_drv", "vapb", apbd);
   //uvm_config_db#(virtual tvip_axi_if)::set(null, "uvm_test_top.env.drv", "vaxi", axid);
   uvm_config_db#(virtual tvip_ini_if)::set(null, "uvm_test_top.env.apb_drv", "vini", inid);
   uvm_config_db#(virtual tvip_apb_if)::set(null, "uvm_test_top.env.apb_mon", "vapb", apbd);
   uvm_config_db#(virtual tvip_ini_if)::set(null, "uvm_test_top.env.apb_mon", "vini", inid);
   uvm_config_db#(virtual tvip_reg_if)::set(null, "uvm_test_top.env.apb_mdl", "vreg", areg);

   uvm_config_db#(virtual tvip_axi_if)::set(null, "uvm_test_top.env.axi_drv0", "vaxi", axid0);
   uvm_config_db#(virtual tvip_axi_if)::set(null, "uvm_test_top.env.axi_drv1", "vaxi", axid1);
   uvm_config_db#(virtual tvip_axi_if)::set(null, "uvm_test_top.env.axi_drv2", "vaxi", axid2);
   
   uvm_config_db#(virtual tvip_axi_if)::set(null, "uvm_test_top.env.axi_mon0", "vaxi", axid0);
   uvm_config_db#(virtual tvip_axi_if)::set(null, "uvm_test_top.env.axi_mon1", "vaxi", axid1);
   uvm_config_db#(virtual tvip_axi_if)::set(null, "uvm_test_top.env.axi_mon2", "vaxi", axid2);
   
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_mdl0", "vmem", memd0);
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_mdl1", "vmem", memd1);
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_mdl2", "vmem", memd2);

   uvm_config_db#(virtual tvip_ini_if)::set(null, "uvm_test_top.env.axi_drv0", "vini", inid);
   uvm_config_db#(virtual tvip_ini_if)::set(null, "uvm_test_top.env.axi_drv1", "vini", inid);
   uvm_config_db#(virtual tvip_ini_if)::set(null, "uvm_test_top.env.axi_drv2", "vini", inid);

   uvm_config_db#(virtual tvip_ini_if)::set(null, "uvm_test_top.env.axi_mon0", "vini", inid);
   uvm_config_db#(virtual tvip_ini_if)::set(null, "uvm_test_top.env.axi_mon1", "vini", inid);
   uvm_config_db#(virtual tvip_ini_if)::set(null, "uvm_test_top.env.axi_mon2", "vini", inid);

   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_drv0", "vmem", memd0);
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_drv1", "vmem", memd1);
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_drv2", "vmem", memd2);

   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_mon0", "vmem", memd0);
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_mon1", "vmem", memd1);
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_mon2", "vmem", memd2);

   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_scb0", "vmem", memd0);   
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_scb1", "vmem", memd1);   
   uvm_config_db#(virtual tvip_mem_if)::set(null, "uvm_test_top.env.axi_scb2", "vmem", memd2);   


end

endmodule




