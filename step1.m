%  In this step, we extract subject regions for all images. For more details about the subject region algorithm,
%  please refer to section 3.1 of Y. Luo and X. Tang, "Photo and Video Quality Evaluation: 
%  Focusing on the Subject," Proc. European Conf. Computer Vision, Oct.2008

%  It will cost about an hour to extract subject regions for 2000 images.
%  So we put it in a single step. The result will be under folder
%  "feature\blurmap\"

clear all;

% To save time, resize the longer side of image to 200.0 while keeping the ratio.
% Use the original image will improve the performance slightly  slow the
% algorithm.
maxsize = 200.0;


%extract blurmap for professional photos in training set
root = '/Users/pzan/Documents/Study/631/';
train_good_folder = '/Users/pzan/Documents/Study/631/project_demo/data/train/good/';
train_good_list = dir('/Users/pzan/Documents/Study/631/project_demo/data/train/good/*.jpg');
for i=1:length(train_good_list)
    %read an image
    I=imread(fullfile(train_good_folder,train_good_list(i).name));
    if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint8(tmpI);
    end
    if (max(size(I,1),size(I,2))>maxsize)
        a=maxsize/max(size(I,1),size(I,2));
    else
        a=1;
    end
    %resize an image
    I2=imresize(I,a,'bicubic');
    %extract a blurmap
    bm=blurmap(I2,1);
    bm(bm>1)=0;
    bm=imresize(bm,1/a,'bicubic');
    bm=double(uint8(bm));
    %save the blurmap
    save([root 'project_demo/feature/blurmap/train/good/',train_good_list(i).name(1:end-4),'.mat'],'bm');
    imwrite(bm, [root 'project_demo/feature/blurmap/train/good/',train_good_list(i).name]);
    fprintf('Extracting subject region of photo %s...\r\n', train_good_list(i).name);
end

%extract blurmap for amateur photos in training set
train_bad_folder = [root 'project_demo/data/train/bad/'];
train_bad_list = dir([root 'project_demo/data/train/bad/*.jpg']);
for i=1:length(train_bad_list)
    I=imread(fullfile(train_bad_folder,train_bad_list(i).name));
    if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint8(tmpI);
    end
    if (max(size(I,1),size(I,2))>maxsize)
        a=maxsize/max(size(I,1),size(I,2));
    else
        a=1;
    end
    I2=imresize(I,a,'bicubic');
    bm=blurmap(I2,1);
    bm(bm>1)=0;
    bm=imresize(bm,1/a,'bicubic');
    bm=double(uint8(bm));
    save([root 'project_demo/feature/blurmap/train/bad/',train_bad_list(i).name(1:end-4),'.mat'],'bm');
    imwrite(bm, [root 'project_demo/feature/blurmap/train/bad/',train_bad_list(i).name]);
    fprintf('Extracting subject region of photo %s...\r\n', train_bad_list(i).name);
end

%extract blurmap for professional photos in test set
test_good_folder = [root 'project_demo/data/test/good/'];
test_good_list = dir([root 'project_demo/data/test/good/*.jpg']);
for i=1:length(test_good_list)
    I=imread(fullfile(test_good_folder,test_good_list(i).name));
    if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint8(tmpI);
    end
    if (max(size(I,1),size(I,2))>maxsize)
        a=maxsize/max(size(I,1),size(I,2));
    else
        a=1;
    end
    I2=imresize(I,a,'bicubic');
    bm=blurmap(I2,1);
    bm(bm>1)=0;
    bm=imresize(bm,1/a,'bicubic');
    bm=double(uint8(bm));
    save([root 'project_demo/feature/blurmap/test/good/',test_good_list(i).name(1:end-4),'.mat'],'bm');
    imwrite(bm, [root 'project_demo/feature/blurmap/test/good/',test_good_list(i).name]);
    fprintf('Extracting subject region of photo %s...\r\n', test_good_list(i).name);
end

%extract blurmap for amateur photos in test set
test_bad_folder = [root 'project_demo/data/test/bad/'];
test_bad_list = dir([root 'project_demo/data/test/bad/*.jpg']);
for i=1:length(test_bad_list)
    I=imread(fullfile(test_bad_folder,test_bad_list(i).name));
    if ( size(I,3)==1 )
        tmpI=zeros(size(I,1),size(I,2),3);
        tmpI(:,:,1)=I;
        tmpI(:,:,2)=I;
        tmpI(:,:,3)=I;
        I=uint8(tmpI);
    end
    if (max(size(I,1),size(I,2))>maxsize)
        a=maxsize/max(size(I,1),size(I,2));
    else
        a=1;
    end
    I2=imresize(I,a,'bicubic');
    bm=blurmap(I2,1);
    bm(bm>1)=0;
    bm=imresize(bm,1/a,'bicubic');
    bm=double(uint8(bm));
    save([root 'project_demo/feature/blurmap/test/bad/',test_bad_list(i).name(1:end-4),'.mat'],'bm');
    imwrite(bm, [root 'project_demo/feature/blurmap/test/bad/',test_bad_list(i).name]);
    fprintf('Extracting subject region of photo %s...\r\n', test_bad_list(i).name);
end

