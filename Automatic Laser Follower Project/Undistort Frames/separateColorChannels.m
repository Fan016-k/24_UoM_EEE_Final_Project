function [R, G, B] = separateColorChannels(rgbImage)
    % Check if the input image is indeed an RGB image
    if size(rgbImage, 3) ~= 3
        error('Input must be an RGB image.');
    end

    % Separate the color channels
    R = rgbImage(:, :, 1); 
    G = rgbImage(:, :, 2);  
    B = rgbImage(:, :, 3);  
end
