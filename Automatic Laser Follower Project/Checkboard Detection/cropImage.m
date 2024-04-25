function Image_cropped = cropImage(I)
    % cropping region
    rowStart = 300;
    rowEnd = 600;
    colStart = 300;
    colEnd = 600;

    Image_cropped = I(rowStart:rowEnd, colStart:colEnd);
end
