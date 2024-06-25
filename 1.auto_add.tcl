#open project
open_project [pwd]/Automation/aashrey.xpr 

# loop to add all design files
add_files -norecurse [pwd]/Modules1/[lindex $argv 0]
update_compile_order -fileset sources_1
close_project
