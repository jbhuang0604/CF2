1. download the mat file and put into the fold of matconvnet/mat
http://www.vlfeat.org/matconvnet/models/imagenet-vgg-verydeep-19.mat

2. include the path of matconvnet/matlab

3. The main entry file run_CF2.m

% RUN_CF2:
% process a sequence using CF2 (Correlation filter tracking with convolutional features)
%
% Input:
%     - seq:        sequence name
%     - res_path:   result path
%     - bSaveImage: flag for saving images
% Output:
%     - results: tracking results, position prediction over time
%
%   It is provided for educational/researrch purpose only.
%   If you find the software useful, please consider cite our paper.
%
%   Hierarchical Convolutional Features for Visual Tracking
%   Chao Ma, Jia-Bin Huang, Xiaokang Yang, and Ming-Hsuan Yang
%   IEEE International Conference on Computer Vision, ICCV 2015
%
% Contact:
%   Chao Ma (chaoma99@gmail.com), or
%   Jia-Bin Huang (jbhuang1@illinois.edu).


