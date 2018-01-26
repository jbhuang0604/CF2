

img=imread('peppers.png');

imgS=single(img);
[imgH, imgW, nCh] = size(img);
if nCh==1
    img=repmat(img,[1, 1, 3]);
end

net = load('imagenet-vgg-verydeep-19.mat');
net = vl_simplenn_tidy(net) ;

imgC = imresize(imgS, net.meta.normalization.imageSize(1:2));
imgC = imgC - net.meta.normalization.averageImage;

res = vl_simplenn(net, imgC);

load projMatrix.mat

j=3; % visualizing conv3

featColor=showColorLayer(res(projMatrix(j).numLayer).x, projMatrix(j).meanFeat', projMatrix(j).V);
featColor=imresize(featColor, [imgH, imgW]);

figure, imagesc(featColor)
figure, imagesc(255-featColor);
