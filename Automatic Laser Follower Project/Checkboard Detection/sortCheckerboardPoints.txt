function sortedAllPoints = sortCheckerboardPoints(points)
    points = double(points);

    % Remove rows with NaN values to clean the input data
    points = points(~any(isnan(points), 2), :);

    numRows = 6; 
    numCols = 8; 

    % Initialize the sorted points array
    sortedAllPoints = NaN(numRows * numCols, 2); 
    
    % Use kmeans to cluster points based on x-coordinate with PlusPlus initialization
    opts = statset('UseParallel', true, 'MaxIter', 1000);
    [idx, C] = kmeans(points(:,1), numCols, 'Options', opts, 'Distance', 'sqEuclidean', 'Replicates', 5, 'Start', 'plus');

    % Sort the centroids of clusters to ensure the order of clusters is from left to right
    [~, centroidOrder] = sort(C);
    
    % Initialize an index to keep track of where to insert points into sortedAllPoints
    insertIndex = 1;
    
    % Sort points within each cluster based on y-coordinate
    for i = 1:numCols
        % Find the points in the current cluster
        clusterPoints = points(idx == centroidOrder(i), :);
        
        % Sort the points in this cluster by their y-coordinate
        [~, order] = sort(clusterPoints(:,2), 'ascend');
        sortedClusterPoints = clusterPoints(order, :);
            
    % Dynamically handle missing or extra points in a cluster
    numPointsInCluster = size(sortedClusterPoints, 1);
    if numPointsInCluster >= numRows
        % If there are enough points, take the top numRows points
        sortedClusterPoints = sortedClusterPoints(1:numRows, :);
    else
        % If there are missing points, append NaN rows to make up the difference
        rowsToAdd = numRows - numPointsInCluster;
        if rowsToAdd > 0
            nanRows = NaN(rowsToAdd, 2);
            sortedClusterPoints = [sortedClusterPoints; nanRows];
        end
    end
        
        % Insert sorted points into the sortedAllPoints array
        sortedAllPoints(insertIndex:insertIndex + numRows - 1, :) = sortedClusterPoints;
        insertIndex = insertIndex + numRows;
    end
end
