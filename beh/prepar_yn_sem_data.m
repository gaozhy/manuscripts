clear;clc;
load('sem_lme_data.mat');
sdata=allmixed;
ysem_id=unique(allmixed(:,1));
for s=1:length(ysem_id)
    sid=ysem_id(s);
   % for l=1:5
        for r=1:2
    sdata(allmixed(:,1)==sid&allmixed(:,4)==r,5)=allmixed(allmixed(:,1)==sid&allmixed(:,4)==r,5)-mean(allmixed(allmixed(:,1)==sid&allmixed(:,4)==r,5));
        end
    end


load('wm_lme_data.mat');
wdata=allmixed;
subj_id=unique(allmixed);
for s=1:length(subj_id)
    sid=subj_id(s);
    %for l=3:7
        for r=0:1
    wdata(allmixed(:,1)==sid&allmixed(:,3)==r,4)=allmixed(allmixed(:,1)==sid&allmixed(:,3)==r,4)-mean(allmixed(allmixed(:,1)==sid&allmixed(:,3)==r,4));
        end
    end

mstmp=zeros(5,2);
sstmp=zeros(5,2);
for l=1:5
    for r=1:2
        mstmp(l,r)=nanmean(sdata(sdata(:,2)==l&sdata(:,4)==r,5));
        sstmp(l,r)=nanstd(sdata(sdata(:,2)==l&sdata(:,4)==r,5));
    end
end

mwtmp=zeros(5,2);
swtmp=zeros(5,2);
for l=3:7
    for r=0:1
        mwtmp(l-2,r+1)=nanmean(wdata(wdata(:,2)==l&wdata(:,3)==r,4));
        swtmp(l-2,r+1)=nanstd(wdata(wdata(:,2)==l&wdata(:,3)==r,4));
    end
end
        