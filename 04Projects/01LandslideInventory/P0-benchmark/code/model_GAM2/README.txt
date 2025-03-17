
This folder contains code to reproduce the susceptibility map calculated with model GAM2 in:
Alvioli et al., "A benchmark dataset and workflow for landslide susceptibility zonation"

The file su_benchmark_INLA_CV.R is the main code in R language. It can be executed in
a Rstudio or in a bash shell typing "Rscript > su_benchmark_INLA_CV.R". The only input
is su_benchmark_final.csv (containing the slope units-aggregated data described in the
paper), in the folder "workdir".

The code requires packages Hmisc (to calculate the cross-validation splits) and INLA,
to calculate the GAM model (https://www.r-inla.org/); see also Loche et l., (2022),
Earth-Science Reviews, 232, 104125 - https://doi.org/10.1016/j.earscirev.2022.104125

The output files will be in the folder "workdir".

----

Additional details & citation:

Alvioli, M., Loche, M., Jacobs et al., (2024). 
A benchmark dataset and workflow for landslide susceptibility zonation. 
Earth-Science Reviews, 258, 104927
https://doi.org/10.1016/j.earscirev.2024.104927