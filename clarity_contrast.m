%  This function implements the clarity contrast feature in section 3.2
%  of Y. Luo and X. Tang, "Photo and Video Quality Evaluation: Focusing on the
%  Subject," Proc. European Conf. Computer Vision, Oct. 2008.

function f=clarity_contrast(I, imin, imax, jmin, jmax)
if (size(I,3)==3)
    I=rgb2gray(I);
end
F1=fftshift(fft2(double(I)/255));
F1=abs(F1);
F1=F1/max(max(F1))*100;
C1=size(find(F1>20),1);
G1=C1/size(F1,1)/size(F1,2);

F2=fftshift(fft2(double(I(imin:imax,jmin:jmax))/255));
F2=abs(F2);
F2=F2/max(max(F2))*100;
C2=size(find(F2>20),1);
G2=C2/size(F2,1)/size(F2,2);
f=log(G2/G1+(1e-6));



