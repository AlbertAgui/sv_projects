SHELL = /bin/bash
WAVE_FILE = wave_test_test.do

TESTNAME ?= test
TESTBENCH ?= testbench

SCRIPTDIR = $(VERIF)/script
SIMDIR = $(VERIF)/sim
RTLDIR = $(VERIF)/rtl/dut
UVMDIR = $(VERIF)/uvc/top_uvm
BUILDIR = $(SIMDIR)/build
WORKDIR = $(BUILDIR)/work
COMP_TRANSCRIPT_FILE ?= $(SIMDIR)/comp_transcript
SIM_TRANSCRIPT_FILE ?= $(SIMDIR)/sim_transcript
WLF_FILE ?= $(BUILDIR)/$(TESTNAME).wlf
UVM_VERBOSITY ?= UVM_LOW
MODELSIMDIR ?= $(VERIF)/sim

TRANS_LOG_FILE_SRC = $(VERIF)/tr_db.log
TRANS_LOG_FILE_DST = $(BUILDIR)/tr_db.log
DUM_XML_SRC = $(VERIF)/certe_dump.xml
DUM_XML_DST = $(BUILDIR)/certe_dump.xml

all: clean compile run

export rtlfilelist = $(RTLDIR)/filelist/dut.f
export uvmfilelist = $(UVMDIR)/filelist/top_uvm.f

include ${SCRIPTDIR}/mk/vsim.mk

compile:
	mkdir -p ${BUILDIR}; \
	${VLOG} ${VLOG_FLAGS} -f ${rtlfilelist} -f ${uvmfilelist}

run:
	${VSIM} ${VSIM_FLAGS} +UVM_TESTNAME=${TESTNAME} ${TESTBENCH}; \
	if [ -e "${TRANS_LOG_FILE_SRC}" ]; then \
		mv ${TRANS_LOG_FILE_SRC} ${TRANS_LOG_FILE_DST}; \
	fi; \
	if [ -e "${DUM_XML_SRC}" ]; then \
		mv ${DUM_XML_SRC} ${DUM_XML_DST}; \
	fi

clean:
	rm -rf $(WORKDIR); \
	rm -f $(COMP_TRANSCRIPT_FILE) ${SIM_TRANSCRIPT_FILE} ${WLF_FILE}; \