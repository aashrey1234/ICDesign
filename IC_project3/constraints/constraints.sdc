create_clock -name clock -period 3 -waveform {0 1.5} [get_ports "clock"]
set_clock_transition -rise 0.001 [get_clocks "clock"]
set_clock_transition -fall 0.001 [get_clocks "clock"]
set_clock_uncertainty 0.01 [get_ports "clock"]

set_units -capacitance fF

set_load -pin_load 5 [get_ports {mem_data_write_out}]

set_load -pin_load 5 [get_ports {mem_write_en}]

set_load -pin_load 5 [get_ports {aluout}]



set_load -pin_load 5 [get_ports "carry"]

