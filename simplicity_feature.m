function fs =simplicity_feature(I,imin,imax,jmin,jmax)
if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint16(tmpI);
end
for i=imin:imax
    for j=jmin:jmax
        for k=1:3
            I(i,j,k)=0;
        end
    end
end
I=reshape(I,size(I,1)*size(I,2)*size(I,3),1);
edge=zeros(1,4096);
r=0.01;
for i=0:4095;
    edge(i+1)=i;
end
h=histc(I,edge);
hmax=max(h);
S=zeros(1,4096);
for i=1:4096
    if h(i)>=r*hmax;
        S(i)=h(i);
    end
end
S=norm(S);
fs=S/4096;
end

