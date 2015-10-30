function [tf] = testHomography(  )
    
    n = 10;
    
    h = rand(3, 3);
    h(3, 3) = 1;
    h
    
    p1 = rand(n, 2);
    pp1 = [p1, ones(n, 1)]';
    pp2 = h * pp1;
    
    p2 = zeros(n, 2);
    p2(:,1) = (pp2(1,:) ./ pp2(3,:))';
    p2(:,2) = (pp2(2,:) ./ pp2(3,:))';
    
    h2 = homography(p1, p2)
    
    if h ~= h2
        tf = false;
    else
        tf = true;
    end
    
    cmpPP2 = [p2, ones(n, 1)]';
    cmpPP1 = h \ cmpPP2;
    cmpP1 = zeros(n, 2);
    cmpP1(:,1) = (cmpPP1(1,:) ./ cmpPP1(3,:))';
    cmpP1(:,2) = (cmpPP1(2,:) ./ cmpPP1(3,:))';
    p1
    cmpP1
    if p1 ~= cmpP1
        tf = false;
    end
end

