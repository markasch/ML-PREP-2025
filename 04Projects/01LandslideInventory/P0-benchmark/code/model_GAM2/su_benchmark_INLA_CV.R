################################################################################
################## Binomial Model in INLA #####################################
##############################################################################
library(Hmisc)
library(INLA)

n=7360
n.partition=c(rep(736,10))
idxlist=partition.vector(sample(1:n,size=n),n.partition)

setwd("workdir/")
benchmark_data = read.delim("su_benchmark_final.csv", sep = "\t", header = T)
benchmark_data[benchmark_data == -99999 | benchmark_data == -9999] = NA
benchmark_data = na.omit(benchmark_data)
names(benchmark_data)

data_scaled=benchmark_data
vars2scale=c("slope_aver","tcurv_aver","nthns_aver","nthns_stdd","easns_aver",
             "easns_stdd","twi_stddev","BLDFIE_ave","BLDFIE_std","CLYPPT_ave",
             "SLTPPT_ave","SLTPPT_std","SNDPPT_ave","D_sqrt_A","lito2_perc",
             "lito6_perc","lito8_perc","lito11_perc","lito12_perc")

data_scaled[,vars2scale]=apply(data_scaled[,vars2scale],2,scale)

covars=data_scaled[,c("slope_aver","tcurv_aver","nthns_aver","nthns_stdd","easns_aver",
                      "easns_stdd","twi_stddev","BLDFIE_ave","BLDFIE_std","CLYPPT_ave",
                      "SLTPPT_ave","SLTPPT_std","SNDPPT_ave","D_sqrt_A","lito2_perc",
                      "lito6_perc","lito8_perc","lito11_perc","lito12_perc")]

y1 = benchmark_data$presence1
y2 = benchmark_data$presence2

#explore Counts Presence 1 and 2
View(benchmark_data$presence1)
sum(benchmark_data$presence1)

View(benchmark_data$presence2)
sum(benchmark_data$presence2)

###########################
####### Presence1 ########
#########################

y.count = y1
y.count[y.count > 0] = 1
# sum(y.count)

dataset4analyses = cbind(intercept = 1, Ntrials= 1, y = y.count, SU_ID2 = seq(1,7360, by=1), ID= benchmark_data$id, covars) #you created an new ID clean
# dataset4analyses$MD.Level = inla.group(benchmark_data$Max_Distan, n = 20)
# dataset4analyses$DA.Level = inla.group(benchmark_data$D_sqrt_A, n = 20)
# dataset4analyses$Slope_M.Level = inla.group(benchmark_data$slope_aver, n = 20)
# hyper.iid = list(theta1 = list(prior="pc.prec", param=c(0.1, 0.5)))

Formula.bench_data_P1 = y ~ -1 + intercept+
  slope_aver+tcurv_aver+nthns_aver+nthns_stdd+easns_aver+
  easns_stdd+twi_stddev+BLDFIE_ave+BLDFIE_std+CLYPPT_ave+
  SLTPPT_ave+SLTPPT_std+SNDPPT_ave+D_sqrt_A+lito2_perc+
  lito6_perc+lito8_perc+lito11_perc+lito12_perc
# f(MD.Level, model = "rw1", constr = TRUE, hyper = list(theta = list(initial = log(5^2), fixed = F)),diagonal = 1E-4)+
# f(DA.Level, model = "rw1", constr = TRUE, hyper = list(theta = list(initial = log(5^2), fixed = F)),diagonal = 1E-4)+
# f(Slope_M.Level, model = "rw1", constr = TRUE, hyper = list(theta = list(initial = log(5^2), fixed = F)),diagonal = 1E-4)
# f(Litho, model="iid",hyper=hyper.iid, constr=T)

#load(file="cvspatial.Rdata")

bench_data_P1.cv=c()
bench_data_P1.cvLin=c()

for(i in 1:10){
  idx.holdout=which(dataset4analyses$SU_ID2 %in% idxlist[[i]])
  tmp.dataset4analyses=dataset4analyses
  tmp.dataset4analyses$y[idx.holdout]=NA
  
  CV.bench_data_P1 = inla(formula = Formula.bench_data_P1, family = "binomial", 
                  data = tmp.dataset4analyses, #should be tmp.dataset4analyses.
                  control.fixed = list(prec=1),
                  num.threads = 2, Ntrials = Ntrials,
                  control.family = list(control.link = list(model = "logit")), 
                  control.mode = list(restart = T),
                  control.inla = list(int.strategy = "eb"), 
                  control.predictor = list(compute = T, link = 1), verbose = T)
  bench_data_P1.cvLin[idx.holdout]=CV.bench_data_P1$summary.linear.predictor$mean[idx.holdout] # in this way I m saving the linear predictor
  bench_data_P1.cv[idx.holdout]=CV.bench_data_P1$summary.fitted.values$mean[idx.holdout]       # in this row  I m saving the probability, that because I'm using the Multiple intercept.
  save(bench_data_P1.cvLin,file="bench_data_P1CVlin.Rdata")                                   # but if I modify removing $mean I can store all the INLA object and plot the uncertainty too
                                                                                  # it can be very useful for the uncertainty susc map.
  save(bench_data_P1.cv,file="bench_data_P1CV.Rdata")
}
save(bench_data_P1.cvLin,file="bench_data_P1CVLinFinal.Rdata")
save(bench_data_P1.cv,file="bench_data_P1CVfinal.Rdata")
print("Done!")

# load(file="bench_data_P1CVfinal.Rdata")

# plot probability density CV
plot(density(bench_data_P1.cv))

#####################################
### CHECK PERFORMANCE EVALUATION ### 
###################################

library(pROC)
idx.CV1= idxlist[[1]]
ROC.CV1= roc(dataset4analyses$y[idx.CV1]~bench_data_P1.cv[idx.CV1])

idx.CV2= idxlist[[2]]
ROC.CV2= roc(dataset4analyses$y[idx.CV2]~bench_data_P1.cv[idx.CV2])

plot(1-ROC.CV1$specificities,ROC.CV1$sensitivities, type="l")
lines(1-ROC.CV2$specificities,ROC.CV2$sensitivities, type="l")

AUC.all=c(ROC.CV1$auc,ROC.CV2$auc)
boxplot(AUC.all)

# Explore results
bench_data_P1.cv = as.data.frame(bench_data_P1.cv)
View(bench_data_P1.cv)
summary(bench_data_P1.cv)

##########################
### CV PERFORMANCE P1 ###
########################

load(file="bench_data_P1CVfinal.Rdata")
View(bench_data_P1.cv)
library(pROC)

bench_data_P1.cv = as.data.frame(bench_data_P1.cv)
CompareRes = as.data.frame(cbind(y1,bench_data_P1.cv))
CompareRes$y1[CompareRes$y1 > 0] = 1

#load(file="cvspatial.Rdata")

bench_data_P1.CV1 = CompareRes[idxlist$`1`,]
bench_data_P1.ROC.CV1 = roc(bench_data_P1.CV1$y1, bench_data_P1.CV1$bench_data_P1.cv)
save(bench_data_P1.ROC.CV1,file = "bench_data_P1ROC_CV1.Rdata")

bench_data_P1.CV2 = CompareRes[idxlist$`2`,]
bench_data_P1.ROC.CV2 = roc(bench_data_P1.CV2$y1,bench_data_P1.CV2$bench_data_P1.cv)
save(bench_data_P1.ROC.CV2,file = "bench_data_P1ROC_CV2.Rdata")

bench_data_P1.CV3 = CompareRes[idxlist$`3`,]
bench_data_P1.ROC.CV3 = roc(bench_data_P1.CV3$y1,bench_data_P1.CV3$bench_data_P1.cv)
save(bench_data_P1.ROC.CV3,file = "bench_data_P1ROC_CV3.Rdata")

bench_data_P1.CV4 = CompareRes[idxlist$`4`,]
bench_data_P1.ROC.CV4 = roc(bench_data_P1.CV4$y1,bench_data_P1.CV4$bench_data_P1.cv)
save(bench_data_P1.ROC.CV4,file = "bench_data_P1ROC_CV4.Rdata")

bench_data_P1.CV5 = CompareRes[idxlist$`5`,]
bench_data_P1.ROC.CV5 = roc(bench_data_P1.CV5$y1,bench_data_P1.CV5$bench_data_P1.cv)
save(bench_data_P1.ROC.CV5,file = "bench_data_P1ROC_CV5.Rdata")

bench_data_P1.CV6 = CompareRes[idxlist$`6`,]
bench_data_P1.ROC.CV6 = roc(bench_data_P1.CV6$y1,bench_data_P1.CV6$bench_data_P1.cv)
save(bench_data_P1.ROC.CV6,file = "bench_data_P1ROC_CV6.Rdata")

bench_data_P1.CV7 = CompareRes[idxlist$`7`,]
bench_data_P1.ROC.CV7 = roc(bench_data_P1.CV7$y1,bench_data_P1.CV7$bench_data_P1.cv)
save(bench_data_P1.ROC.CV7,file = "bench_data_P1ROC_CV7.Rdata")

bench_data_P1.CV8 = CompareRes[idxlist$`8`,]
bench_data_P1.ROC.CV8 = roc(bench_data_P1.CV8$y1,bench_data_P1.CV8$bench_data_P1.cv)
save(bench_data_P1.ROC.CV8,file = "bench_data_P1ROC_CV8.Rdata")

bench_data_P1.CV9 = CompareRes[idxlist$`9`,]
bench_data_P1.ROC.CV9 = roc(bench_data_P1.CV9$y1,bench_data_P1.CV9$bench_data_P1.cv)
save(bench_data_P1.ROC.CV9,file = "bench_data_P1ROC_CV9.Rdata")

bench_data_P1.CV10 = CompareRes[idxlist$`10`,]
bench_data_P1.ROC.CV10 = roc(bench_data_P1.CV10$y1,bench_data_P1.CV10$bench_data_P1.cv)
save(bench_data_P1.ROC.CV10,file = "bench_data_P1ROC_CV10.Rdata")

AUC.bench_data_P1 = c(bench_data_P1.ROC.CV1$auc, bench_data_P1.ROC.CV2$auc, bench_data_P1.ROC.CV3$auc, bench_data_P1.ROC.CV4$auc, bench_data_P1.ROC.CV5$auc,
                bench_data_P1.ROC.CV6$auc, bench_data_P1.ROC.CV7$auc, bench_data_P1.ROC.CV8$auc, bench_data_P1.ROC.CV9$auc, bench_data_P1.ROC.CV10$auc)
mean.AUC = mean(AUC.bench_data_P1)
sd.AUC = sd(AUC.bench_data_P1)

load("bench_data_P1ROC_CV1.Rdata")
load("bench_data_P1ROC_CV2.Rdata")
load("bench_data_P1ROC_CV3.Rdata")
load("bench_data_P1ROC_CV4.Rdata")
load("bench_data_P1ROC_CV5.Rdata")
load("bench_data_P1ROC_CV6.Rdata")
load("bench_data_P1ROC_CV7.Rdata")
load("bench_data_P1ROC_CV8.Rdata")
load("bench_data_P1ROC_CV9.Rdata")
load("bench_data_P1ROC_CV10.Rdata")

##########################
### Table for Mapping ### 
########################

SU2map= data.frame(cbind(SuscCVP1 = bench_data_P1.cv, LocalID = benchmark_data$id, SU_ID2= dataset4analyses$SU_ID2))

write.table(SU2map, file = "P1SU2map.txt", sep = "\t", 
            row.names = F, col.names = T)


##################
### Presence2 ###
################

y.count = y2
y.count[y.count > 0] = 1

dataset4analyses = cbind(intercept = 1, Ntrials= 1, y = y.count,SU_ID2 = seq(1,7360, by=1), ID= benchmark_data$id, covars)
# dataset4analyses$MD.Level = inla.group(benchmark_data$Max_Distan, n = 20)
# dataset4analyses$DA.Level = inla.group(benchmark_data$D_sqrt_A, n = 20)
# dataset4analyses$Slope_M.Level = inla.group(benchmark_data$slope_aver, n = 20)
# hyper.iid = list(theta1 = list(prior="pc.prec", param=c(0.1, 0.5)))

Formula.bench_data_P2 = y ~ -1 + intercept+
  slope_aver+tcurv_aver+nthns_aver+nthns_stdd+easns_aver+
  easns_stdd+twi_stddev+BLDFIE_ave+BLDFIE_std+CLYPPT_ave+
  SLTPPT_ave+SLTPPT_std+SNDPPT_ave+D_sqrt_A+lito2_perc+
  lito6_perc+lito8_perc+lito11_perc+lito12_perc
#   f(MD.Level, model = "rw1", constr = TRUE, hyper = list(theta = list(initial = log(5^2), fixed = F)),diagonal = 1E-4)+
#   f(DA.Level, model = "rw1", constr = TRUE, hyper = list(theta = list(initial = log(5^2), fixed = F)),diagonal = 1E-4)+
#   f(Slope_M.Level, model = "rw1", constr = TRUE, hyper = list(theta = list(initial = log(5^2), fixed = F)),diagonal = 1E-4)
#   f(Litho, model="iid",hyper=hyper.iid, constr=T) 

#load(file="cvspatial.Rdata")

bench_data_P2.cv=c()
bench_data_P2.cvLin=c()

for(i in 1:10){
  idx.holdout=which(dataset4analyses$SU_ID2 %in% idxlist[[i]])
  tmp.dataset4analyses=dataset4analyses
  tmp.dataset4analyses$y[idx.holdout]=NA
  
  CV.bench_data_P2 = inla(formula = Formula.bench_data_P2, family = "binomial", 
                    data = tmp.dataset4analyses, #This needs to be temp.dataset4analyses or the results are going to be the same of FIT 
                    control.fixed = list(prec=1),
                    num.threads = 2, Ntrials = Ntrials,
                    control.family = list(control.link = list(model = "logit")), 
                    control.mode = list(restart = T),
                    control.inla = list(int.strategy = "eb"), 
                    control.predictor = list(compute = T, link = 1), verbose = T)
  # bench_data_P2.cvLin[idx.holdout]=CV.bench_data_P2$summary.linear.predictor$mean[idx.holdout] # in this way I m saving the linear predictor
  bench_data_P2.cv[idx.holdout]=CV.bench_data_P2$summary.fitted.values$mean[idx.holdout]       # in this row  I m saving the probability, that beacuse I'm using the Multiple intercept.
  # save(bench_data_P2.cvLin,file="bench_data_P2CVlin.Rdata")
  save(bench_data_P2.cv,file="bench_data_P2CV.Rdata")
}
# save(bench_data_P2.cvLin,file="bench_data_P2CVLinFinal.Rdata")
save(bench_data_P2.cv,file="bench_data_P2CVfinal.Rdata")
print("Done!")

# load(file="bench_data_P2CVfinal.Rdata")

# plot probability density CV
plot(density(bench_data_P2.cv))

#####################################
### CHECK PERFORMANCE EVALUATION ### 
###################################

library(pROC)
idx.CV1= idxlist[[1]]
ROC.CV1= roc(dataset4analyses$y[idx.CV1]~bench_data_P2.cv[idx.CV1])

idx.CV2= idxlist[[2]]
ROC.CV2= roc(dataset4analyses$y[idx.CV2]~bench_data_P2.cv[idx.CV2])

plot(1-ROC.CV1$specificities,ROC.CV1$sensitivities, type="l")
lines(1-ROC.CV2$specificities,ROC.CV2$sensitivities, type="l")

AUC.all=c(ROC.CV1$auc,ROC.CV2$auc)
boxplot(AUC.all)

# Explore results
bench_data_P2.cv = as.data.frame(bench_data_P2.cv)
View(bench_data_P2.cv)
summary(bench_data_P2.cv)

##########################
### CV PERFORMANCE P2 ###
########################

load(file="bench_data_P2CVfinal.Rdata")
View(bench_data_P2.cv)
library(pROC)

bench_data_P2.cv = as.data.frame(bench_data_P2.cv)
CompareRes = as.data.frame(cbind(y2,bench_data_P2.cv))
CompareRes$y2[CompareRes$y2 > 0] = 1

#load(file="cvspatial.Rdata")

bench_data_P2.CV1 = CompareRes[idxlist$`1`,]
bench_data_P2.ROC.CV1 = roc(bench_data_P2.CV1$y2, bench_data_P2.CV1$bench_data_P2.cv)
save(bench_data_P2.ROC.CV1,file = "bench_data_P2ROC_CV1.Rdata")

bench_data_P2.CV2 = CompareRes[idxlist$`2`,]
bench_data_P2.ROC.CV2 = roc(bench_data_P2.CV2$y2,bench_data_P2.CV2$bench_data_P2.cv)
save(bench_data_P2.ROC.CV2,file = "bench_data_P2ROC_CV2.Rdata")

bench_data_P2.CV3 = CompareRes[idxlist$`3`,]
bench_data_P2.ROC.CV3 = roc(bench_data_P2.CV3$y2,bench_data_P2.CV3$bench_data_P2.cv)
save(bench_data_P2.ROC.CV3,file = "bench_data_P2ROC_CV3.Rdata")

bench_data_P2.CV4 = CompareRes[idxlist$`4`,]
bench_data_P2.ROC.CV4 = roc(bench_data_P2.CV4$y2,bench_data_P2.CV4$bench_data_P2.cv)
save(bench_data_P2.ROC.CV4,file = "bench_data_P2ROC_CV4.Rdata")

bench_data_P2.CV5 = CompareRes[idxlist$`5`,]
bench_data_P2.ROC.CV5 = roc(bench_data_P2.CV5$y2,bench_data_P2.CV5$bench_data_P2.cv)
save(bench_data_P2.ROC.CV5,file = "bench_data_P2ROC_CV5.Rdata")

bench_data_P2.CV6 = CompareRes[idxlist$`6`,]
bench_data_P2.ROC.CV6 = roc(bench_data_P2.CV6$y2,bench_data_P2.CV6$bench_data_P2.cv)
save(bench_data_P2.ROC.CV6,file = "bench_data_P2ROC_CV6.Rdata")

bench_data_P2.CV7 = CompareRes[idxlist$`7`,]
bench_data_P2.ROC.CV7 = roc(bench_data_P2.CV7$y2,bench_data_P2.CV7$bench_data_P2.cv)
save(bench_data_P2.ROC.CV7,file = "bench_data_P2ROC_CV7.Rdata")

bench_data_P2.CV8 = CompareRes[idxlist$`8`,]
bench_data_P2.ROC.CV8 = roc(bench_data_P2.CV8$y2,bench_data_P2.CV8$bench_data_P2.cv)
save(bench_data_P2.ROC.CV8,file = "bench_data_P2ROC_CV8.Rdata")

bench_data_P2.CV9 = CompareRes[idxlist$`9`,]
bench_data_P2.ROC.CV9 = roc(bench_data_P2.CV9$y2,bench_data_P2.CV9$bench_data_P2.cv)
save(bench_data_P2.ROC.CV9,file = "bench_data_P2ROC_CV9.Rdata")

bench_data_P2.CV10 = CompareRes[idxlist$`10`,]
bench_data_P2.ROC.CV10 = roc(bench_data_P2.CV10$y2,bench_data_P2.CV10$bench_data_P2.cv)
save(bench_data_P2.ROC.CV10,file = "bench_data_P2ROC_CV10.Rdata")

AUC.bench_data_P2 = c(bench_data_P2.ROC.CV1$auc, bench_data_P2.ROC.CV2$auc, bench_data_P2.ROC.CV3$auc, bench_data_P2.ROC.CV4$auc, bench_data_P2.ROC.CV5$auc,
             bench_data_P2.ROC.CV6$auc, bench_data_P2.ROC.CV7$auc, bench_data_P2.ROC.CV8$auc, bench_data_P2.ROC.CV9$auc, bench_data_P2.ROC.CV10$auc)
mean.AUC = mean(AUC.bench_data_P2)
sd.AUC = sd(AUC.bench_data_P2)

load("bench_data_P2ROC_CV1.Rdata")
load("bench_data_P2ROC_CV2.Rdata")
load("bench_data_P2ROC_CV3.Rdata")
load("bench_data_P2ROC_CV4.Rdata")
load("bench_data_P2ROC_CV5.Rdata")
load("bench_data_P2ROC_CV6.Rdata")
load("bench_data_P2ROC_CV7.Rdata")
load("bench_data_P2ROC_CV8.Rdata")
load("bench_data_P2ROC_CV9.Rdata")
load("bench_data_P2ROC_CV10.Rdata")

##########################
### Table for Mapping ### 
########################

P2SU2map= data.frame(cbind(SuscCVP2 = bench_data_P2.cv, LocalID = benchmark_data$id, SU_ID2= dataset4analyses$SU_ID2))

write.table(P2SU2map, file = "P2SU2map.txt", sep = "\t", 
            row.names = F, col.names = T)

############################################
######PLOT PERFORMANCE TOGETHER############
##########################################

################
### DENSITY ###
##############

suscP1CV=bench_data_P1.cv
suscP2CV=bench_data_P2.cv

class(suscP1CV)# Checking class of data
# [1] "data.frame" thus, you have to convert in numeric

# View(suscP1CV)
a=as.numeric(as.character(suscP1CV$bench_data_P1.cv))
View(a)

b=as.numeric(as.character(suscP2CV$bench_data_P2.cv))
View(b)

dens1=density(a)
dens2=density(b)

pdf("DensityCV.pdf", width = 8, height = 8)
plot(dens1$x, dens1$y/max(dens1$y),type = "l", col= "violetred1", lwd= 3, xlim = c(-0.05,1.05),
     xlab = "Susceptibility", ylab = "PDF")
lines(dens2$x, dens2$y/max(dens2$y),col="purple3", lwd= 3)
dev.off()

####################
### PLOT AUC CV ###
##################

pdf("benchmark_dataCV_AUC.pdf", width = 12, height = 7)

par(mfrow = c(1,2))

plot(1-bench_data_P1.ROC.CV1$specificities,bench_data_P1.ROC.CV1$sensitivities, type = "l", xlab = "1 - Specificities", 
     ylab = "Sensitivities", xlim = c(0,1), ylim = c(0,1), main = "P1",
     lwd = 1.5, col = "violetred1", cex.axis = 1.5, cex.lab = 1.2, cex = 1.5)
lines(1-bench_data_P1.ROC.CV2$specificities,bench_data_P1.ROC.CV2$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(1-bench_data_P1.ROC.CV3$specificities,bench_data_P1.ROC.CV3$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(1-bench_data_P1.ROC.CV4$specificities,bench_data_P1.ROC.CV4$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(1-bench_data_P1.ROC.CV5$specificities,bench_data_P1.ROC.CV5$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(1-bench_data_P1.ROC.CV6$specificities,bench_data_P1.ROC.CV6$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(1-bench_data_P1.ROC.CV7$specificities,bench_data_P1.ROC.CV7$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(1-bench_data_P1.ROC.CV8$specificities,bench_data_P1.ROC.CV8$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(1-bench_data_P1.ROC.CV9$specificities,bench_data_P1.ROC.CV9$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(1-bench_data_P1.ROC.CV10$specificities,bench_data_P1.ROC.CV10$sensitivities, type = "l",lwd = 1.5, col = "violetred1")
lines(x = c(-1,2), y = c(-1,2), col = "black", lwd = 1.5)
text(0.7,0.2, "Mean = 0.727", cex = 1.2)
text(0.7,0.1, "Std.Dev = 0.017", cex = 1.2)

plot(1-bench_data_P2.ROC.CV1$specificities,bench_data_P2.ROC.CV1$sensitivities, type = "l", xlab = "1 - Specificities", 
     ylab = "Sensitivities", xlim = c(0,1), ylim = c(0,1), main = "P2",
     lwd = 1.5, col = "purple3", cex.axis = 1.5, cex.lab = 1.2, cex = 1.5)
lines(1-bench_data_P2.ROC.CV2$specificities,bench_data_P2.ROC.CV2$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(1-bench_data_P2.ROC.CV3$specificities,bench_data_P2.ROC.CV3$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(1-bench_data_P2.ROC.CV4$specificities,bench_data_P2.ROC.CV4$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(1-bench_data_P2.ROC.CV5$specificities,bench_data_P2.ROC.CV5$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(1-bench_data_P2.ROC.CV6$specificities,bench_data_P2.ROC.CV6$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(1-bench_data_P2.ROC.CV7$specificities,bench_data_P2.ROC.CV7$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(1-bench_data_P2.ROC.CV8$specificities,bench_data_P2.ROC.CV8$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(1-bench_data_P2.ROC.CV9$specificities,bench_data_P2.ROC.CV9$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(1-bench_data_P2.ROC.CV10$specificities,bench_data_P2.ROC.CV10$sensitivities, type = "l",lwd = 1.5, col = "purple3")
lines(x = c(-1,2), y = c(-1,2), col = "black", lwd = 1.5)
text(0.7,0.2, "Mean = 0.745", cex = 1.2)
text(0.7,0.1, "Std.Dev = 0.019", cex = 1.2)

dev.off()
