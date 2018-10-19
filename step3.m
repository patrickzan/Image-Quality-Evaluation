%  In this step, we use k-nearest-neighbor(knn) classifier to classify photos
%  in single feature, and combine the results of different featuers by
%  bayesian. The result is in "../result/result.txt", you need to upload
%  this file as your project result. 

clear all;
root = '/Users/pzan/Documents/Study/631/';
feature = load([root 'project_demo/feature/feature.mat']);
trainset = [feature.train_good_feature; feature.train_bad_feature];
testset = [feature.test_good_feature; feature.test_bad_feature];
pos_train_num = size(feature.train_good_feature,1);
neg_train_num = size(feature.train_bad_feature,1);
pos_test_num =size(feature.test_good_feature,1);
neg_test_num = size(feature.test_bad_feature,1);
test_num = size(testset,1);

%the k in  k-nearest-neighbor(knn) classifier
if pos_train_num + neg_train_num > 200
    k = 145;
else
    k = 4;  % This parameter only used in the toy dataset, which is very small. For the real dataset, please use the parameter above
end

%
%feature 1: clartiy feature
%
clarity_train_feature = trainset(:,1);
clarity_test_feature = testset(:,1);
%calculate the distance between two photos by using clarity feature
clarity_train_feature_mat = repmat(clarity_train_feature, 1,pos_test_num + neg_test_num);
clarity_test_feature_mat = repmat(clarity_test_feature', pos_train_num + neg_train_num,1);
clarity_distance = clarity_train_feature_mat - clarity_test_feature_mat;
clarity_distance = clarity_distance.^2;
%after calculating the distance, use k-nearest-neighbor(knn) classifier
%to classify photos
[clarity_disMat,clarity_Index] = sort(clarity_distance);
clarity_test_pos = sum(clarity_Index(1:k,:)<pos_train_num + 1);
clarity_test_neg = sum(clarity_Index(1:k,:)>pos_train_num);
clarity_test_pos = clarity_test_pos./k;
clarity_test_neg = clarity_test_neg./k;
%we use 0.5 as the threshold
clarity_precision = (sum(clarity_test_pos(1:pos_test_num)>0.5) + sum(clarity_test_pos(pos_test_num + 1:test_num)<0.5))/test_num;

%
%feature 2:simplicity_feature
%
simplicity_train_feature = trainset(:,2);
simplicity_test_feature = testset(:,2);
%calculate the distance between two photos by using clarity feature
simplicity_train_feature_mat = repmat(simplicity_train_feature, 1,pos_test_num + neg_test_num);
simplicity_test_feature_mat = repmat(simplicity_test_feature', pos_train_num + neg_train_num,1);
simplicity_distance = simplicity_train_feature_mat - simplicity_test_feature_mat;
simplicity_distance = simplicity_distance.^2;
%after calculating the distance, use k-nearest-neighbor(knn) classifier
%to classify photos
[simplicity_disMat,simplicity_Index] = sort(simplicity_distance);
simplicity_test_pos = sum(simplicity_Index(1:k,:)<pos_train_num + 1);
simplicity_test_neg = sum(simplicity_Index(1:k,:)>pos_train_num);
simplicity_test_pos = simplicity_test_pos./k;
simplicity_test_neg = simplicity_test_neg./k;
%we use 0.5 as the threshold
simplicity_precision = (sum(simplicity_test_pos(1:pos_test_num)>0.5) + sum(simplicity_test_pos(pos_test_num + 1:test_num)<0.5))/test_num;

%
%feature 3:lighting_feature
%
lighting_train_feature = trainset(:,3);
lighting_test_feature = testset(:,3);
%calculate the distance between two photos by using clarity feature
lighting_train_feature_mat = repmat(lighting_train_feature, 1,pos_test_num + neg_test_num);
lighting_test_feature_mat = repmat(lighting_test_feature', pos_train_num + neg_train_num,1);
lighting_distance =lighting_train_feature_mat - lighting_test_feature_mat;
lighting_distance = lighting_distance.^2;
%after calculating the distance, use k-nearest-neighbor(knn) classifier
%to classify photos
[lighting_disMat,lighting_Index] = sort(lighting_distance);
lighting_test_pos = sum(lighting_Index(1:k,:)<pos_train_num + 1);
lighting_test_neg = sum(lighting_Index(1:k,:)>pos_train_num);
lighting_test_pos = lighting_test_pos./k;
lighting_test_neg = lighting_test_neg./k;
%we use 0.5 as the threshold
lighting_precision = (sum(lighting_test_pos(1:pos_test_num)>0.5) + sum(lighting_test_pos(pos_test_num + 1:test_num)<0.5))/test_num;


% Combine all scores of different features by bayesian.
% For more details, see section 5, formula 14,15,16 in 
% Y. Ke, X. Tang, and F. Jing, "The Design of High-Level Features for Photo Quality Assessment," 
% Proc. IEEE Conf. Computer Vision and Pattern Recognition, vol. 1, pp.
% 419-426, Jun. 2006.
a = (clarity_test_pos.*simplicity_test_pos.*lighting_test_pos);
b = (clarity_test_neg.*simplicity_test_neg.*lighting_test_neg);
bayesian_test = zeros(1,test_num);
for j = 1:test_num
    bayesian_test(j) = a(j)/b(j);
end
precision = (sum(bayesian_test(1:pos_test_num)>1)+sum(bayesian_test(pos_test_num+1:test_num)<1))/test_num;
precision_pos = sum(bayesian_test(1:pos_test_num)>1)/pos_test_num;
precision_neg = sum(bayesian_test(pos_test_num+1:test_num)<1)/neg_test_num;
max_precision = max(precision);
fprintf('The overall precision is %2.2f%%.\n', precision*100);
save /Users/pzan/Documents/Study/631/project_demo/result/result.mat clarity_precision simplicity_precision lighting_precision bayesian_test precision max_precision precision_pos precision_neg

%output the result
%please DO NOT modify the following code!!!
output = fopen([root 'project_demo/result/result.txt'],'w+');
for i = 1:test_num
    fprintf(output, '%d %f\r\n', i, bayesian_test(i));
end
fclose(output);