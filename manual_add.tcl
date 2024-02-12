#open project
open_project [pwd]/Automation/automated.xpr  



# loop to add all design files
#add_files -norecurse [pwd]/[lindex $argv 0]
#add_files -norecurse [pwd]/Modules1/top_counter.v
add_files -norecurse /home/aashrey/virtualenv/Digital_IC_design_lab/Modules1/top_alubit.v
add_files -norecurse /home/aashrey/virtualenv/Digital_IC_design_lab/Modules1/top_knowels_bit.v
add_files -norecurse /home/aashrey/virtualenv/Digital_IC_design_lab/Modules1/top_koggestone_bit.v
add_files -norecurse /home/aashrey/virtualenv/Digital_IC_design_lab/Modules1/top_lander_fisher_bit.v
add_files -norecurse /home/aashrey/virtualenv/Digital_IC_design_lab/Modules1/top_master_slave.v
add_files -norecurse /home/aashrey/virtualenv/Digital_IC_design_lab/Modules1/top_mealy.v
add_files -norecurse /home/aashrey/virtualenv/Digital_IC_design_lab/Modules1/top_moore.v
add_files -norecurse /home/aashrey/virtualenv/Digital_IC_design_lab/Modules1/top_ripplebit.v
    update_compile_order -fileset sources_1
close_project
