function main( )
    
    AUTOMATIC_CORRESPONDENCES = false;

    utTower1 = imread('input_images/utTower1.JPG');
    utTower2 = imread('input_images/utTower2.JPG');
    
    corresPoints1 = [];
    corresPoints2 = [];
    
    if AUTOMATIC_CORRESPONDENCES
        [corresPoints1, corresPoints2] = autoCorresp(utTower1, utTower2);
    else
        [corresPoints1, corresPoints2] = manualCorresp(utTower1, utTower2);
    end
    

end

