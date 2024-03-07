SHELL = /bin/bash
WAVE_FILE = wave_test_test.do

TESTNAME ?= test
TESTBENCH ?= testbench

SCRIPTDIR = $(VERIF)/script
SIMDIR = $(VERIF)/sim
RTLDIR = $(VERIF)/rtl/dut
UVMDIR = $(VERIF)/uvc/uvm
BUILDIR = $(SIMDIR)/build
WORKDIR = $(BUILDIR)/work
COMP_TRANSCRIPT_FILE ?= $(SIMDIR)/comp_transcript
SIM_TRANSCRIPT_FILE ?= $(SIMDIR)/sim_transcript
WLF_FILE ?= $(BUILDIR)/$(TESTNAME).wlf
UVM_VERBOSITY ?= UVM_LOW
MODELSIMDIR ?= $(VERIF)/sim

all: clean compile run

export rtlfilelist = $(RTLDIR)/filelist/dut.f
export uvmfilelist = $(UVMDIR)/filelist/uvm.f

include ${SCRIPTDIR}/mk/vsim.mk

compile:
	cd $(VERIF)
	mkdir -p ${BUILDIR}
	${VLOG} ${VLOG_FLAGS} -f ${rtlfilelist} -f ${uvmfilelist}

run:
	cd $(VERIF)
	${VSIM} ${VSIM_FLAGS} +UVM_TESTNAME=${TESTNAME} ${TESTBENCH}

clean:
	cd $(VERIF)
	rm -rf $(WORKDIR)
	rm -f $(COMP_TRANSCRIPT_FILE) ${SIM_TRANSCRIPT_FILE} ${WLF_FILE}