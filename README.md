# plotnanopolish
scripts for plotting nanopolish methylation data 


nanopolish must be run and the methylation frequency extracted .
 details on doing that can be found here:
 http://nanopolish.readthedocs.io/en/latest/quickstart_call_methylation.html
(template script for running nanopolish methylation/freq extraction using the SLURM scheduler is provided also) 
 
next use the python script to extract data the Nanopolish methylation Frequency output
This results in a 'kmerFreq' and a 'cpgFreq' file, which  can be plotted with the provided Rscript

