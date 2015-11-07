function [ rectImage, h ] = rectify( imageDirName)
  % Rectify takes input image, then user chooses 4 points in the imags
  % by click four corners order: top left, bottom left, top right, bottom
  % right. Then press Enter. The output image is square picture. h is the homography when transform 
  
  
  N = 400;
  image = imread(imageDirName);
  [row, col, channel] = size(image);
  rectImage = uint8(zeros(N, N, channel));
  
  
  figure;
  imshow(image);
  title('Please click four corners, order: top left, bottom left, top right, bottom right. Then press Enter');
  
  corresPoints1 = ginput();
  corresPoints2 = [0,0; 0,N; N,0; N,N];
  
  h = homography(corresPoints1, corresPoints2)
  
  [warpedImage, minRow, minCol, oriXY] = warpImage( image, h );
  rowOffset = 1 - min(1, minRow);
  colOffset = 1 - min(1, minCol);
  
  toKeep = oriXY(1,:) >= 1 & oriXY(1,:) <= N & oriXY(2, :) >= 1 & oriXY(2,:) <= N;
  oriXY = oriXY(:,toKeep);
  n = size(oriXY, 2);
  
  for j = 1:n
    rectImage(oriXY(2, j), oriXY(1, j), :) = warpedImage(oriXY(2, j) + rowOffset, oriXY(1, j) + colOffset, :);
  end
 
  figure;
  imshow(rectImage);
  title('rectified image');
end

