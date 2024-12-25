# Seismic Wave Propagation

## Software Setup

For gseismic wave propagation, we will require a basic python environment and then an installation of the SPECFEM software packages.


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


Here we will cover some basic material for undersatnding and simulating seismic wave propagation. 

The topics are:

- Harmonic waves (ODEs). 
- Acoustic wave equation.
- Waves in elastic media.
- Numerical methods for wave propagation. 
   - Finite differences.
   - Finite elements.
   - Spectral element method.
   
   
## References

1. H.P. Langtangen. *Finite Difference Computing with PDEs: A Modern Software Approach.* Springer Cham. 2017. [download pdf]()
2. H. Igel. Computational Seismology: A Practical Introduction. Oxford University Press, 2017. [Website](https://seismo-live.github.io/)
3. [SPECFEM2D](http://specfem2d.readthedocs.io/)
4. [SPECFEM3D](http://specfem3d.readthedocs.io/)

