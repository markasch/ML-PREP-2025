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


## Introduction to Wave Propagation


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
- 2D acoustic wave equation in heterogeneous medium: [notebook1](./Examples/02FD_2D_Acoustic-V1.ipynb), [notebook2](./Examples/02FD_2D_Acoustic-V2.ipynb)
- Animation tutorial [notebook](./Examples/00ani_wave.ipynb)
- 1D spectral element code in a homogeneous medium  [notebook](./Examples/03_SpectralElements_homogeneous.ipynb)
- 1D spectral element code in a heterogeneous medium  [notebook](./Examples/04_SpectralElements_Heterogeneous.ipynb)


## Wave Propagation with SPECFEM

Based on the theoretical formulation of the spectral element method, we examine the highly reputable family of codes, [SPECFEM](https://specfem.org/). 

### Lecture notes on SPECFEM

- introduction and installation: [slides](./02_specfem.pdf)


### Examples

- calculating a spectrogram of a sinusoidal function: [notebook](./Examples/specfem/01spectrogram_sine.ipynb)
- displaying seismograms from SPECFEM: [notebook](./Examples/specfem/02seismo_1_to_10.ipynb)


### SPECFEM2D Examples

- 4-layer with topography, curved interfaces and a fluid layer [directory](./SPECFEM/Notebook1)
- semi-infinite homogeneous half-space example [directory](./SPECFEM/Notebook2)
- exercise on half-space example  [directory](./SPECFEM/Exercise1)

### SPECFEM3D Examples

- homogeneous half-space, and
- 2-layer half-space  [markdown](./SPECFEM/Notebook3/3_intro_specfem3d/3_intro_specfem3d.md),  [notebook](./SPECFEM/Notebook3/3_intro_specfem3d.ipynb), 

**Note**: this example requires a full installation of SPECFEM3D with MPI, or the use of a relevant container.


## References

1. H.P. Langtangen. *Finite Difference Computing with PDEs: A Modern Software Approach.* Springer Cham. 2017. [download pdf](https://link.springer.com/book/10.1007/978-3-319-55456-3)
2. H. Igel. Computational Seismology: A Practical Introduction. Oxford University Press, 2017. [Website](https://seismo-live.github.io/)
3. [SPECFEM2D](http://specfem2d.readthedocs.io/)
4. [SPECFEM3D](http://specfem3d.readthedocs.io/)

