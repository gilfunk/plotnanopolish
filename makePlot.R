capture.output( suppressMessages(library(tidyverse)))
capture.output( suppressMessages(library(cowplot)))


###############
#    this reads in the kmerFreq and cpgFreq files made by the provided python script.
#        at present,  it assumes those are the only such files  in the pwd
#        the x-scale, and tss are currently hardcoded  in
################

kmer_file=list.files(  pattern= 'kmerFreq*', full.names=T)
kmer_file
methDat=read_tsv(kmer_file, col_names=c('xa','xb','ya', 'yb','avg_cov'))
methDat 

exp='bcpap2'
 
dim(methDat)
head(methDat)

covTenMethDat <- methDat
dim(covTenMethDat)

dat_list=list()
rowzz = dim(covTenMethDat)[1]

#first making the bars 
for (i in c(1:rowzz))
{ 
  xx1=as.numeric(c(covTenMethDat[i,1],covTenMethDat[i,2]))
  yy1=as.numeric(c(covTenMethDat[i,3],covTenMethDat[i,3]))

  df <- data_frame(hg19_cood= xx1, meth = yy1 )   
 #print(df)
    dat_list[[i]] <- df 
}


#reading in CpG-specific methylation data 
cpg_file=list.files(pattern= 'cpgFreq*', full.names=T)
cpg_file
meth_sites=read_tsv(cpg_file, col_names=c('hg19_cood', 'meth'))
#meth_sites


tss_points=c(1295162)
tss_h=c(1.0)
tert_tss <- data_frame(hg19_cood= tss_points, meth = tss_h )

#by defining the x-axis, we ensure our plots line up:
xaxis_lim = c(1295000, 1295800)

#you need to do this to keep the legend in current order
#and not get switchd to alphabetical 
#plotter <- transform(plotter, samp_ID=factor(samp_ID, levels=unique(samp_ID)))

#making and printing the plots : 
my_plot=ggplot(data=tert_tss, aes(x=hg19_cood, y=meth))+
    geom_point(size=0.5, color="green")+
    xlim(xaxis_lim)+ylim(c(0,1))

 #+geom_line(data=line_df, size=1, color="black")
#geom_text(data=amplicon_labels, label=label_ID, color="black")+
#for (i in c(1:rowzz))
#     { 
#    k = data.frame(dat_list[i])
#      my_plot  <- my_plot + geom_line(data=k, size=4, color="blue")
# }

my_plot <- my_plot + geom_segment(aes(x = xa, y = ya, xend = xb, yend = yb, color=avg_cov), data = methDat, size=4 ) 
my_plot<- my_plot + geom_line(data=meth_sites, size=0.5, color="black")+
          geom_point(data=meth_sites, size=0.666, color="indianred1") 
#my_plot<- my_plot+ geom_point(data=line_df, x=hg19_cood, y=meth, size=1, color="black")

pdf( paste0(exp, 'meth_data.pdf') )    
print(plot_grid(my_plot, my_plot, nrow=2, align="v"))
dev.off()
