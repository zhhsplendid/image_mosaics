function [ h ] = ransac(  corresPoints1, corresPoints2)
  % This function implements ransac for homography
  n = size(corresPoints1, 1);
  REPEAT_TIME = n / 4;
  
  CHOOSE_FRACTION = 0.6;
  NUMBER_PAIRS = 4; % At least 4 points can we get a homography
  DISTANCE_THRESHOLD = 200000;
  INLINE_THRESHOLD = round(n * CHOOSE_FRACTION);
    
  bestError = Inf;
  h = zeros(3, 3);
  for i = 1: REPEAT_TIME;
    chooseIndex = randsample(n, NUMBER_PAIRS);
    modelPara1 = corresPoints1(chooseIndex, :);
    modelPara2 = corresPoints2(chooseIndex, :);
    maybeModel = homography(modelPara1, modelPara2);
    
    p1 = [corresPoints1, ones(n, 1)]';
    wp2 = maybeModel * p1;
    p2 = zeros(n, 2);
    p2(:,1) = (wp2(1,:) ./ wp2(3,:))';
    p2(:,2) = (wp2(2,:) ./ wp2(3,:))';
    
    euclideanDistSqur = sum( ((corresPoints1 - p2) .^ 2), 2); %size = n * 1
    chooseIndex = euclideanDistSqur < DISTANCE_THRESHOLD;
    inlineNumber = sum(chooseIndex);
    if inlineNumber > INLINE_THRESHOLD
      error = sum(euclideanDistSqur(chooseIndex)) / inlineNumber;
      if error < bestError
        modelPara1 = corresPoints1(chooseIndex, :);
        modelPara2 = corresPoints2(chooseIndex, :);
        h = homography(modelPara1, modelPara2);
        bestError = error;
      end
    end
  end
end

