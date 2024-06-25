
set clkPeriod 0.2
#set TOP top_Processor



############################################################
#Cd to ....../Project/run
# : csh
# : source ~/cshrc_new_version
#Launch Genus using the command: genus -legacy_ui 

#Start typing in the commands from rc_script.tcl one at a time 
#Or To source the whole script file, source ../scripts/synthesis.tcl

#Step1: Set library paths
#rm designs/*
#set_attr init_lib_search_path /opt/tools/Cadence/Cadence_lib/UMC65nm_PDK/STDCELLS/synopsys/ccs/
set_attr init_lib_search_path {/opt/tools/Cadence/Cadence_lib/scl_pdk_v2/design_kit/stdlib/fs120/liberty/lib_flow_ss /opt/tools/Cadence/Cadence_lib/scl_pdk_v2/design_kit/stdlib/fs120/liberty/lib_flow_ff}
set_attr hdl_search_path ../rtl/
#set_attr library uk65lscllmvbbr_120c25_tc_ccs.lib
set_attr library { /opt/tools/Cadence/Cadence_lib/scl_pdk_v2/design_kit/stdlib/fs120/liberty/lib_flow_ss/tsl18fs120_scl_ss.lib /opt/tools/Cadence/Cadence_lib/scl_pdk_v2/iolib/cio150/synopsys/2002.05/models/tsl18cio150_max.lib /opt/tools/Cadence/Cadence_lib/scl_pdk_v2/design_kit/stdlib/fs120/liberty/lib_flow_ff/tsl18fs120_scl_ff.lib /opt/tools/Cadence/Cadence_lib/scl_pdk_v2/iolib/cio150/synopsys/2002.05/models/tsl18cio150_min.lib}


#Step 2: Read netlist
read_hdl -sv ARITH_ALU.sv
read_hdl -sv SHIFT_ALU.sv
read_hdl -sv Stage1_Execute.sv
read_hdl -sv Stage2_ALU.sv
read_hdl -sv top_Processor.sv
#read_hdl AIMC_DECODER_5X32_RW.v
#Step 3: Elaborate/connect all modules
elaborate
set_top_module top_Processor
# elaborate looks for undefined modules in the directories specified through the -libpath option

#gui_show 
#Check schematic by clicking on + --> Close --> Hide GUI (do not hit exit)
#Step 4: Read constraints
#create_constraint_mode -name cstr_mode_AW1_MODE \
#-sdc_files ../constraints/constraints.sdc

#create_analysis_view -name AW1_MODE \
#-constraint_mode cstr_mode_AW1_MODE \
#-delay_corner default_emulate_delay_corner
read_sdc ../constraints/constraints.sdc
#This is part of sdc: create_clock -name clk -period 2 -waveform {0 1} [get_ports "clk"] --> 2--> ns
#Slack is in ps


#Step 4: Synthesise the  design to generic gates and set the effort level
set_attr syn_generic_effort high
syn_generic

#gui_show
#suspend - to stop here and observe the results


#syn_map: Maps  the  design  to  the  cells  described in the supplied technology library and performs logic optimization.
syn_map

#Step 5: Report results before optimisation
#report_power >power.txt
#gui_show
#report_gates 
#suspend

#Step 6: Optimise and run synthesis- key step
#Performs  gate  level  optimization to improve timing on critical paths
set_attr syn_opt_effort high
syn_opt

#Step 7: Report results after optimisation
#report_gates 
#report_power >power.txt

#Step 8 Check design for timing errors
check_design > design_check.txt
#suspend

#Step 9: Write out synthesised netlist and constraints- important output

#Step 10: Report final results
#report_gates 
report_area > area.txt
report_power > power.txt
report_timing > timing.txt
report_gates > gates.txt
#suspend  --> Change constraints --clock, redo read_hdc, syn_generic, syn_map, syn_opt and report_timing --> to check slack.

write_hdl > DLX_sync_syn.v
write_sdc > DLX_sync_syn.sdc  
write_sdf > DLX_sync_syn.sdf 
#write_hdl > ${TOP}_syn.v
#write_sdc > ${TOP}_syn.sdc  
#write_sdf > ${TOP}_sdf.sdf  
#suspend
#write_template -simple -outfile simple_template.txt
#write_template -power -outfile template_power.tcl
#write_template -area -outfile template_area.tcl
#write_template -full -outfile template_full.tcl
#write_template -retime -outfile template_retime.tcl
#quit
#Hit quit to exit Genus. Do not do Ctrl+C, you will be holding up licenses
