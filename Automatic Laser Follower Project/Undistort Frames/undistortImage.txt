function undistortedImage = undistortImage(inputImage)
    % Store the intrinsic matrix K
    intrinsicMatrix = [1025.30186847282, 0, 659.328530484529;
                       0, 1028.22633873043, 350.911761479516;
                       0, 0, 1];
    
    % Store the radial distortion coefficients
    k1 = 0.146451856840480;
    k2 = -0.129982636042747;
    
    % Initialize the undistorted image
    undistortedImage = zeros(size(inputImage), 'like', inputImage);
    
    % Get the number of rows and columns in the image
    [rows, cols, ~] = size(inputImage);
    
    for u = 1:cols
        for v = 1:rows
            % Convert pixel coordinates to normalized image coordinates
            x = (u - intrinsicMatrix(1,3)) / intrinsicMatrix(1,1);
            y = (v - intrinsicMatrix(2,3)) / intrinsicMatrix(2,2);
            
            % Compute the radius squared
            rSquared = x^2 + y^2;
            
            % Compute the undistortion factor
            undistortFactor = 1 + k1 * rSquared + k2 * rSquared^2;
            
            % Compute the undistorted coordinates
            xUndistorted = x * undistortFactor;
            yUndistorted = y * undistortFactor;
            
            % Convert back to pixel coordinates
            uUndistorted = round(xUndistorted * intrinsicMatrix(1,1) + intrinsicMatrix(1,3));
            vUndistorted = round(yUndistorted * intrinsicMatrix(2,2) + intrinsicMatrix(2,3));
            
            % Ensure the coordinates are within the image bounds
            if (uUndistorted > 0 && uUndistorted <= cols && vUndistorted > 0 && vUndistorted <= rows)
                undistortedImage(v, u, :) = inputImage(vUndistorted, uUndistorted, :);
            end
        end
    end
end
