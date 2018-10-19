function fl=lighting_feature(I,imin,imax,jmin,jmax)
if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
end
I=rgb2hsv(I);
Bs=zeros(size(I,1),size(I,2),1);
Bb=zeros(size(I,1),size(I,2),1);
Bs(imin:imax,jmin:jmax,1)=I(imin:imax,jmin:jmax,3);
Bb=I(:,:,3)-Bs;
Bs=norm(Bs)/sqrt((imax-imin+1)*(jmax-jmin+1));
Bb=norm(Bb)/sqrt((size(I,1)*size(I,2)-(imax-imin+1)*(jmax-jmin+1)));
fl=abs(log10(Bs/Bb));
end

