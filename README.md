# CPEN511 Project

SISYPHUS: Exploring the Impact of Vectorization on Branch Prediction

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- riscv-gnu-toolchain
- spike
- pk

They can be installed via scripts found in the /utils folder.

### Running

```shell
make build USE_VECTOR=<0|1>
make run BENCHMARK=<edn|matmult-int|nbody|st|ud> PREDICTOR_ID=<0|1|2>
```

#### Predictor IDs
- 0 : (m=1,n=3) correlating branch predictor
- 1 : gshare branch predictor
- 2 : perceptron branch predictor

## Source Code

The source code files for the project are located at :
```
  └── embench                   *** Scalar and vectorized benchmarks ***     
      └── src   
          └── edn
          └── matmult-int
          └── nbody
          └── st
          └── ud
  └── riscv-isa-sim             *** Branch predictors ***
      └── riscv
      └── spike-main
```

## Authors

* **Joseph Maheshe** - *Initial work*
