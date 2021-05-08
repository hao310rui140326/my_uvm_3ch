DUMP=NONE
LONG=NONE
CASE=apb_case0
UVM_INFO=UVM_LOW
FORCE=NONE
MODE=NORMAL
TMODE=SEQ
AMODE=NAMODE
SIM_LEN=64
AXI_LEN=15
AXI_ADDR=0
SEQ1_DELAY=0
SEQ2_DELAY=0
SEQ3_DELAY=0
GUI=NONE

verdi_path = /usr/synopsys/Verdi3_L-2016.06-1

ifeq ("$(GUI)","GUI")
GUI_OPTS += -gui=verdi
UVM_OPTS += +UVM_VERDI_TRACE="UVM_AWARE+RAL+HIER+COMPWAVE" +UVM_TR_RECORD +UVM_LOG_RECORD  
else
GUI_OPTS += "" 	
UVM_OPTS += ""
endif


VCS_OPTS +=  -full64 
VCS_OPTS +=  -cpp g++-4.8 -cc gcc-4.8 
VCS_OPTS +=  -lca -kdb  
VCS_OPTS +=  -timescale=1ns/1ps   
VCS_OPTS +=  -P  $(verdi_path)/share/PLI/VCS/LINUX64/novas.tab   $(verdi_path)/share/PLI/VCS/LINUX64/pli.a 
VCS_OPTS +=  +vcs+lic+wait

##VCS_OPTS +=  -sverilog +verilog2001ext+.v  +lint=TFIPC-L  -ntb_opts uvm
VCS_OPTS +=  -sverilog ../../uvm-1.1d/src/dpi/uvm_dpi.cc  -CFLAGS -DVCS  +verilog2001ext+.v  +lint=TFIPC-L  

VCS_OPTS +=  +define+UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTO  
VCS_OPTS +=  -debug_all 
##VCS_OPTS += -debug_access+pp


COV_OPTS +=  -cm line+cond+fsm+tgl+branch+assert -cm_dir ./cov_info 
CASE_OPTS += +UVM_TESTNAME=${CASE} +UVM_VERBOSITY=${UVM_INFO} 

COMPILE_TIME = $(shell date +"%Y-%m-%d-%H-%M-%S")


default:
	rm -rf $(CASE) ; mkdir case_$(MODE)_$(TMODE)_$(AMODE)_$(CASE)_$(COMPILE_TIME); cd case_$(MODE)_$(TMODE)_$(AMODE)_$(CASE)_$(COMPILE_TIME);echo "\`define  $(DUMP)       "  >    define.v ; echo "\`define  $(LONG)       "  >>   define.v ;echo "\`define  $(UVM_INFO)       "  >>   define.v ;echo "\`define  $(FORCE)       "  >>   define.v ;echo "\`define  $(MODE)       "  >>   define.v ;echo "\`define  $(TMODE)       "  >>   define.v ;echo "\`define  $(AMODE)       "  >>   define.v ;echo "\`define  AXI_LEN  $(AXI_LEN)       "  >>   define.v ;echo "\`define  AXI_ADDR  $(AXI_ADDR)       "  >>   define.v ;echo "\`define  SIM_LEN  $(SIM_LEN)       "  >>   define.v ; echo "\`define  SEQ1_DELAY  $(SEQ1_DELAY)       "  >>   define.v ;echo "\`define  SEQ2_DELAY  $(SEQ2_DELAY)       "  >>   define.v ; echo "\`define  SEQ3_DELAY  $(SEQ3_DELAY)       "  >>   define.v ;cp  ../makefile  ../../env/ddr3_parameters.vh  ../../env/vip/tvip_axi_defines.svh  ../../env/reg_define.v        ./  ; vcs  $(VCS_OPTS)   -f ../tb.vc -top  tb_top  $(COV_OPTS)   $(UVM_OPTS)    -l vcs_com.log ; ./simv   +model_data+"./"      $(CASE_OPTS)    $(COV_OPTS)       -l vcs_sim_$(MODE)_$(TMODE)_$(AMODE)_${CASE}.log $(GUI_OPTS)   $(UVM_OPTS)

verdi:
	rm -rf  my_verdi  ; mkdir my_verdi; cd my_verdi;  cp ../define.v   ../../env/ddr3_parameters.vh  ../../env/vip/tvip_axi_defines.svh  ../../env/reg_define.v     ./;  verdi -sv  -f ../tb.vc  -top tb_top &


verdi_simv:
	verdi  -elab simv.daidir/kdb  &
verdi_f:
	verdi -sv  -f ../tb.vc  -top tb_top &

dve:
	dve -full64 -vpd vcdplus.vpd &

clean:
	rm -rf *simv*  *csrc   *~ verdiLog  novas*  ucli.key  *.vpd  *.fsdb  vc_hdrs.h  *.log *case*   my_verdi   cov_report  DVEfiles 
	

cov:
	urg   -full64  -dir     ./*case*/cov_info.vdb    -metric line+cond+fsm+tgl+branch+assert -report   ./cov_report   -format both
	/home/software/firefox/firefox  ./cov_report/hierarchy.html  &

grep:
	grep "CASE"  ./*case*/vcs*.log


gen_v:
	perl my_cat.pl vp.vc   all_vp.sv  vp
	perl my_cat.pl dut.vc  dut.sv v
	perl my_cat.pl lib.vc  lib.sv v
	cat  ../../../example_design/bench/mem/ddr3.sv   >> all.sv
	##vcs -full64 +sv  -protect128 all.sv



