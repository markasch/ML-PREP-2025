
This folder contains:

1) R code auc_roc.R to calculate ROC values from the attribute tables of the vector
layers su_bench_pres1 and su_bench_pres1, distributed with the paper: "A benchmark
dataset and workflow for landslide susceptibility zonation".

The code auc_roc.R should be run in a bash terminal within a GRASS GIS mapset, and
it requires packages rgrass and pROC. It can be executed with "Rscript auc_roc.R"


2) A bash script brier_score.sh to calculate brier scores from the attribute tables
of the same layers. The script must be run from within a GRASS GIS mapset containing
the vector layers, using the default SQlite GRASS GIS database manager.

----

Additional details & citation:

Alvioli, M., Loche, M., Jacobs et al., (2024). 
A benchmark dataset and workflow for landslide susceptibility zonation. 
Earth-Science Reviews, 258, 104927
https://doi.org/10.1016/j.earscirev.2024.104927