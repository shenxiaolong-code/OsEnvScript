# bash_script_i

echo +++++++++ loading /home/xlshen/scratch/bash_env/app/gdb/feature/pretty_printer/pretty_printer_gdb_func.gdb ...

define pstr
   echo string $arg0 value:
   # print (char*)$arg0._M_dataplus._M_p
   p $arg0->_M_stringbuf.str()
   # x/s $arg0._M_dataplus._M_p
end

document pstr
	Prints std::wstring string information.
	Syntax: pstr <wstring>
	Example:
	pstr stringVarName
	path : /home/xlshen/scratch/bash_env/app/gdb/feature/pretty_printer/pretty_printer_gdb_func.gdb
end 

define pstruct
   echo /home/xlshen/scratch/bash_env/app/gdb/feature/pretty_printer/pretty_printer_gdb_func.gdb:19\r\n
   echo cask6::StructureType $arg0 value: p $arg0->impl_->member_name_map_\r\n
   # print (char*)$arg0._M_dataplus._M_p
   p $arg0->impl_->member_name_map_
   # x/s $arg0._M_dataplus._M_p
end

document pstruct
	Prints cask6::StructureType type.
	Syntax: pstruct pObj
	Example:
	pstruct this
	path : /home/xlshen/scratch/bash_env/app/gdb/feature/pretty_printer/pretty_printer_gdb_func.gdb
end 

echo \r\n--------- leaving /home/xlshen/scratch/bash_env/app/gdb/feature/pretty_printer/pretty_printer_gdb_func.gdb ...\r\n 