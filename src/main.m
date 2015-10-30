function main( )
    % Usage, call twoImageMosaic(image1, image2, autoMatch, useRansac)
    % image1&2 are directory and name of two input images
    % autoMatch and useRansac are boolean values to indicate whether use
    % automatically matching or RANSAC if you don't use autoMatch
    % you need to clikc on one point in left image, then corresponding one 
    % point in right image. Then the next pair of points. 
    
    AUTO_MATCH = true;
    RANSAC = true;
    
    % Question 1, show example of ut tower
    twoImageMosaic('input_images/utTower1.JPG', 'input_images/utTower2.JPG', AUTO_MATCH, ~RANSAC);
    
    % Question 2, add own example
    % TODO
    
    % Question 3, 
    
    % Question 4,
    
    % Extra Credit
    % RANSAC
    twoImageMosaic('input_images/utTower1.JPG', 'input_images/utTower2.JPG', AUTO_MATCH, RANSAC);
    
    % Rectify
    rectify('input_images/utTower1.JPG');
    
end

