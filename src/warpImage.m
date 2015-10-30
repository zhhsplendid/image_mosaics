function [ outputImage, minRow, minCol, oriXY] = warpImage( inputImage, h )
  % Return a new image that is the warp of the input image using homography h
  % If the transformation causes the coordinates of outputImage has negtive
  % values, we return negtive values. Else just return zero.
    [row, col, channels] = size(inputImage);
    vertexs = zeros(4, 2);
    [vertexs(1,1), vertexs(1,2)] = homographyTrans(0, 0, h);
    [vertexs(2,1), vertexs(2,2)] = homographyTrans(col, 0, h);
    [vertexs(3,1), vertexs(3,2)] = homographyTrans(0, row, h);
    [vertexs(4,1), vertexs(4,2)] = homographyTrans(col, row, h);
    
   
    minXY = min(vertexs);
    maxXY = max(vertexs);
    
    minRow = floor(min(0, minXY(2)));
    maxRow = ceil(maxXY(2));
    minCol = floor(min(0, minXY(1)));
    maxCol = ceil(maxXY(1));
    rowOffset = 1 - min(1, minRow);
    colOffset = 1 - min(1, minCol);
    
    outputImage = zeros(maxRow + rowOffset, maxCol + colOffset, channels);
    
    
    cIndex = minCol: maxCol;
    rIndex = minRow: maxRow;
    [ctmp, rtmp] = ndgrid(cIndex, rIndex);
    crIndex = [ctmp(:), rtmp(:)]'; % size(crIndex) = [2, *]
    
    %TODO add comments
    % In homography.m, we use w * p2 = h * p1,
    % => inv(h) * p2 = (1/w) * p1
    % we have h and p2, how to get (1/w)? p1(3) = 1 !
    
    total = size(crIndex, 2);
    
    pp = [crIndex; ones(1, total)];
    p = h \ pp;
    invIndex = zeros(2, total);
    invIndex(1,:) = p(1,:) ./ p(3, :);
    invIndex(2,:) = p(2,:) ./ p(3, :);
    
    toKeep = invIndex(1,:) >= 1 & invIndex(1,:) <= col & invIndex(2,:) >= 1 & invIndex(2,:) <= row;
    invXY = invIndex(1:2, toKeep);
    oriXY = crIndex(1:2, toKeep);
    
    n = size(invXY, 2);
    colorValues = zeros(1, n, channels);
    for i = 1:channels
        colorValues(:,:,i) = interp2(double(inputImage(:,:,i)), invXY(1,:), invXY(2,:));
        for j = 1:n
            outputImage(oriXY(2, j) + rowOffset, oriXY(1, j) + colOffset, i) = colorValues(1, j, i); 
        end
    end
    
    outputImage = uint8(outputImage);
end

