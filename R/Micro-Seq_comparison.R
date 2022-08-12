setwd("D:/Collaborations/Protistes/R")
Micro <- read.csv("./Microscopie_count_Hud2014_2015.csv")
Seq <- read.csv("./cw_sequencage.csv")

#Keep only unique validName

Micro.unique <- unique(Micro$validName)
Micro.unique <- Micro.unique[-14] #Remove blank
Seq.unique <- unique(Seq$validName)
Seq.unique <- Seq.unique[-3] #remove NA

summary(Micro.unique %in% Seq.unique)
# 28/(34+28) #Total
# 28/(32+28) #w/o both Incertae_Sedis
# 28/(31+28) #w/o Haploid phaeocystis
# 28/(30+28) #w/o Meringosphaera that could not be in SILVA
# 30/(30+30) #w/ counting genera that have other names



summary(Seq.unique %in% Micro.unique)

summary(Micro$validName %in% Seq$validName)
summary(Seq$validName %in% Micro$validName)

#Find which are different
Delta <- Micro.unique[!(Micro.unique %in% Seq.unique)]
#Read trait table
Traits <- read.csv("./TraitsTable.csv")

Traits.difference <- Traits[Traits$validName %in% Delta,]
Traits.difference <- Traits.difference[order(Traits.difference$validName,decreasing = F),]


Micro_abundance.unique = Micro[Micro$validName %in% Traits.difference$validName,]
Micro_abundance.unique.pa = Micro_abundance.unique #Presence/absence
Micro_abundance.unique.pa[Micro_abundance.unique.pa>0] =1 #Warning is for first column, not a problem for the others
index = which(rowSums(Micro_abundance.unique.pa[,-1])==1) #Species found only at 1 station

#Calculate how much the overlap represents in term of abundance
Overlap.Abund <- colSums(Micro_abundance.unique[,-1])/colSums(Micro[,-1])*100
Overlap.Abund.mean <- mean(Overlap.Abund) #4%
Overlap.Abund.sd <- sd(Overlap.Abund) #2.6%


#Test by correcting different names
Traits.cor <- Traits
unique(Traits.cor$validName)
Traits.cor[Traits.cor$validName=="Phaeocystis_haploid", "validName"] = "Phaeocystis_diploid"
Traits.cor[Traits.cor$validName=="Plagioselmis", "validName"] = "Teleaulax"
Traits.cor[Traits.cor$validName=="Corymbellus", "validName"] = "Chrysochromulina"

Traits.difference.cor <- Traits.cor[Traits.cor$validName %in% Delta,]
Traits.difference.cor <- Traits.difference.cor[order(Traits.difference.cor$validName,decreasing = F),]

Micro_abundance.unique.cor = Micro[Micro$validName %in% Traits.difference.cor$validName,]

#Calculate again after correcting a few species name
Overlap.Abund.cor <- colSums(Micro_abundance.unique.cor[,-1])/colSums(Micro[,-1])*100
Overlap.Abund.cor.mean <- mean(Overlap.Abund.cor) #3.1%
Overlap.Abund.cor.sd <- sd(Overlap.Abund.cor) #1.7%



Micro.abund <- data.frame(ValidName=Micro_abundance.unique[,1], Abundance=rowSums(Micro_abundance.unique[,-1]))
Abund.unique <- Micro_abundance.unique[index,]

NrStations = data.frame(valiName = Micro_abundance.unique.pa[,1],
                        NrStation = rowSums(Micro_abundance.unique.pa[,-1]))
NrStations <- NrStations[order(NrStations$valiName,decreasing = F),]


#Export for supplementary table
write.csv(x = Traits.difference, "./Traits-part1.csv", fileEncoding = "UTF-8")
write.csv(x = NrStations, "./Traits-part2-NrStations.csv", fileEncoding = "UTF-8")
