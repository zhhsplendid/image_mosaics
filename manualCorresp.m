function [corresPoints1, corresPoints2] = manualCorresp(utTower1, utTower2);
  % This function returns corresponding points in two images.
  % corresPoints1 and 2 are N*2 matrices. First column and second column
  % represent x and y values in image of matlab
  
  % This function needs manually click, you should click one point on left
  % image (image1), and then click one corresponding point on right image 
  % (image2). Click points one by one.
  
  %TODO
  figure;
  subplot(1, 2, 1);
  imshow(utTower1);
  
  subplot(1, 2, 2);
  imshow(utTower2);
  
  points = ginput(); % size of points: (2N) * 2
  N2 = size(points, 1);
  corresPoints1 = points(mod(1:N2,2) == 1, :) % all odd indices 
  corresPoints2 = points(mod(1:N2,2) == 0, :) % all even indices 
  
end

