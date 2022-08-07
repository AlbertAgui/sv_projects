#include
+incdir+../../../src/include/

#packages
#../../../src/package/riscv_pkg/riscv_pkg.sv
#../../../src/package/vpu_pkg.sv

#behavioural
../../../src/rtl/submodules.sv
#../../../src/rtl/mod_smu.sv

#testbench
#../src/mod_smu_tb.sv
../src/circular_buffer_tb.sv