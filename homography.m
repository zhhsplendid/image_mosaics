function [ h ] = homography( corresPoints1, corresPoints2 )
  % takes a set of corresponding image points and computes the associated 
  % 3 x 3 homography matrix H. H(3, 3) = 1. w * p2 = H * p1, w is a constant
  % Suppose p1 = [x, y, 1]' and p2 = [x', y', 1]', H = [a, b, c; d, e, f; g, h, 1]
  %   We have
  %     x' = (ax + by + c) / w  ---- 1
  %     y' = (dx + ey + f) / w  ---- 2
  %     w  =  gx + hy + 1       ---- 3   
  % From 1, 3: (gx + hy + 1)x' = ax + by + c => x' = ax + by + c - gxx' - hyx'
  % From 2, 3: (gx + hy + 1)y' = dx + ey + f => y' = dx + ey + f - gxy' - hyy'
  
  % Let q = [a, b, c, d, e, f, g, h]';
  % We just need to find least squares solution of q in equation:
  % [x, y, 1, 0, 0, 0, -xx', -yx';       [x';
  %  0, 0, 0, x, y, 1, -xy', -yy'] * q =  y']
  % In following code, we try to find least squares of Aq - B as stated.
  
  n = size(corresPoints1, 1);
  
  B = reshape(corresPoints2, 2*n, 1);
  
  A = zeros(2 * n, 8);
  A(1:n, 1:2) = corresPoints1;
  A(1:n, 3) = ones(n, 1);
  A(n+1: 2*n, 4:5) = corresPoints1;
  A(n+1: 2*n, 6) = ones(n, 1);
  A(:,7) = -B .* [corresPoints1(:, 1); corresPoints1(:, 1)];
  A(:,8) = -B .* [corresPoints1(:, 2); corresPoints1(:, 2)];
  
  q = A \ B; % size(q) = [8, 1];
  h = reshape([q; 1], 3, 3)';
end

