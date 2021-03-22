`ifndef AXI_3CH__SV
`define AXI_3CH__SV
class apb_3ch_sequence extends uvm_sequence #(apb_transaction);
   apb_transaction m_trans;

   function  new(string name= "apb_3ch_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
	
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
	`else
		`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==8'he0;apb_wdata=='h0000;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_info("apb_3ch_sequence", "No Arbitor mode  !!!", UVM_LOW)      						
	`endif
 	
 	`ifdef MRS
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h4001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 
		wait(tb_top.apbd.apb_rdata=='d3);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 		
		 wait(tb_top.apbd.apb_rdata=='d0);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 		
	`elsif SR
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h8001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 
		wait(tb_top.apbd.apb_rdata=='d1);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h0001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )		
		wait(tb_top.apbd.apb_rdata=='d0);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )
	`elsif PD
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='hc001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 
		wait(tb_top.apbd.apb_rdata=='d2);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h0001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 	 
		wait(tb_top.apbd.apb_rdata=='d0);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )
	`else
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==4;apb_wdata=='h0001;apb_rd_wr==apb_transaction::APB_WRITE;}  )
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 
		wait(tb_top.apbd.apb_rdata=='d0);
         	`uvm_do_with(m_trans,{apb_enable == 1'b1;apb_addr==5;apb_rd_wr==apb_transaction::APB_READ;}  )	 
	`endif
      
         `uvm_info("apb_3ch_sequence", "send one transaction", UVM_LOW)      
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(apb_3ch_sequence)
endclass

class axi_3ch_sequence extends uvm_sequence #(axi_transaction);
   axi_transaction m_trans;

   function  new(string name= "axi_3ch_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (1) begin
         //`uvm_do_with(m_trans, {m_trans.pload.size < 500;})
	        `ifdef SEQ
	               for (int i=0;i<=`SIM_LEN;i++) begin
                		`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_write==1'b1;axi_len==`AXI_LEN;axi_waddr==i*8*16;axi_rd_wr==axi_transaction::AXI_SEQ_ONE;}  )
                		`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_write==1'b0;axi_len==`AXI_LEN;axi_raddr==i*8*16;axi_rd_wr==axi_transaction::AXI_SEQ_ONE;}  )
 	         	end
	        `elsif SALL
	        	//`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_len==`AXI_LEN;axi_sim_cnt==`SIM_LEN;axi_waddr==`AXI_ADDR;axi_rd_wr==axi_transaction::AXI_SEQ_ALL;}  )         
	        	`uvm_do_with(m_trans,{axi_enable == 1'b1;axi_len==`AXI_LEN;axi_sim_cnt==`SIM_LEN;axi_rd_wr==axi_transaction::AXI_SEQ_ALL;}  )         
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
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
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

   seq0 = new("seq0");
   seq0.starting_phase = phase;
   seq1 = new("seq1");
   seq1.starting_phase = phase;
   seq2 = new("seq2");
   seq2.starting_phase = phase;
   seq3 = new("seq3");
   seq3.starting_phase = phase;


   seq0.start(env.apb_sqr, null, 100);

   //env.i_agt.sqr.set_arbitration(SEQ_ARB_STRICT_FIFO);
   fork
      //seq1.start(env.axi_sqr0, null, 200);
      //seq2.start(env.axi_sqr1, null, 300);
      //seq3.start(env.axi_sqr2, null, 400);

      	#(`SEQ1_DELAY*50000)		seq1.start(env.axi_sqr0);
      	#(`SEQ2_DELAY*50000)		seq2.start(env.axi_sqr1);
      	#(`SEQ3_DELAY*50000)		seq3.start(env.axi_sqr2);

   join
endtask

`endif
