%  This function will extract subject region from a blurmap. For more details,
%  please refer to section 3.1 of Y. Luo and X. Tang, "Photo and Video Quality Evaluation: 
%  Focusing on the Subject," Proc. European Conf. Computer Vision, Oct. 2008.

function [imin,imax,jmin,jmax]=blurboxcount(bmap,alpha)
bmap(find(bmap>1))=0;
bmap(1:10,:)=0;
bmap(end-9:end,:)=0;
bmap(:,1:10)=0;
bmap(:,end-9:end)=0;
tmpx=mean(bmap,2);
tmpy=mean(bmap,1);
alpha=(1-alpha)/2;

tmps=0;
imin=1;
while (tmps<sum(tmpx)*alpha)
    tmps=tmps+tmpx(imin);
    imin=imin+1;
end

tmps=0;
imax=size(bmap,1);
while (tmps<sum(tmpx)*alpha)
    tmps=tmps+tmpx(imax);
    imax=imax-1;
end

tmps=0;
jmin=1;
while (tmps<sum(tmpy)*alpha)
    tmps=tmps+tmpy(jmin);
    jmin=jmin+1;
end

tmps=0;
jmax=size(bmap,2);
while (tmps<sum(tmpx)*alpha)
    tmps=tmps+tmpy(jmax);
    jmax=jmax-1;
end