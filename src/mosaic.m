function [ outputImage ] = mosaic(image1, image2, minRow, minCol, oriXY)
  % This function combines two images together.
  
  rowOffset = 1 - min(1, minRow);
  colOffset = 1 - min(1, minCol);
  
  [row1, col1, channel1] = size(image1);
  [row2, col2, channel2] = size(image2);
  
  outputImage = uint8(zeros( max(rowOffset + row1, row2), max(colOffset + col1, col2), 3));
  outputImage(rowOffset + (1:row1), colOffset + (1:col1), 1:channel1) = image1;
  n = size(oriXY, 2);
  for j = 1:n
    outputImage(oriXY(2, j) + rowOffset, oriXY(1, j) + colOffset, :) = image2(oriXY(2, j) + rowOffset, oriXY(1, j) + colOffset, :); 
  end
end

