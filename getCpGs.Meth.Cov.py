#!/usr/bin/env python 

import re

###  !!!!  before you run this, remove the first line from the mfreq file     !!!!###


############
# just change the name of the meth freq summary file + exp name#
# then should be gucci to run
######
freq_file_name='mfreq_180405_bcpap2.tsv'
exp='180405_bcpap2'



f=open(freq_file_name , 'r')

out=open('cpgFreq.'+exp+'.tsv', 'w')
for line in f:
    tings=line.split('\t')
    how_many=tings[3]
#    print(tings)
    seq=tings[7]
 #   print(how_many)
 #   print(seq)
    cg_idx=([m.start() for m in re.finditer('CG', seq )])
    for i in cg_idx:
        out.write(str(i+int(tings[1]))+'\t'+tings[6]+'\n'  )

f.close
out.close

f=open(freq_file_name , 'r')
out2=open('kmerFreq.'+exp+'.tsv', 'w')
for line in f:
    tings=line.split('\t')
#    how_many=tings[3]
#    print(tings)
    start=tings[1]
    end=tings[2]
 #   print(how_many)
 #   print(seq)
    meth=tings[6]
    seq=tings[7]
    cg_idx=([m.start() for m in re.finditer('CG', seq )])
    init=int(start)-cg_idx[0]
    term=int(start)+len(seq)
 #   print(term)
    out2.write(str(init)+'\t'+str(term)+'\t'+str(meth)+'\t'+str(meth)+'\t')
    out2.write(str(float(tings[4]) /  float(tings[3]) )+'\n')

f.close
out2.close
