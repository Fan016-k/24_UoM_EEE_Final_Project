function original = mapPointsToOriginal(cropped)
    rowOffset = 300 - 1;
    colOffset = 300 - 1;
    
    original = zeros(size(cropped));
    
    % Map each cropped point back to its original position
    for i = 1:size(cropped, 1)
        original(i, 1) = cropped(i, 1) + colOffset;
        original(i, 2) = cropped(i, 2) + rowOffset;
    end
end
