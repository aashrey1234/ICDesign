# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Fri Apr 19 16:13:13 EDT 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design top_Processor

create_clock -name "clock" -period 3.0 -waveform {0.0 1.5} [get_ports clock]
set_clock_transition 0.001 [get_clocks clock]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[31]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[30]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[29]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[28]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[27]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[26]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[25]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[24]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[23]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[22]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[21]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[20]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[19]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[18]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[17]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[16]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[15]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[14]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[13]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[12]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[11]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[10]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[9]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[8]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[7]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[6]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[5]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[4]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[3]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[2]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[1]}]
set_load -pin_load 0.005 [get_ports {mem_data_write_out[0]}]
set_load -pin_load 0.005 [get_ports mem_write_en]
set_load -pin_load 0.005 [get_ports {aluout[31]}]
set_load -pin_load 0.005 [get_ports {aluout[30]}]
set_load -pin_load 0.005 [get_ports {aluout[29]}]
set_load -pin_load 0.005 [get_ports {aluout[28]}]
set_load -pin_load 0.005 [get_ports {aluout[27]}]
set_load -pin_load 0.005 [get_ports {aluout[26]}]
set_load -pin_load 0.005 [get_ports {aluout[25]}]
set_load -pin_load 0.005 [get_ports {aluout[24]}]
set_load -pin_load 0.005 [get_ports {aluout[23]}]
set_load -pin_load 0.005 [get_ports {aluout[22]}]
set_load -pin_load 0.005 [get_ports {aluout[21]}]
set_load -pin_load 0.005 [get_ports {aluout[20]}]
set_load -pin_load 0.005 [get_ports {aluout[19]}]
set_load -pin_load 0.005 [get_ports {aluout[18]}]
set_load -pin_load 0.005 [get_ports {aluout[17]}]
set_load -pin_load 0.005 [get_ports {aluout[16]}]
set_load -pin_load 0.005 [get_ports {aluout[15]}]
set_load -pin_load 0.005 [get_ports {aluout[14]}]
set_load -pin_load 0.005 [get_ports {aluout[13]}]
set_load -pin_load 0.005 [get_ports {aluout[12]}]
set_load -pin_load 0.005 [get_ports {aluout[11]}]
set_load -pin_load 0.005 [get_ports {aluout[10]}]
set_load -pin_load 0.005 [get_ports {aluout[9]}]
set_load -pin_load 0.005 [get_ports {aluout[8]}]
set_load -pin_load 0.005 [get_ports {aluout[7]}]
set_load -pin_load 0.005 [get_ports {aluout[6]}]
set_load -pin_load 0.005 [get_ports {aluout[5]}]
set_load -pin_load 0.005 [get_ports {aluout[4]}]
set_load -pin_load 0.005 [get_ports {aluout[3]}]
set_load -pin_load 0.005 [get_ports {aluout[2]}]
set_load -pin_load 0.005 [get_ports {aluout[1]}]
set_load -pin_load 0.005 [get_ports {aluout[0]}]
set_load -pin_load 0.005 [get_ports carry]
set_clock_gating_check -setup 0.0 
set_wire_load_mode "enclosed"
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb2]
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb1]
set_dont_use true [get_lib_cells tsl18fs120_scl_ss/slbhb4]
set_clock_uncertainty -setup 0.01 [get_ports clock]
set_clock_uncertainty -hold 0.01 [get_ports clock]