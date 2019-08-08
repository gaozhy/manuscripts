#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug  5 21:29:56 2019

@author: zg
"""

import scipy.io
import os.path
import numpy as np
os.chdir('/home/zg/mix_R')
sem=scipy.io.loadmat('sem_lme_data.mat')
wm=scipy.io.loadmat('wm_lme_data.mat')

sdata=sem['allmixed']
semdata=sdata
wdata=wm['allmixed']
wmdata=wdata

subj_sid=np.unique(sdata[:,0])
subj_wid=np.unique(wdata[:,0])
level=np.array([1,2,3,4,5])
wlevel=np.array([3,4,5,6,7])
correctness=np.array([0,1])
response=np.array([1,2])
#
#for s in subj_sid:
#    #for l in level:
#        for r in response:
#            semdata[(sdata[:,0]==s)&(sdata[:,3]==r),4]=sdata[(sdata[:,0]==s)&(sdata[:,3]==r),4]-np.nanmean(sdata[(sdata[:,0]==s)&(sdata[:,3]==r),4])
#            
#scipy.io.savemat('demean_semdata.mat',{'semdata':semdata})
#
#for s in subj_wid:
#   # for l in wlevel:
#        for r in correctness:
#            wmdata[(wdata[:,0]==s)&(wdata[:,2]==r),3]=wdata[(wdata[:,0]==s)&(wdata[:,2]==r),3]-np.nanmean(wdata[(wdata[:,0]==s)&(wdata[:,2]==r),3])

ysem_stats=np.zeros([2,5])
nsem_stats=np.zeros([2,5])
for l in level:
        ysem_stats[0,l-1]=np.mean(sdata[(sdata[:,1]==l)&(sdata[:,3]==1),4])
        ysem_stats[1,l-1]=np.std(sdata[(sdata[:,1]==l)&(sdata[:,3]==1),4])/np.sqrt(28)
        nsem_stats[0,l-1]=np.mean(sdata[(sdata[:,1]==l)&(sdata[:,3]==2),4])
        nsem_stats[1,l-1]=np.std(sdata[(sdata[:,1]==l)&(sdata[:,3]==2),4])/np.sqrt(28)   

ywm_stats=np.zeros([2,5])
nwm_stats=np.zeros([2,5])
for l in wlevel:
    ywm_stats[0,l-3]=np.mean(wdata[(wdata[:,1]==l)&(wdata[:,2]==1),3])
    ywm_stats[1,l-3]=np.std(wdata[(wdata[:,1]==l)&(wdata[:,2]==1),3])/np.sqrt(27)
    nwm_stats[0,l-3]=np.nanmean(wdata[(wdata[:,1]==l)&(wdata[:,2]==0),3])
    nwm_stats[1,l-3]=np.nanstd(wdata[(wdata[:,1]==l)&(wdata[:,2]==0),3])/np.sqrt(27)         
scipy.io.savemat('beh_stats_swdata.mat',{'ysem_stats':ysem_stats,'nsem_stats':nsem_stats,'ywm_stats':ywm_stats,'nwm_stats':nwm_stats})