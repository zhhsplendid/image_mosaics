function [outputImage, warpedImage, h] = twoImageMosaic(imageDirName1, imageDirName2, autoMatch, useRansac)
  % This function input dir and name of two images, and boolean antoMatch
  % if autoMatch == true, we will use vl_sift auto match features between
  % two images. Else, user should click on our GUI to match interest points
  
    utTower1 = imread(imageDirName1);
    utTower2 = imread(imageDirName2);
    
    corresPoints1 = [];
    corresPoints2 = [];
    h = [];
    if nargin < 3
        autoMatch = false;
    end
    
    if nargin < 4
        useRansac = false;
    end
    
    if autoMatch
        [corresPoints1, corresPoints2] = autoCorresp(utTower1, utTower2)
    else
        [corresPoints1, corresPoints2] = manualCorresp(utTower1, utTower2);
    end
    
    if useRansac
        h = ransac(corresPoints1, corresPoints2);
    else
        h = homography(corresPoints1, corresPoints2);
    end
    [ warpedImage, minRow, minCol, oriXY] = warpImage( utTower1, h );
    figure;
    imshow(warpedImage);
    title('warp image');
    outputImage = mosaic(utTower2, warpedImage, minRow, minCol, oriXY);
    figure;
    imshow(outputImage);
    title('mosaic');
end