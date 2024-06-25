##open the created vivado project
open_project [pwd]/Automation/automated.xpr  


# The command allows the user to set the top module manually

set_property source_mgmt_mode None [current_project]  
update_compile_order -fileset sources_1	
 
set_property top [string trimright [lindex $argv 0] ".v"] [current_fileset]
set_property source_mgmt_mode None [current_project]
update_compile_order -fileset sources_1

# reset and launch the synthesis and implementation. THe process waits till next command is executed

reset_run synth_1  
launch_runs synth_1 -jobs 16
wait_on_run synth_1
    

reset_run impl_1
launch_runs impl_1 -jobs 16
wait_on_run impl_1

# If implementation is run, the reports are generated and saved in Impl folder
open_run impl_1
report_power > Impl/[string trimright [lindex $argv 0] ".v"]/power.txt
report_timing > Impl/[string trimright [lindex $argv 0] ".v"]/timing.txt
report_utilization > Impl/[string trimright [lindex $argv 0] ".v"]/utilization.txt
update_compile_order -fileset sources_1
close_project
