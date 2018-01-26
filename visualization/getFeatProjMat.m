

% 1. download the BSD500 dataset and prepare the training images

% websave('BSD500.tgz','http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/BSR/BSR_bsds500.tgz');
% untar('BSD500.tgz', 'BSD500');
% movefile('BSD500/BSR/BSDS500/data/images/test/*.jpg','BSD500');
% movefile('BSD500/BSR/BSDS500/data/images/train/*.jpg','BSD500');
% movefile('BSD500/BSR/BSDS500/data/images/val/*.jpg','BSD500');


% 2. setup MatConvNet if you did not install it

% untar('http://www.vlfeat.org/matconvnet/download/matconvnet-1.0-beta25.tar.gz') ;
% cd matconvnet-1.0-beta25
% run matlab/vl_compilenn ;
% run matlab/vl_setupnn ;
% cd ..

% 3. Download a pre-trained CNN from the web (needed once).

if ~exist('imagenet-vgg-verydeep-19.mat','file')
    urlwrite(...
      'http://www.vlfeat.org/matconvnet/models/imagenet-vgg-verydeep-19.mat', ...
      'imagenet-vgg-verydeep-19.mat') ;
end

% 4. compute feature and save them in DSD500_feat
mkdir('BSD500_feat');

% Load a model and upgrade it to MatConvNet current version.

net = load('imagenet-vgg-verydeep-19.mat');
net = vl_simplenn_tidy(net) ;

% Obtain and preprocess an image.

ims=dir('BSD500/*.jpg');

for ii=1:length(ims)
    im=imread(fullfile(ims(ii).folder,ims(ii).name));
    im_ = single(im) ; % note: 255 range
    im_ = imresize(im_, net.meta.normalization.imageSize(1:2)) ;
    im_ = im_ - net.meta.normalization.averageImage ;

    % Run the CNN.
    res = vl_simplenn(net, im_) ;
    
    save(fullfile('BSD500_feat',strrep(ims(ii).name,'jpg','mat')),'res');

end



% 5. Compute the projection matrix for conv1, conv2, conv3, conv4, conv5


nLayers = [5 10 19 28 37]; % After pool5

mats=dir('BSD500_feat/*.mat');

for nLayer=nLayers
   
    load(fullfile(mats(ii).folder, mats(1).name));
    % Remove later layers
    sz=size(res(nLayer).x);

    % features
    numFeatMapSize = sz(1);
    numFeatSample = 500;
    numFeatDim    = sz(3);

    % Initialize data matrix
    X = zeros(numFeatMapSize, numFeatMapSize, numFeatDim,numFeatSample, 'single');

    for i = 1: length(mats)
    
        load(fullfile(mats(ii).folder, mats(i).name));
        
        X(:,:,:, i) = res(nLayer).x;
        
    end
    
    X = permute(X, [1,2,4,3]);
    
    X = reshape(X, [numFeatMapSize*numFeatMapSize*numFeatSample, numFeatDim]);

    % Compute PCA
    meanFeat = mean(X, 1)';
    M = cov(X);
    [V, D] = eigs(double(M));

    if ~exist('projMatrix','var')
        projMatrix=struct('meanFeat',meanFeat,'M', M, 'V', V, 'D',D,...
            'numLayer', nLayer, 'nameLayer', net.layers{nLayer-1}.name); 
    else
        projMatrix(end+1)=struct('meanFeat',meanFeat,'M', M, 'V', V, 'D',D,...
            'numLayer', nLayer, 'nameLayer', net.layers{nLayer-1}.name);    
    end

end



save projMatrix.mat projMatrix

