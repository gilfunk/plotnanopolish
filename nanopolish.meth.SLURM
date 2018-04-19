#!/bin/bash -l

################################
# 
#   this script assumes subdir /np exists (np = nanopolish)
#     it also wants the sequencing summary file. thats not in the subdir tho. root that b.  
#    check the name of the fast5folder , i change that sometimes 
################################

#SBATCH --time=2:0:0

#SBATCH --partition=shared
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2

echo 'start time'
echo `date +%d/%m/%Y\ %H:%M:%S`

refd=~/data/Reference
myd=~/data/gilfunk/180405_bcpap_rep2
exp=180405_bcpap2


#NOTE: there can only be one fastq in the specififed 'np' folder below!!
ml samtools 
#echo 'starting alignment'
#~/dl/minimap2/minimap2 -a -x map-ont $refd/chr5.fa $myd/np/*.fastq | \
#  samtools sort -T ${exp}_tmp -o $myd/np/${exp}.bam

#samtools index $myd/np/${exp}.bam


#echo 'time after making/sorting bam:'
echo `date +%d/%m/%Y\ %H:%M:%S`
echo 'building index'

##### HERE IS THE FAST5 FOLDER NAME
~/dl/nanopolish/nanopolish index -d $myd/180405_bcpap2_fast5 -s $myd/*_summary.txt $myd/np/*.fastq

echo 'time after ind3xing:'
echo `date +%d/%m/%Y\ %H:%M:%S`


echo 'calling methylation'
#methcalling
~/dl/nanopolish/nanopolish call-methylation -t 8 -r $myd/np/*.fastq  -b $myd/np/${exp}.bam \
   -g $refd/chr5.fa -w "chr5:1295000-1295800" > ${myd}/np/mcalls_${exp}.tsv

#meth_freq extraction
~/dl/nanopolish/scripts/calculate_methylation_frequency.py -i ${myd}/np/mcalls_${exp}.tsv > ${myd}/np/mfreq_${exp}.tsv

echo 'time after extracting all the info:'
echo `date +%d/%m/%Y\ %H:%M:%S` 
