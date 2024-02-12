# ICDesign
 Automation of Vivado Runs

This project aims to automate the flow of projects made in vivado. Synthesis and implementation of many moudules can be done with just one tcl script and python code. 

To create and add the vivado project and modules, run this command in terminal:

"vivado -mode batch -source tcl_add.tcl"

manual/auto_add.tcl files are provided in the code section.

To run the modules in the project, run this command:

"vivado -mode batch -source tcl_run.tcl"

tcl_run.tcl file is provided in the code section.

Task is to make life easier by writing the python code that can automatically add and run all "Top" Modules in the project and genarate power, Delay and Utilization report for all modules in the specified folder and also make the comparison csv file or table.

Prerequisites: 

Vivado

Python3

VScode/Jupyterlab

Linux CentOS
