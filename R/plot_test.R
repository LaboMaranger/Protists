
all_data=read.csv("data/AllDataPhysicoChimicoBiolo.csv",header=T,check.names=F)
samdf_all=merge(samdf,all_data,by=c("Id","Depth"),all.y = F,all.x=T)

groupVar=list(samdf_all$Year.x,samdf_all$Station.x)
samdf_agg_all=aggregate(samdf_all[,-c(1,2,5)], by=groupVar,FUN=mean,na.rm=T) 

samdf_agg_all$stationGr=samdf_agg$stationGr

samdf_agg_all$TDN_DIN=(samdf_agg_all$TDN_uMN-(samdf_agg_all$NO2_uM+samdf_agg_all$NO3_uM+samdf_agg_all$NH4_uM))/samdf_agg_all$TDN_uMN


col=1
col[samdf_agg_all$Year.x==2015]=2
col[samdf_agg_all$Year.x==2016]=3

plot(samdf_agg_all$DSP.4,samdf_agg_all$TDN_DIN,pch=16,ylab="(TDN-DIN)/TDN",xlab="Days before peak")


plot(samdf_agg_all$DSP.4,samdf_agg_all$NO3_uM,pch=16,ylab="NO3",xlab="Days before peak")
plot(samdf_agg_all$DSP.4,samdf_agg_all$PO4_uM,pch=16,ylab="PO4",xlab="Days before peak")
plot(samdf_agg_all$DSP.4,samdf_agg_all$SiO2_uM,pch=16,ylab="SiO2",xlab="Days before peak")
plot(samdf_agg_all$DSP.4,samdf_agg_all$NH4_uM/samdf_agg_all$NO3_uM,pch=16,ylab="NH4:NO3",xlab="Days before peak")

plot(samdf_agg_all$DSP.4,samdf_agg_all$PP_uMO2_perD,pch=16,ylab="PP",xlab="Days before peak",col=col)

cor.test(samdf_agg_all$DSP.4,samdf_agg_all$PP_uMO2_perD)

lm=lm(NO3_uM~DSP.4+Year.x*stationGr,data=samdf_agg_all)
summary(lm)
