function [ corresPoints1, corresPoints2] = autoCorresp(image1, image2)
  % This function returns corresponding points in two images.
  % corresPoints1 and 2 are N*2 matrices. First column and second column
  % represent x and y values in image of matlab
  
  % This function automatically find matching points. It doesnt't need 
  % manually click 
  
  %TODO
    EUCLIDEAN_DIS_THRES = Inf;
    %[row1, col1, channel1] = size(image1)
    %[row2, col2, channel2] = size(image2)
    simage1 = single(rgb2gray(image1));
    simage2 = single(rgb2gray(image2));
    [feature1, descriptor1] = vl_sift(simage1) ;
    [feature2, descriptor2] = vl_sift(simage2) ;
    [matches, scores] = vl_ubcmatch(descriptor1, descriptor2, 1); 
    
    matches = matches(:,scores < EUCLIDEAN_DIS_THRES);
    feature1(1:2, matches(1,:));
    corresPoints1 = [feature1(1, matches(1,:)) ; feature1(2, matches(1,:)) ]';
    corresPoints2 = [feature2(1, matches(2,:)) ; feature2(2, matches(2,:)) ]';
    %size(corresPoints1)
    %size(corresPoints2)
end
