function WorldRed = TransformPointsInverseRed(inPoints, tform)

invtform = inv(tform);

homogPoints = [inPoints, ones(size(inPoints, 1), 1)];

transformedPoints = homogPoints * invtform'; 

% Normalize back to Cartesian coordinates
WorldRed = transformedPoints(:, 1:2) ./ transformedPoints(:, 3);


end
