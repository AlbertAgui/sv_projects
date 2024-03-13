include ${SCRIPTDIR}/mk/random.mk

# Executables
VLOG           = vlog
VSIM           = vsim
VSIM_WAVES_DO ?= $(SCRIPTDIR)/waves.tcl

# VLOG (compile)
VLOG_FLAGS        += -modelsimini $(MODELSIMDIR)/modelsim.ini
VLOG_FLAGS        += +acc
VLOG_FLAGS        += -sv
VLOG_FLAGS        += -l $(COMP_TRANSCRIPT_FILE)
VLOG_FLAGS        += -svinputport=compat
VLOG_FLAGS        += -work $(WORKDIR)
VLOG_FLAGS        += -timescale "1ns/1ps"
VLOG_FLAGS        += -pedanticerrors

ifdef ASSERTION
VLOG_FLAGS        += +define+ASSERTION
endif

# VSIM (simulation)
VSIM_FLAGS        += -modelsimini $(MODELSIMDIR)/modelsim.ini
VSIM_FLAGS        += -work $(WORKDIR)
VSIM_FLAGS        += -l $(SIM_TRANSCRIPT_FILE)
VSIM_FLAGS        += -syncio
VSIM_FLAGS        += -sv_seed $(RNDSEED)
VSIM_FLAGS        += -nostdout
VSIM_FLAGS        += +UVM_VERBOSITY=${UVM_VERBOSITY}
VSIM_FLAGS		  += -optionset UVMDEBUG
VSIM_FLAGS        += -wlfcompress -wlf ${WLF_FILE} 
VSIM_FLAGS        += -do "set NoQuitOnFinish 1"
VSIM_FLAGS        += -pedanticerrors


################################################################################
# Waveform generation
ifdef WAVES
VSIM_FLAGS += -do $(VSIM_WAVES_DO)
endif

################################################################################
# Interactive simulation
ifdef GUI
VSIM_FLAGS += -gui
else
VSIM_FLAGS += -batch
VSIM_FLAGS += -do "run -all;"
VSIM_FLAGS += -do "exit;"
endif

