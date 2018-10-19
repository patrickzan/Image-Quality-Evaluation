%  This function will generate a blurmap of an image. For more details,
%  please refer to section 3.1 of Y. Luo and X. Tang, "Photo and Video Quality Evaluation: 
%  Focusing on the Subject," Proc. European Conf. Computer Vision, Oct. 2008.

function bm=blurmap(I,r)
warning off
I=rgb2gray(I);
I=double(I);
I=I/255;
E=zeros(42,1);
E(1)=-inf;
E(2)=-0.975;
for i=3:41
    E(i)=E(i-1)+0.05;
end
E(42)=inf;
HX=zeros(42,50);
HY=zeros(42,50);
for k=1:50
    f=ones(k)/(k^2);
    G=imfilter(I,f,'replicate','conv');
    tmpX=G(:,1:end-1)-G(:,2:end);
    tmpY=G(1:end-1,:)-G(2:end,:);
    tmpX=reshape(tmpX,size(tmpX,1)*size(tmpX,2),1);
    tmpY=reshape(tmpY,size(tmpY,1)*size(tmpY,2),1);
    hcx=histc(tmpX,E);
    hcy=histc(tmpY,E);
    hcx=hcx/sum(hcx);
    hcy=hcy/sum(hcy);
    hcx=log(hcx);
    hcy=log(hcy);
    HX(:,k)=hcx;
    HY(:,k)=hcy;
end

Ix=I(:,1:end-1)-I(:,2:end);
Iy=I(1:end-1,:)-I(2:end,:);
Ix=floor(20*Ix+21.5);
Iy=floor(20*Iy+21.5);
Px=zeros(size(Ix,1),size(Ix,2),50);
Py=zeros(size(Iy,1),size(Iy,2),50);
P=zeros(size(I,1),size(I,2),50);
for i=1:size(Px,1)
    Px(i,:,:)=HX(Ix(i,:),:);
end
for i=1:size(Py,1)
    Py(i,:,:)=HY(Iy(i,:),:);
end
P(:,1:end-1,:)=Px(:,:,:);
P(1:end-1,:,:)=P(1:end-1,:,:)+Py(:,:,:);
bm=zeros(size(I,1),size(I,2));

for i=1:size(I,1)
    for j=1:size(I,2)
        tmp=sum(sum(P(max(1,i-r):min(size(I,1),i+r),max(1,j-r):min(size(I,2),j+r),:)));
        [val,ind]=sort(tmp,'descend');
        bm(i,j)=ind(1);
    end
end

