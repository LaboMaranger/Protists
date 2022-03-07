bact=read.csv("data/Bact.csv",sep = ";")


bact$Bacteria_permL=as.numeric(gsub(",", ".", gsub("\\.", "", bact$Bacteria_permL)))

all_data=read.csv("data/AllDataPhysicoChimicoBiolo.csv")

#all_data=merge(all_data,bact,by="Id")

bact=bact[,c("Id","Bacteria_permL")]

all_data$Bacteria_permL[match(bact$Id,all_data$Id)]=bact$Bacteria_permL

groupVar=list(all_data$Year,all_data$Station)
all_data_agg=aggregate(all_data, by=groupVar,FUN=mean,na.rm = T) 

rownames(all_data_agg)= apply( all_data_agg[,(1:length(groupVar))] , 1 , paste , collapse = "-" )

/all_data_agg_sel=all_data_agg[rownames(com),]
all_data_agg_sel=all_data_agg[,]


all_data_agg_sel=data.frame(DSP.4=samdf_agg[rownames(all_data_agg_sel),"DSP.4"],all_data_agg_sel)

all_data_agg_sel=all_data_agg_sel[order(all_data_agg_sel$DSP.4),]
all_data_agg_sel=all_data_agg_sel[!is.na(all_data_agg_sel$DSP.4),]

plot(all_data_agg_sel$DSP.4,all_data_agg_sel$NO3_uM,pch=16,ylab="NO3",xlab="DBP")
lines(lowess(all_data_agg_sel$NO3_uM~all_data_agg_sel$DSP.4, f =0.6),lwd=3)

plot(all_data_agg_sel$DSP.4,all_data_agg_sel$PO4_uM,pch=16,ylab="PO4",xlab="DBP")
lines(lowess(all_data_agg_sel$PO4_uM~all_data_agg_sel$DSP.4, f =0.6),lwd=3)

plot(all_data_agg_sel$DSP.4,all_data_agg_sel$BP1.55_uMC_perD,pch=16,ylab="BP1.55_uMC_perD",xlab="DBP")
lines(lowess(all_data_agg_sel$BP1.55_uMC_perD~all_data_agg_sel$DSP.4, f =0.6),lwd=3)


plot(all_data_agg_sel$DSP.4,all_data_agg_sel$,pch=16,ylab="PO4",xlab="DBP")
lines(lowess(all_data_agg_sel$BP_ugC_perL_perD~all_data_agg_sel$DSP.4, f =0.6),lwd=3)


lines(lowess(all_data_agg_sel$DSP.4~all_data_agg_sel$NO3_uM, f =0.6),lwd=4)
plot(lowess(all_data_agg_sel$DSP.4~all_data_agg_sel$NO3_uM, f =0.6),lwd=4)

plot(all_data_agg_sel$DSP.4,all_data_agg_sel$BP1.55_uMC_perD,pch=16,ylab="BP",xlab="DBP")
  plot(all_data_agg_sel$DSP.4,all_data_agg_sel$Bacteria_permL,pch=16,ylab="Bacteria_perml",xlab="DBP")


  all_data$Bacteria_permL
  
  