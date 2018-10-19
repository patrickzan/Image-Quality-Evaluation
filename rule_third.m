%  This function implements the composition geometry feature in section 3.5
%  of Y. Luo and X. Tang, "Photo and Video Quality Evaluation: Focusing on the
%  Subject," Proc. European Conf. Computer Vision, Oct. 2008.
%
function f=rule_third(bmap,imin,imax,jmin,jmax)
bmap=double(bmap);
cx=0.0;
cy=0.0;
nx=0.0;
ny=0.0;
for i=imin:imax
    for j=jmin:jmax
        cx=cx+i*bmap(i,j);
        cy=cy+j*bmap(i,j);
        nx=nx+bmap(i,j);
        ny=ny+bmap(i,j);
    end
end
cx=cx/nx;
cy=cy/ny;
cx=cx/size(bmap,1);
cy=cy/size(bmap,2);

e=zeros(1,4);
e(1)=((cx-1/3)^2+(cy-1/3)^2)^0.5;
e(2)=((cx-2/3)^2+(cy-1/3)^2)^0.5;
e(3)=((cx-1/3)^2+(cy-2/3)^2)^0.5;
e(4)=((cx-2/3)^2+(cy-2/3)^2)^0.5;
f=min(e);