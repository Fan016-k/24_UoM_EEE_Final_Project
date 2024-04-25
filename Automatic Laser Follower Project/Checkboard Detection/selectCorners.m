function selectedPoints = selectCorners(points, roiPoints, maxPoints)
    %#codegen
    
    % Ensures the inputs are in the correct format
    assert(size(points, 2) == size(roiPoints, 2));
    
    % Using setdiff to find the points not in the ROI 
    selectedPoints = setdiff(points, roiPoints, 'rows', 'stable');
    
    % Makes sure the points selected does not overflow  
    if size(selectedPoints, 1) > maxPoints
        selectedPoints = selectedPoints(1:maxPoints, :);
    end
end