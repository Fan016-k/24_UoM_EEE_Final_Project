function roi = selectROI(points)
    %#codegen
    assert(size(points, 2) == 2, 'Input points must have exactly two columns'); % Assert input size
    
    points = double(points);
    
    % Calculates the convex hull of the points detected
    K = convhull(points(:,1), points(:,2));
    
    % Initialize a array for points touching or close to the convex hull
    isTouchingHull = false(size(points, 1), 1);
    
    % Define a threshold distance for points to be excluded in the ROI 
    threshold = 10; 

    % Loop over each segment of the convex hull
    for i = 1:numel(K)-1
        P1 = points(K(i), :);
        P2 = points(K(i+1), :);
        edgeVector = P2 - P1;

        for j = 1:size(points, 1)
            if ~isTouchingHull(j) % Only check points not already touching the hull
                pointVector = points(j, :) - P1;
                crossVec = norm(cross([pointVector 0], [edgeVector 0]));
                edgeLength = norm(edgeVector);
                distanceToEdge = crossVec / edgeLength;

                if distanceToEdge < threshold
                    isTouchingHull(j) = true;
                end
            end
        end
    end

    % Include points that are part of the hull or touching the hull
    isTouchingHull(K) = true;

    % Extract the points based on the logical index to be excluded in ROI 
    roiPoints = points(isTouchingHull, :);

    roi = uint32(roiPoints);
    
    assert(size(roi, 2) == 2);
end
