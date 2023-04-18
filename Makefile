###############################################################
# Paths to executable
###############################################################
# Fill paths
###############################################################
gcc := /path/to/.../bin/riscv32-unknown-elf-gcc
spike := /path/to/.../bin/spike
pk := /path/to/.../bin/pk
###############################################################

###############################################################
#Embench
#Assumes binaries are in the BENCHMARK_DIR
EMBENCH_DIR=embench
EMBENCH_BENCHMARKS =  \
edn \
matmult-int \
nbody \
st \
ud

#add file path to benchmarks
embench_bins = $(addprefix $(EMBENCH_DIR)/build/bin/, $(EMBENCH_BENCHMARKS))

#embench benchmarks copied into a bin folder to simplify makefile rules
.PHONY: build
build :
	$(EMBENCH_DIR)/build_all.py -v --cpu-mhz 1000 --clean --use-vector $(USE_VECTOR) --builddir build --arch riscv32 --chip generic --board ri5cyverilator --cc $(gcc) --cflags="-c -O2 -fno-tree-vectorize -ffunction-sections -march=rv32imafdv -mabi=ilp32d" --ldflags="-Wl,-gc-sections" --user-libs="-lm"
	mkdir -p $(EMBENCH_DIR)/build/bin
	$(foreach x,$(EMBENCH_BENCHMARKS), mv $(EMBENCH_DIR)/build/src/$(x)/$(x) $(EMBENCH_DIR)/build/bin/$(x);)

.PHONY: run
run :
	$(spike) --isa=rv32imafdv --varch=vlen:4096,elen:64 -g --predictor=$(PREDICTOR_ID) $(pk) -s $(EMBENCH_DIR)/build/bin/$(BENCHMARK) 
	
#Benchmarks built by build_embench
.PHONY : $(embench_bins)

.PHONY: clean
clean : 
	rm -rf $(EMBENCH_DIR)/build/ $(EMBENCH_DIR)/logs/

