#
# This script works in a GRASS GIS mapset containing vector layers
# su_bench_pres1 and su_bench_pres1, described in the paper:
# "A benchmark dataset and workflow for landslide susceptibility zonation"
# Results for AUC_ROC values will be in files: roc_step2_presence[1,2].txt
#
# An alternative to using GRASS GIS is intalling the package terra and
# import the shapefiles (not tested):
#
# library(terra)
# data1 <- system.file("su_bench_pres1.shp", package="terra")
# data2 <- system.file("su_bench_pres2.shp", package="terra")
#
# ---
#
library(rgrass)
library(pROC)
#
# ---
#
data1 <- read_VECT("su_bench_pres1")
#
file.remove("roc_step2_presence1.txt")        # delete file
writeLines("", "roc_step2_presence1.txt")     # create file
CON <- file("roc_step2_presence1.txt", "a")   # open connection to append
j=0
for(i in 4:19) {
   j=j+1
   data_tmp <- as.data.frame(cbind(data1[,2],data1[,i]))
   metodo <- names(data1[,i])
   colnames(data_tmp) <- c("x","y")
   tmp_roc <- roc(data_tmp$x,as.numeric(data_tmp$y))   
   writeLines(paste(as.character(j),as.character(i),as.character(metodo),as.character(tmp_roc$auc)), CON) # append i-th AUC value
}
close(CON)
#
# ---
#
data2 <- read_VECT("su_bench_pres2")
#
file.remove("roc_step2_presence2.txt")        # delete file
writeLines("", "roc_step2_presence2.txt")     # create file
CON <- file("roc_step2_presence2.txt", "a")   # open connection to append
j=0
for(i in c(4:19)) {
   j=j+1
   data_tmp <- as.data.frame(cbind(data2[,2],data2[,i]))
   metodo <- names(data2[,i])
   colnames(data_tmp) <- c("x","y")
   tmp_roc <- roc(data_tmp$x,as.numeric(data_tmp$y))   
   writeLines(paste(as.character(j),as.character(i),as.character(metodo),as.character(tmp_roc$auc)), CON) # append i-th AUC value
}
close(CON)
#
# ---
#


