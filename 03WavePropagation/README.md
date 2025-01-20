# Seismic Wave Propagation

## Software Setup

For seismic wave propagation, we will require a basic python environment and then an installation of the SPECFEM software packages.


### Python environment

A very basic python environment is needed for learning about wave propagation. 

```
conda create -n prep-wave
conda activate prep-wave

conda install jupyterlab numpy scipy matplotlib
jupyter lab

conda deactivate

```

### SPECFEM Code

Please follow carefully all the instructions provided in the official [documentation](https://specfem2d.readthedocs.io/en/latest/).


## Basic Course


Here we will cover some basic material for undersatnding and simulating seismic wave propagation. 

The topics are:

- Harmonic waves (ODEs). 
- Acoustic wave equation.
- Waves in elastic media.
- Numerical methods for wave propagation. 
   - Finite differences.
   - Finite elements.
   - Spectral element method.
   
### Lecture Notes

- basic theory: [slides](./01_waveprop.pdf)   

### Examples

**NOTE**: the interactive graphics require the installation of a special package

> conda install -c conda-forge ipympl

- 1D vibration ODE: [notebook](./Examples/01vibes.ipynb)
- 2D acoustic wave equation in heterogeneous medium: [notebook](./Examples/02FD_2D_Acoustic.ipynb)
- Animation tutorial [notebook](./Examples/00ani_wave.ipynb)

## References

1. H.P. Langtangen. *Finite Difference Computing with PDEs: A Modern Software Approach.* Springer Cham. 2017. [download pdf](https://link.springer.com/book/10.1007/978-3-319-55456-3)
2. H. Igel. Computational Seismology: A Practical Introduction. Oxford University Press, 2017. [Website](https://seismo-live.github.io/)
3. [SPECFEM2D](http://specfem2d.readthedocs.io/)
4. [SPECFEM3D](http://specfem3d.readthedocs.io/)

