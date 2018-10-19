%  In this step, we extract features for all photos. We use clarity contrast
%  feature and composition geometry (rule of thirds) feature here. For more details about algorithms,
%  please refer to section 3 of Y. Luo and X. Tang, "Photo and Video Quality Evaluation: 
%  Focusing on the Subject," Proc. European Conf. Computer Vision, Oct.2008
%  The result will be saved in "../feature/feature.mat" file.

clear all;

%extract features of professional photos in traing set
root = '/Users/pzan/Documents/Study/631/';
train_good_folder = [root 'project_demo/data/train/good/'];
train_good_list = dir([root 'project_demo/data/train/good/*.jpg']);
%create a matrix to save the feature. If you use more featues, please
%modify the parameter '2' to your feature number. 
train_good_feature = zeros(length(train_good_list), 3);
for i=1:length(train_good_list)
    %read images
    I=imread(fullfile(train_good_folder,train_good_list(i).name));
    if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint8(tmpI);
    end
    %read blurmap extracted in step1
    bmap = load([root 'project_demo/feature/blurmap/train/good/',train_good_list(i).name(1:end-4),'.mat']);
    bmap = bmap.bm;
   
    %extract subject region
    [imin,imax,jmin,jmax]=blurboxcount(bmap,0.9);
    
    %you can modify the following code to use your own feature or add more
    %features.
    
    %extract clarity contrast feature
    train_good_feature(i,1)=clarity_contrast(I, imin, imax, jmin, jmax);
    %extract composition geometry feature
    %train_good_feature(i,2)=rule_third(bmap,imin,imax,jmin,jmax);
    train_good_feature(i,2)=simplicity_feature(I,imin,imax,jmin,jmax);
    train_good_feature(i,3)=lighting_feature(I,imin,imax,jmin,jmax);
    
end

%extract features of amateur photos in traing set
train_bad_folder = [root 'project_demo/data/train/bad/'];
train_bad_list = dir([root 'project_demo/data/train/bad/*.jpg']);
train_bad_feature = zeros(length(train_bad_list), 3);
for i=1:length(train_bad_list)
    I=imread(fullfile(train_bad_folder,train_bad_list(i).name));
    if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint8(tmpI);
    end
    bmap = load([root 'project_demo/feature/blurmap/train/bad/',train_bad_list(i).name(1:end-4),'.mat']);
    bmap = bmap.bm;
    [imin,imax,jmin,jmax]=blurboxcount(bmap,0.9);
    train_bad_feature(i,1)=clarity_contrast(I, imin, imax, jmin, jmax);
    %train_bad_feature(i,2)=rule_third(bmap,imin,imax,jmin,jmax);
    train_bad_feature(i,2)=simplicity_feature(I,imin,imax,jmin,jmax);
    train_bad_feature(i,3)=lighting_feature(I,imin,imax,jmin,jmax);
end

%extract features of professional photos in test set
test_good_folder = [root 'project_demo/data/test/good/'];
test_good_list = dir([root 'project_demo/data/test/good/*.jpg']);
test_good_feature = zeros(length(test_good_list), 3);
for i=1:length(test_good_list)
    I=imread(fullfile(test_good_folder,test_good_list(i).name));
    if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint8(tmpI);
    end
    bmap = load([root 'project_demo/feature/blurmap/test/good/',test_good_list(i).name(1:end-4),'.mat']);
    bmap = bmap.bm;
    [imin,imax,jmin,jmax]=blurboxcount(bmap,0.9);
    test_good_feature(i,1)=clarity_contrast(I, imin, imax, jmin, jmax);
    %test_good_feature(i,2)=rule_third(bmap,imin,imax,jmin,jmax);
    test_good_feature(i,2)=simplicity_feature(I,imin,imax,jmin,jmax);
    test_good_feature(i,3)=lighting_feature(I,imin,imax,jmin,jmax);
end

%extract features of amateur photos in test set
test_bad_folder = [root 'project_demo/data/test/bad/'];
test_bad_list = dir([root 'project_demo/data/test/bad/*.jpg']);
test_bad_feature = zeros(length(test_bad_list), 3);
for i=1:length(test_bad_list)
    I=imread(fullfile(test_bad_folder,test_bad_list(i).name));
    if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint8(tmpI);
    end
    bmap = load([root 'project_demo/feature/blurmap/test/bad/',test_bad_list(i).name(1:end-4),'.mat']);
    bmap = bmap.bm;
    [imin,imax,jmin,jmax]=blurboxcount(bmap,0.9);
    test_bad_feature(i,1)=clarity_contrast(I, imin, imax, jmin, jmax);
    %test_bad_feature(i,2)=rule_third(bmap,imin,imax,jmin,jmax);
    test_bad_feature(i,2)=simplicity_feature(I,imin,imax,jmin,jmax);
    test_bad_feature(i,3)=lighting_feature(I,imin,imax,jmin,jmax);
end

save /Users/pzan/Documents/Study/631/project_demo/feature/feature.mat train_good_feature train_bad_feature test_good_feature test_bad_feature