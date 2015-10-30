function [retX, retY] = homographyTrans(x, y, h)
  % Return homography transformation h of a point
  
  p = [x; y; 1];
  w = h * p;
  retX = w(1, 1) / w(3, 1);
  retY = w(2, 1) / w(3, 1);

end

