function main( )
    % Usage, call twoImageMosaic(image1, image2, autoMatch, useRansac)
    % image1&2 are directory and name of two input images
    % autoMatch and useRansac are boolean values to indicate whether use
    % automatically matching or RANSAC if you don't use autoMatch
    % you need to clikc on one point in left image, then corresponding one 
    % point in right image. Then the next pair of points. Press Enter when you finish. 
    
    AUTO_MATCH = true;
    RANSAC = true;
    
    % Question 1, show example of ut tower
    twoImageMosaic('input_images/utTower1.JPG', 'input_images/utTower2.JPG', AUTO_MATCH, ~RANSAC);
    
    % Question 2, add own example
    %twoImageMosaic('input_images/myroom1.JPG', 'input_images/myroom2.JPG', AUTO_MATCH, ~RANSAC);
    
    % Question 3, 
    % TODO question 3, you need go to line 17 in autoCorresp.m, change the
    % third parameter to small value. Then you can see automatical matching
    % doesn't work.
    %twoImageMosaic('input_images/utTower1.JPG', 'input_images/utTower2.JPG', AUTO_MATCH, ~RANSAC);
    
    % Question 4,
    %twoImageMosaic('input_images/meHuihuangZheng.JPG', 'input_images/KristenClass.JPG', ~AUTO_MATCH, ~RANSAC);
    
    % Extra Credit
    % RANSAC
    %twoImageMosaic('input_images/utTower1.JPG', 'input_images/utTower2.JPG', AUTO_MATCH, RANSAC);
    
    % Rectify
    %rectify('input_images/utTower1.JPG');
    
end

