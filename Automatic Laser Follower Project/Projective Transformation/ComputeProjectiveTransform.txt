function [tform, X, Tvec, Tinv]  = ComputeProjectiveTransform(normMatrix1, normMatrix2, xy, uv)
    minRequiredNonCollinearPairs = 4;
    if size(uv, 1) < minRequiredNonCollinearPairs || size(xy, 1) < minRequiredNonCollinearPairs
        error('At least 4 non-collinear points are required in both input sets.');
    end
    
    % Prepare matrices for the linear system
    M = size(xy, 1);
    x = xy(:, 1);
    y = xy(:, 2);
    vec_1 = ones(M, 1);
    vec_0 = zeros(M, 1);
    u = uv(:, 1);
    v = uv(:, 2);
    
    U = [u; v];
    
    X = [x      y      vec_1  vec_0  vec_0  vec_0  -u.*x  -u.*y;
         vec_0  vec_0  vec_0  x      y      vec_1  -v.*x  -v.*y];
     
    % Solve the linear system X * Tvec = U for Tvec
    Tvec = X \ U;
    Tvec = [Tvec; 1];
    % Reshape Tvec to a 3x3 matrix, and adjust for normalization
    Tinv = reshape(Tvec, 3, 3);
    Tinv = normMatrix2 \ (Tinv * normMatrix1); % Adjust T with normalization matrices
    T = inv(Tinv);
    T = T ./ T(3, 3);
    tform = T';
end
