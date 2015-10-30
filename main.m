function main( )
    AUTO_MATCH = true;
    RANSAC = true;
    
    twoImageMosaic('input_images/utTower1.JPG', 'input_images/utTower2.JPG', AUTO_MATCH, ~RANSAC);
    
end

