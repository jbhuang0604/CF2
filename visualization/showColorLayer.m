function featColor = showColorLayer(feat, meanFeat, V)

[Height, Width, numFeatDim] = size(feat);

feat = reshape(feat, [Height*Width, numFeatDim]);

% Centering
feat = bsxfun(@minus, feat, meanFeat);

% Projection onto PC
featCoef = feat*V(:,1:3);

% Convert to color
A = [0.3333    0.5000    0.3333;
     0.3333   -0.5000    0.3333;
     0.3333         0   -0.6667]';

featColor = featCoef*A;
featColor = reshape(featColor, [Height, Width, 3]);

% Normalize to [0, 255]
featColor = featColor - min(featColor(:));
featColor = featColor / max(featColor(:));

featColor = uint8(featColor*255);


end