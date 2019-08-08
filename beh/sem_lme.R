library(R.matlab)
library(lme4)
sem_tmp<-readMat('/home/zg/mix_R/sem_lme_data.mat')
dm_stmp<-readMat('/home/zg/mix_R/demean_semdata.mat')


subject=sem_tmp$allmixed[,1]
Level=sem_tmp$allmixed[,2]
w2b=sem_tmp$allmixed[,3]
Responses=sem_tmp$allmixed[,4]
RT=sem_tmp$allmixed[,5]

dmsem=dm_stmp$semdata
dmsubject=dmsem[,1]
dmresponse=dmsem[,4]
dmw2b=dmsem[,3]
dmLevel=dmsem[,2]
dmRT=dmsem[,5]


dms.df=data.frame(dmsubject,dmLevel,dmw2b,dmresponse,dmRT)
ys.df=dms.df[which(dms.df$dmresponse==1),]
ns.df=dms.df[which(dms.df$dmresponse==2),]
sem.df=data.frame(subject,Level,w2b,Responses,RT)

ysem_model=lm(dmRT~dmLevel,ys.df)
summary(ysem_model)
nsem_model=lm(dmRT~dmLevel,ns.df)
summary(nsem_model)

ysem_linear_model=lmer(dmRT~dmw2b+(1|dmsubject),data=ys.df,REML = FALSE)
ysem_linear_null=lmer(dmRT~(1|dmsubject),data=ys.df,REML = FALSE)
anova(ysem_linear_model,ysem_linear_null)
nsem_linear_model=lmer(dmRT~dmw2b+(1|dmsubject),data=ns.df,REML = FALSE)
nsem_linear_null=lmer(dmRT~(1|dmsubject),data = ns.df,REML = FALSE)
anova(nsem_linear_model,nsem_linear_null)



raw_sy.df=sem.df[which(sem.df$Responses==1),]
raw_sn.df=sem.df[which(sem.df$Responses==2),]
raw_sy_linear_model=lmer(RT~Level+(1|subject),data=raw_sy.df,REML = FALSE)
raw_sy_linear_null=lmer(RT~(1|subject),data=raw_sy.df,REML = FALSE)
anova(raw_sy_linear_model,raw_sy_linear_null)

raw_sn_linear_model=lmer(RT~Level+(1|subject),data=raw_sn.df,REML=FALSE)
raw_sn_linear_null=lmer(RT~(1|subject),data=raw_sn.df,REML = FALSE)
anova(raw_sn_linear_model,raw_sn_linear_null)

sem.model1=lmer(RT~Level+Responses+Level*Responses+(1|subject),data=sem.df,REML = FALSE)
sem.null1=lmer(RT~Level+Responses+(1|subject),data=sem.df,REML = FALSE)
anova(sem.model1,sem.null1)

sem.model2=lmer(RT~Level+Responses+Level*Responses+(1+Level+Responses|subject),data=sem.df,REML = FALSE)
sem.null2=lmer(RT~Level+Responses+(1+Level+Responses|subject),data=sem.df,REML = FALSE)
anova(sem.model2,sem.null2)

sem.model3=lmer(RT~Level+Responses+Level*Responses+(1+Responses|subject)+(1+Level|subject),data=sem.df,REML = FALSE)
sem.null3=lmer(RT~Level+Responses+(1+Responses|subject)+(1+Level|subject),data=sem.df,REML = FALSE)
anova(sem.model3,sem.null3)

sem.model4=lmer(RT~w2b+Responses+w2b*Responses+(1|subject)+(1|Responses),data=sem.df,REML = FALSE)
sem.null4=lmer(RT~w2b+Responses+(1|subject)+(1|Responses),data=sem.df,REML = FALSE)
anova(sem.model4,sem.null4)

