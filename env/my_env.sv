`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;
   apb_sequencer  apb_sqr;

   axi_sequencer  axi_sqr0;
   axi_sequencer  axi_sqr1;
   axi_sequencer  axi_sqr2;

   apb_driver apb_drv;

   axi_driver axi_drv0;
   axi_driver axi_drv1;
   axi_driver axi_drv2;

   apb_monitor apb_mon;

   axi_monitor axi_mon0;
   axi_monitor axi_mon1;
   axi_monitor axi_mon2;

   apb_model  apb_mdl;

   axi_model  axi_mdl0;
   axi_model  axi_mdl1;
   axi_model  axi_mdl2;

   apb_scoreboard apb_scb;

   axi_scoreboard axi_scb0;
   axi_scoreboard axi_scb1;
   axi_scoreboard axi_scb2;

//   uvm_tlm_analysis_fifo #(apb_transaction) apbmon_apbmdl_fifo;
   uvm_tlm_analysis_fifo #(apb_transaction) apbmon_apbscb_fifo;
   uvm_tlm_analysis_fifo #(apb_transaction) apbmdl_apbscb_fifo;

   uvm_tlm_analysis_fifo #(axi_transaction) aximon_axiscb_fifo0;
   uvm_tlm_analysis_fifo #(axi_transaction) aximon_axiscb_fifo1;
   uvm_tlm_analysis_fifo #(axi_transaction) aximon_axiscb_fifo2;
                                                               
   uvm_tlm_analysis_fifo #(axi_transaction) aximdl_axiscb_fifo0;
   uvm_tlm_analysis_fifo #(axi_transaction) aximdl_axiscb_fifo1;
   uvm_tlm_analysis_fifo #(axi_transaction) aximdl_axiscb_fifo2;
                                                               
   uvm_tlm_analysis_fifo #(axi_transaction) axidrv_aximon_fifo0;
   uvm_tlm_analysis_fifo #(axi_transaction) axidrv_aximon_fifo1;
   uvm_tlm_analysis_fifo #(axi_transaction) axidrv_aximon_fifo2;
                                                               
   uvm_tlm_analysis_fifo #(axi_transaction) axidrv_aximdl_fifo0;
   uvm_tlm_analysis_fifo #(axi_transaction) axidrv_aximdl_fifo1;
   uvm_tlm_analysis_fifo #(axi_transaction) axidrv_aximdl_fifo2;

   function new(string name = "my_env", uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      apb_sqr = apb_sequencer::type_id::create("apb_sqr", this);

      axi_sqr0 = axi_sequencer::type_id::create("axi_sqr0", this);
      axi_sqr1 = axi_sequencer::type_id::create("axi_sqr1", this);
      axi_sqr2 = axi_sequencer::type_id::create("axi_sqr2", this);

      apb_drv = apb_driver::type_id::create("apb_drv", this); 

      axi_drv0 = axi_driver::type_id::create("axi_drv0", this); 
      axi_drv1 = axi_driver::type_id::create("axi_drv1", this); 
      axi_drv2 = axi_driver::type_id::create("axi_drv2", this); 

      apb_mon = apb_monitor::type_id::create("apb_mon", this);

      axi_mon0 = axi_monitor::type_id::create("axi_mon0", this);
      axi_mon1 = axi_monitor::type_id::create("axi_mon1", this);
      axi_mon2 = axi_monitor::type_id::create("axi_mon2", this);

      //o_mon = my_monitor::type_id::create("o_mon", this);
      apb_mdl = apb_model::type_id::create("apb_mdl", this);

      axi_mdl0 = axi_model::type_id::create("axi_mdl0", this);
      axi_mdl1 = axi_model::type_id::create("axi_mdl1", this);
      axi_mdl2 = axi_model::type_id::create("axi_mdl2", this);

      apb_scb = apb_scoreboard::type_id::create("apb_scb", this);

      axi_scb0 = axi_scoreboard::type_id::create("axi_scb0", this);
      axi_scb1 = axi_scoreboard::type_id::create("axi_scb1", this);
      axi_scb2 = axi_scoreboard::type_id::create("axi_scb2", this);

      //apbmon_apbmdl_fifo = new("apbmon_apbmdl_fifo", this);
      apbmon_apbscb_fifo = new("apbmon_apbscb_fifo", this);
      apbmdl_apbscb_fifo = new("apbmdl_apbscb_fifo", this);

      aximon_axiscb_fifo0 = new("aximon_axiscb_fifo0", this);
      aximon_axiscb_fifo1 = new("aximon_axiscb_fifo1", this);
      aximon_axiscb_fifo2 = new("aximon_axiscb_fifo2", this);

      aximdl_axiscb_fifo0 = new("aximdl_axiscb_fifo0", this);
      aximdl_axiscb_fifo1 = new("aximdl_axiscb_fifo1", this);
      aximdl_axiscb_fifo2 = new("aximdl_axiscb_fifo2", this);

      axidrv_aximon_fifo0 = new("axidrv_aximon_fifo0", this);
      axidrv_aximon_fifo1 = new("axidrv_aximon_fifo1", this);
      axidrv_aximon_fifo2 = new("axidrv_aximon_fifo2", this);

      axidrv_aximdl_fifo0 = new("axidrv_aximdl_fifo0", this);
      axidrv_aximdl_fifo1 = new("axidrv_aximdl_fifo1", this);
      axidrv_aximdl_fifo2 = new("axidrv_aximdl_fifo2", this);

   endfunction

   extern virtual function void connect_phase(uvm_phase phase);
   //extern virtual task main_phase(uvm_phase phase);

   `uvm_component_utils(my_env)
endclass


function void my_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //apb_mon.ap.connect(apbmon_apbmdl_fifo.analysis_export);
   //apb_mdl.port.connect(apbmon_apbmdl_fifo.blocking_get_export);

   apb_mdl.ap.connect(apbmdl_apbscb_fifo.analysis_export);
   apb_scb.exp_port.connect(apbmdl_apbscb_fifo.blocking_get_export);

   apb_mon.ap.connect(apbmon_apbscb_fifo.analysis_export);
   apb_scb.act_port.connect(apbmon_apbscb_fifo.blocking_get_export);

   apb_drv.seq_item_port.connect(apb_sqr.seq_item_export);

   //axi0
   axi_mdl0.ap.connect(aximdl_axiscb_fifo0.analysis_export);
   axi_scb0.exp_port.connect(aximdl_axiscb_fifo0.blocking_get_export);

   axi_mon0.ap.connect(aximon_axiscb_fifo0.analysis_export);
   axi_scb0.act_port.connect(aximon_axiscb_fifo0.blocking_get_export);

    axi_drv0.seq_item_port.connect(axi_sqr0.seq_item_export);

    axi_drv0.ap.connect(axidrv_aximon_fifo0.analysis_export);
    axi_mon0.port.connect(axidrv_aximon_fifo0.blocking_get_export);

    axi_drv0.ap_mdl.connect(axidrv_aximdl_fifo0.analysis_export);
    axi_mdl0.port.connect(axidrv_aximdl_fifo0.blocking_get_export);

//axi1
   axi_mdl1.ap.connect(aximdl_axiscb_fifo1.analysis_export);
   axi_scb1.exp_port.connect(aximdl_axiscb_fifo1.blocking_get_export);

   axi_mon1.ap.connect(aximon_axiscb_fifo1.analysis_export);
   axi_scb1.act_port.connect(aximon_axiscb_fifo1.blocking_get_export);

    axi_drv1.seq_item_port.connect(axi_sqr1.seq_item_export);

    axi_drv1.ap.connect(axidrv_aximon_fifo1.analysis_export);
    axi_mon1.port.connect(axidrv_aximon_fifo1.blocking_get_export);

    axi_drv1.ap_mdl.connect(axidrv_aximdl_fifo1.analysis_export);
    axi_mdl1.port.connect(axidrv_aximdl_fifo1.blocking_get_export);

//axi2
   axi_mdl2.ap.connect(aximdl_axiscb_fifo2.analysis_export);
   axi_scb2.exp_port.connect(aximdl_axiscb_fifo2.blocking_get_export);

   axi_mon2.ap.connect(aximon_axiscb_fifo2.analysis_export);
   axi_scb2.act_port.connect(aximon_axiscb_fifo2.blocking_get_export);

    axi_drv2.seq_item_port.connect(axi_sqr2.seq_item_export);

    axi_drv2.ap.connect(axidrv_aximon_fifo2.analysis_export);
    axi_mon2.port.connect(axidrv_aximon_fifo2.blocking_get_export);

    axi_drv2.ap_mdl.connect(axidrv_aximdl_fifo2.analysis_export);
    axi_mdl2.port.connect(axidrv_aximdl_fifo2.blocking_get_export);



endfunction


//task my_env::main_phase(uvm_phase phase);
//   my_sequence apb_seq;
//   phase.raise_objection(this);
//   apb_seq = my_sequence::type_id::create("apb_seq");
//   apb_seq.start(apb_sqr); 
//   phase.drop_objection(this);
//endtask
//


`endif
