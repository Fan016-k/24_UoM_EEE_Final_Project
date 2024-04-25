function [normMatrixworld, normMatrixImage, ImagePointsnorm, WorldPointsnorm] = NormalizePoints(world, pixel)

[WorldPointsnorm,normMatrixworld] = images.geotrans.internal.normalizeControlPoints(world);

[ImagePointsnorm,normMatrixImage] = images.geotrans.internal.normalizeControlPoints(pixel);

end
