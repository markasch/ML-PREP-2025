# Seismic Wave Propagation

## Software Setup

For gseismic wave propagation, we will require a basic python environment with a number of specific packages that will be loaded when necessary. Please follow the instructions in this [document](../01_setup.pdf). 

### Python environment

A very basic python environment is needed for learning about wave propagation. 

```
conda create -n prep-wave
conda activet prep-wave

conda install jupyterlab numpy scipy matplotlib
jupyter lab

conda deactivate

```

### SPECFEM Code

Please follow carefully all the instructions provided in the official [documentation](https://specfem2d.readthedocs.io/en/latest/).


## Basic Course


Here we will cover some basic material undersatnding and simulating seismic wave propagation. 

The topics are:

- Harmonic waves (ODEs). 
- Acoustic wave equation.
- Waves in elastic media.
- Numerical methods for wave propagation. 
   - Finite differences.
   - Finite elements.
   - Spectral element method.