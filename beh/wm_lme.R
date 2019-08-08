library(R.matlab)
library(lme4)

wm_tmp<-readMat('/home/zg/mix_R/wm_lme_data.mat')
dm_wtmp<-readMat('/home/zg/mix_R/demean_wmdata.mat')

subject=wm_tmp$allmixed[,1]
Level=wm_tmp$allmixed[,2]
Responses=wm_tmp$allmixed[,3]
RT=wm_tmp$allmixed[,4]


wmixed=dm_wtmp$wmdata
dmsubject=wmixed[,1]
dmresponse=wmixed[,3]
dmLevel=wmixed[,2]
dmRT=wmixed[,4]




dms.df=data.frame(dmsubject,dmLevel,dmresponse,dmRT)
ys.df=dms.df[which(dms.df$dmresponse==1),]
ns.df=dms.df[which(dms.df$dmresponse==0),]
wm.df=data.frame(subject,Level,Responses,RT)

ywm_model=lm(dmRT~dmLevel,ys.df)
summary(ywm_model)
nwm_model=lm(dmRT~dmLevel,ns.df)
summary(nwm_model)

ywm_linear_model=lmer(dmRT~ddmLevel+(1|dmsubject),data=ys.df,REML = FALSE)
ywm_linear_null=lmer(dmRT~(1|dmsubject),data=ys.df,REML = FALSE)
anova(ywm_linear_model,ywm_linear_null)
nwm_linear_model=lmer(dmRT~dmLevel+(1|dmsubject),data=ns.df,REML = FALSE)
nwm_linear_null=lmer(dmRT~(1|dmsubject),data = ns.df,REML = FALSE)
anova(nwm_linear_model,nwm_linear_null)



raw_sy.df=wm.df[which(wm.df$Responses==1),]
raw_sn.df=wm.df[which(wm.df$Responses==0),]
raw_sy_linear_model=lmer(RT~Level+(1|subject),data=raw_sy.df,REML = FALSE)
raw_sy_linear_null=lmer(RT~(1|subject),data=raw_sy.df,REML = FALSE)
anova(raw_sy_linear_model,raw_sy_linear_null)

raw_sn_linear_model=lmer(RT~Level+(1|subject),data=raw_sn.df,REML=FALSE)
raw_sn_linear_null=lmer(RT~(1|subject),data=raw_sn.df,REML = FALSE)
anova(raw_sn_linear_model,raw_sn_linear_null)

wm.model1=lmer(RT~Level+Responses+Level*Responses+(1|subject),data=wm.df,REML = FALSE)
wm.null1=lmer(RT~Level+Responses+(1|subject),data=wm.df,REML = FALSE)
anova(wm.model1,wm.null1)




