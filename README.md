# StructJuMPwithMPI

[![Build Status](https://travis-ci.org/joehuchette/StructJuMPwithMPI.jl.svg?branch=master)](https://travis-ci.org/joehuchette/StructJuMPwithMPI.jl)

[![Coverage Status](https://coveralls.io/repos/joehuchette/StructJuMPwithMPI.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/joehuchette/StructJuMPwithMPI.jl?branch=master)

[![codecov.io](http://codecov.io/github/joehuchette/StructJuMPwithMPI.jl/coverage.svg?branch=master)](http://codecov.io/github/joehuchette/StructJuMPwithMPI.jl?branch=master)

A package that allows you to use StructJuMP with MPI to generate models in parallel. To use, load both packages, and pass the ``mpi_wrapper`` keyword argument to the ``StructuredModel`` constructor:

```jl
using JuMP, StructJuMP, StructJuMPwithMPI
model = StructuredModel(mpi_wrapper=mpi_wrapper)
```
