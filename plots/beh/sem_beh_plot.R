library(R.matlab)
library(ggplot2)
library(ggpubr)

sem_tmp<-readMat('/home/zg/mix_R/beh_stats_swdata.mat')
ymsem<-sem_tmp$ysem.stats[1,]
yssem<-sem_tmp$ysem.stats[2,]
nmsem<-sem_tmp$nsem.stats[1,]
nssem<-sem_tmp$nsem.stats[2,]

ymwm<- sem_tmp$ywm.stats[1,]
yswm<- sem_tmp$ywm.stats[2,]
nmwm<- sem_tmp$nwm.stats[1,]
nswm<- sem_tmp$nwm.stats[2,]

Level<-c('L1','L2','L3','L4','L5','L1','L2','L3','L4','L5')
YN<-c('Yes','Yes','Yes','Yes','Yes','No','No','No','No','No')
wYN<-c('Correct','Correct','Correct','Correct','Correct','Wrong','Wrong','Wrong','Wrong','Wrong')
RT<- c(ymsem,nmsem)
se<-c(yssem,nssem)
sem<-data.frame(RT,se,Level,YN)
  
wRT=c(ymwm,nmwm)
wse=c(yswm,nswm)

wm<-data.frame(wRT,wse,Level,wYN)
wm$Level=factor(wm$Level)
wm$wYN=factor(wm$wYN,levels=c('Correct','Wrong'))
sem$Level<-as.factor(sem$Level)
sem$YN=factor(sem$YN,levels=c('Yes','No'))
p <- ggplot(data=sem,aes(x=Level,y=RT,fill=YN,facet('YN')))+
  geom_bar(stat='identity',position = position_dodge())+
  geom_errorbar(aes(ymin=RT-se,ymax=RT+se),
                  width=.2,
                position = position_dodge())+
  xlab('Semantic Association Level')+
  ylab('Reaction Time(s)')+
  facet_grid(.~YN)+
  theme(strip.background = element_blank(),strip.text.x = element_blank(),legend.title = element_blank(),
        axis.line = element_line(size=1.5),axis.text = element_text(size = 16),axis.title=element_text(face='bold',size=16),
        legend.text = element_text(size=14,face='bold'))+
  #theme_classic2()+
  scale_fill_manual(values = c( "#E69F00", "#999999"),labels=c('Yes','No'))
p
#p+scale_fill_brewer(palette = 'Paired')+theme_minimal()
pw <- ggplot(data=wm,aes(x=Level,y=wRT,fill=wYN,facet('wYN')))+
  geom_bar(stat='identity',position = position_dodge())+
  geom_errorbar(aes(ymin=wRT-wse,ymax=wRT+wse),
                width=.2,
                position = position_dodge())+
  xlab('Working Memory Load Level')+
  ylab('Reaction Time(s)')+
  facet_grid(.~wYN)+
  theme(strip.background = element_blank(),strip.text.x = element_blank(),legend.title = element_blank(),
        axis.line = element_line(size=1.5),axis.text = element_text(size = 16),axis.title=element_text(face='bold',size=16),
        legend.text = element_text(size=14,face='bold'))+
  #theme_classic2()+
  scale_fill_manual(values = c( "#E69F00", "#999999"),labels=c('Correct','Wrong'))
pw

  
