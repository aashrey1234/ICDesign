## ICDesign
 This repository contains two projects.
# 1. Automation of Vivado synthesis and Implementation steps.

This project aims to automate the flow of projects made in Vivado. Synthesis and implementation of many modules can be done with just one tcl script and Python code. 

To create and add the Vivado project and modules, run this command in the terminal:

"vivado -mode batch -source manual/auto_add.tcl"

manual/auto_add.tcl files are provided in the code section.

To run the synthesis and implementation of the modules in the project, run this command:

"vivado -mode batch -source tcl_run.tcl"

tcl_run.tcl file is provided in the code section.

The task is to make life easier by writing the Python code that can automatically add and run all "Top" Modules in the project and generate power, Delay, and Utilization reports for all modules in the specified folder and also make the comparison CSV file or table.

Python code is self-explanatory. see code.ipynb and auto_code.ipynb corresponding to manual_add and auto_add tcl files.

Prerequisites: 

Vivado

Python3

VScode/Jupyterlab

Linux CentOS

## 2. Image processing in HDL

This project tries to implement the image enhancement hardware in Verilog. The steps to be carried out are shown below.
![image](https://github.com/aashrey1234/ICDesign/assets/155153682/7b7e2870-c5b9-4ae5-95ab-fe3aeb3dd735)

