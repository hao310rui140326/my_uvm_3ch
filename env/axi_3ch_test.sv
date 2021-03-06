`ifndef AXI_3CH__SV
`define AXI_3CH__SV
class apb_3ch_sequence extends uvm_sequence #(apb_transaction);
   apb_transaction m_trans;
   int id ;
   function  new(string name= "apb_3ch_sequence");
      super.new(name);
   endfunction 
    
   virtual task pre_body();
//     if (uvm_config_db#(int)::get(null,get_full_name(),"id",id))
//		`uvm_info("apb_3ch_sequence", $sformatf("get id value %0d via config_db",id), UVM_LOW);
//     else 
//		`uvm_error("apb_3ch_sequence", "can't get id value !!!");
     $display("get_full_name() = %s",get_full_name());
   endtask

   virtual task body();
      //if(starting_phase != null) 
      //   starting_phase.raise_objection(this);
	
	`ifdef AMODE0
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==8'he0;apb_wdata=='h0000;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==8'he0;apb_wdata=='h0001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_info("apb_3ch_sequence", "Arbitor mode is AMODE0 !!!", UVM_LOW)      		
	`elsif AMODE1
		`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==8'he0;apb_wdata=='h0002;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==8'he0;apb_wdata=='h0003;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_info("apb_3ch_sequence", "Arbitor mode is AMODE1 !!!", UVM_LOW)      				
	`elsif AMODE2
		`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==8'he0;apb_wdata=='h0004;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==8'he0;apb_wdata=='h0005;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_info("apb_3ch_sequence", "Arbitor mode is AMODE2 !!!", UVM_LOW)
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==`WEIGHT_SETTING0_ADDR;apb_wdata=='h000f;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==`WEIGHT_SETTING1_ADDR;apb_wdata=='h000f;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==`WEIGHT_SETTING2_ADDR;apb_wdata=='h000f;apb_rd_wr==apb_transaction::APB_WRITE;}  )
	`else
		`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==8'he0;apb_wdata=='h0000;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_info("apb_3ch_sequence", "No Arbitor mode  !!!", UVM_LOW)      						
	`endif
 	
 	`ifdef MRS
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h4001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 
		wait(tb_top.apbd.apb_rdata=='d3);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 
		`uvm_info("apb_3ch_sequence", "MRS mode  !!!", UVM_LOW)		
		 //wait(tb_top.apbd.apb_rdata=='d0);
         	//`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 		
	`elsif SR
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h8001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 
		wait(tb_top.apbd.apb_rdata=='d1);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )
		`uvm_info("apb_3ch_sequence", "SR mode  !!!", UVM_LOW)				
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h0001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )		
		wait(tb_top.apbd.apb_rdata=='d0);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )
	`elsif PD
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='hc001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 
		wait(tb_top.apbd.apb_rdata=='d2);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )
		`uvm_info("apb_3ch_sequence", "PD mode  !!!", UVM_LOW)						
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h0001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 
		wait(tb_top.apbd.apb_rdata=='d0);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )
	`else
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h0001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 
		wait(tb_top.apbd.apb_rdata=='d0);
		`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 
		`uvm_info("apb_3ch_sequence", "Normal mode  !!!", UVM_LOW)						
	`endif
      
         `uvm_info("apb_3ch_sequence", "send one transaction", UVM_LOW)      
      #100;
      //if(starting_phase != null) 
      //   starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(apb_3ch_sequence)
endclass

class axi_3ch_sequence extends uvm_sequence #(axi_transaction);
   axi_transaction m_trans;
   int id ;

   function  new(string name= "axi_3ch_sequence");
      super.new(name);
   endfunction 
   
   virtual task pre_body();
     if (uvm_config_db#(int)::get(null,get_full_name(),"id",id))
		`uvm_info("axi_3ch_sequence", $sformatf("get id value %0d via config_db",id), UVM_LOW)
     else 
		`uvm_error("axi_3ch_sequence", "can't get id value !!!")
     $display("get_full_name() = %s",get_full_name());
   endtask

   virtual task body();
      //if(starting_phase != null) 
      //   starting_phase.raise_objection(this);
      `uvm_info("axi_3ch_sequence", $sformatf("get id value %0d via config_db",id), UVM_LOW)      
      repeat (1) begin
         //`uvm_do_with(m_trans, {m_trans.pload.size < 500;})
	        `ifdef SEQ
	               for (int i=0;i<=`SIM_LEN;i++) begin
                		`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_write==1'b1;axi_len==`AXI_LEN;axi_waddr==i*8*16;axi_rd_wr==axi_transaction::AXI_SEQ_ONE;}  )
                		`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_write==1'b0;axi_len==`AXI_LEN;axi_raddr==i*8*16;axi_rd_wr==axi_transaction::AXI_SEQ_ONE;}  )
 	         	end
	        `elsif SALL
	        	  `uvm_do_with(m_trans,{axi_enable == 1'b1;axi_len==`AXI_LEN;axi_sim_cnt==`SIM_LEN;axi_waddr==`AXI_ADDR;axi_rd_wr==axi_transaction::AXI_SEQ_ALL;}  )         
	        `elsif RALL
       	               `uvm_do_with(m_trans,{axi_enable == 1'b1;axi_sim_cnt==`SIM_LEN;axi_rd_wr==axi_transaction::AXI_RAND_ALL;}  )	 
 	        `elsif WRRAND  //wr
			for (int i=0;i<=`SIM_LEN;i++) begin
 	                	`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_write==1'b1;axi_rd_wr==axi_transaction::AXI_SEQ_ONE;}  )
                		`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_write==1'b0;axi_rd_wr==axi_transaction::AXI_SEQ_ONE;}  )
			end
		`else
			`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_write==1'b1;axi_len==`AXI_LEN;axi_waddr==`AXI_ADDR;axi_rd_wr==axi_transaction::AXI_SEQ_ONE;}  )
                	`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_write==1'b0;axi_len==`AXI_LEN;axi_raddr==`AXI_ADDR;axi_rd_wr==axi_transaction::AXI_SEQ_ONE;}  )
 	        `endif
      end
	 `uvm_info("axi_3ch_sequence", "send one transaction", UVM_LOW)

      #100;
     // if(starting_phase != null) 
     //    starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(axi_3ch_sequence)
endclass


class axi_3ch_test extends base_test;

   function new(string name = "axi_3ch_test", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   `uvm_component_utils(axi_3ch_test)
   extern virtual task main_phase(uvm_phase phase);
endclass

task axi_3ch_test::main_phase(uvm_phase phase);
   apb_3ch_sequence seq0;
   axi_3ch_sequence seq1;
   axi_3ch_sequence seq2;
   axi_3ch_sequence seq3;

   phase.raise_objection(this);
   
   seq0 = new("seq0");
   //seq0.starting_phase = phase;
   seq1 = new("seq1");
   //seq1.starting_phase = phase;
   seq2 = new("seq2");
   //seq2.starting_phase = phase;
   seq3 = new("seq3");
   //seq3.starting_phase = phase;

   //uvm_config_db#(int)::set(null,seq1.get_full_name(),"id",0);
   //uvm_config_db#(int)::set(null,seq2.get_full_name(),"id",1);
   //uvm_config_db#(int)::set(null,seq3.get_full_name(),"id",2);
   //uvm_config_db#(int)::set(null,"uvm_test_top.env.axi_sqr0.*","id",0);
   //uvm_config_db#(int)::set(null,"uvm_test_top.env.axi_sqr1.*","id",1);
   //uvm_config_db#(int)::set(null,"uvm_test_top.env.axi_sqr2.*","id",2);
   uvm_config_db#(int)::set(null,"uvm_test_top.env.axi_sqr0.seq1","id",0);
   uvm_config_db#(int)::set(null,"uvm_test_top.env.axi_sqr1.seq2","id",1);
   uvm_config_db#(int)::set(null,"uvm_test_top.env.axi_sqr2.seq3","id",2);

   seq0.start(env.apb_sqr, null, 100);

   `uvm_info("axi_3ch_test", "APB CONFIG DONE !!!!!", UVM_LOW)

   //env.i_agt.sqr.set_arbitration(SEQ_ARB_STRICT_FIFO);
   //
   `ifdef NAMODE
	   `uvm_info("axi_3ch_test", "AXI NAMODE  START !!!!!", UVM_LOW)	   
  	   seq1.start(env.axi_sqr0, null, 200);
   	   //seq2.start(env.axi_sqr1, null, 300);
   	   //seq3.start(env.axi_sqr2, null, 400);
	   `uvm_info("axi_3ch_test", "AXI NAMODE  DONE !!!!!", UVM_LOW)	   
    `else
	   `uvm_info("axi_3ch_test", "AXI ABITOR  START !!!!!", UVM_LOW)	   
   	fork
   	   		#(`SEQ1_DELAY*50000)		seq1.start(env.axi_sqr0);
   	   		#(`SEQ2_DELAY*50000)		seq2.start(env.axi_sqr1);
   	   		#(`SEQ3_DELAY*50000)		seq3.start(env.axi_sqr2);
   	join
	//wait fork;
	   `uvm_info("axi_3ch_test", "AXI ABITOR  DONE !!!!!", UVM_LOW)	   

     `endif

      phase.drop_objection(this);


endtask

`endif
