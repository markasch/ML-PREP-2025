#!/bin/bash
#
# This script works in a GRASS GIS mapset containing vector layers
# su_bench_pres1 and su_bench_pres1, described in the paper:
# "A benchmark dataset and workflow for landslide susceptibility zonation"
# Results for Brier score values will be in files: brier_score[1,2].txt

#
# --
#

#
# PRESENCE 1
#
tmp=`db.select sql="select * from su_bench_pres1 limit 0" separator=newline | tail -n 16`
lista=($tmp)
#
echo
for col in ${lista[@]}
do
    break
    #check for null values OK
    nulli1=`db.select -c sql="select count(*) from su_bench_pres1 where $col is null"`
    nulli2=`db.select -c sql="select count(*) from su_bench_pres1_err where $col is null"`
    echo $col $nulli1 $nulli2
done
echo
#
outfile1=brier_score1.txt
rm -f $outfile1
echo
ico=0
for col in ${lista[@]}
do
    ico=$((ico+1))
    n_tot=`db.select -c sql="select count(*) from su_bench_pres1"`
    brier=`db.select -c sql="select sum((presence1-$col)*(presence1-$col))/$n_tot from su_bench_pres1"`
    echo $ico $col $brier
    echo $ico $col $brier >> $outfile1
done
echo

#
# --
#

#
# PRESENCE 2
#
tmp=`db.select sql="select * from su_bench_pres2 limit 0" separator=newline | tail -n 16`
lista=($tmp)
#
echo
for col in ${lista[@]}
do
    break
    #check for null values OK    
    nulli1=`db.select -c sql="select count(*) from su_bench_pres2 where $col is null"`
    nulli2=`db.select -c sql="select count(*) from su_bench_pres2_err where $col is null"`
    echo $col $nulli1 $nulli2
done
echo
#
outfile2=brier_score2.txt
rm -f $outfile2
echo
ico=0
for col in ${lista[@]}
do
    ico=$((ico+1))
    n_tot=`db.select -c sql="select count(*) from su_bench_pres2"`
    brier=`db.select -c sql="select sum((presence2-$col)*(presence2-$col))/$n_tot from su_bench_pres2"`
    echo $ico $col $brier
    echo $ico $col $brier >> $outfile2
done
echo

awk '{print $4,$5,$6}' roc_values_pres1.dat > tmp1.txt
paste brier_score1.txt tmp1.txt | sed 's/\t/ /g '> brier_score1.dat

awk '{print $4,$5,$6}' roc_values_pres2.dat > tmp2.txt
paste brier_score2.txt tmp2.txt | sed 's/\t/ /g' > brier_score2.dat

rm tmp1.txt
rm tmp2.txt

