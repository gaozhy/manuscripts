library(R.matlab)
library(lme4)
sem_tmp<-readMat('C:/Users/zhiya/Documents/R/mixed_data/pcorr_sy_spec_lat_n_z2_mixed_data.mat')

sem_tmp$allrsa<-na.omit(sem_tmp$allrsa)
subject=sem_tmp$allrsa[,7]
w2b=sem_tmp$allrsa[,6]
ps=sem_tmp$allrsa[,1]
act=sem_tmp$allrsa[,2]
std=sem_tmp$allrsa[,3]
Responses=sem_tmp$allrsa[,5]
RT=sem_tmp$allrsa[,4]
ps=(ps-mean(ps))/sd(ps)
act=(act-mean(act))/sd(act)
RT=(RT-mean(RT))/sd(RT)
w2b=(w2b-mean(w2b))/sd(w2b)



dms.df=data.frame(subject,ps,act,std,Responses,RT,w2b)
ys.df=dms.df[which(dms.df$Responses==1),]
ns.df=dms.df[which(dms.df$Responses==2),]

sem_linear_model=lmer(RT~ps+w2b+act+std+(1|subject),data=dms.df,REML = FALSE)
sem_linear_null=lmer(RT~act+w2b+std+(1|subject),data=dms.df,REML = FALSE)
anova(sem_linear_model,sem_linear_null)

ysem_linear_model=lmer(RT~ps+w2b+act+(1|subject),data=ys.df,REML = FALSE)
ysem_linear_null=lmer(RT~w2b+act+(1|subject),data=ys.df,REML = FALSE)
anova(ysem_linear_model,ysem_linear_null)
nsem_linear_model=lmer(RT~ps+w2b+act+(1|subject),data=ns.df,REML = FALSE)
nsem_linear_null=lmer(RT~act+w2b+(1|subject),data = ns.df,REML = FALSE)
anova(nsem_linear_model,nsem_linear_null)

ysem_linear_model1=lmer(RT~ps+w2b+ps*Responses+act+(1|subject),data=dms.df,REML = FALSE)
ysem_linear_null1=lmer(RT~act+ps+Responses+w2b+(1|subject),data=dms.df,REML = FALSE)
anova(ysem_linear_model1,ysem_linear_null1)
nsem_linear_model1=lmer(RT~ps+w2b+act+(1|subject),data=ns.df,REML = FALSE)
nsem_linear_null1=lmer(RT~act+w2b+(1|subject),data = ns.df,REML = FALSE)
anova(nsem_linear_model1,nsem_linear_null1)

