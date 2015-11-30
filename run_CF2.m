function results = run_CF2(seq, res_path, bSaveImage)

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

% ================================================================================
% Environment setting
% ================================================================================

% Image file names
img_files = seq.s_frames;
% Seletected target size
target_sz = [seq.init_rect(1,4), seq.init_rect(1,3)];
% Initial target position
pos       = [seq.init_rect(1,2), seq.init_rect(1,1)] + floor(target_sz/2);

% Extra area surrounding the target for including contexts
padding = struct('generic', 1.8, 'large', 1, 'height', 0.4);

lambda = 1e-4;              % Regularization
output_sigma_factor = 0.1;  % Spatial bandwidth (proportional to target)

interp_factor = 0.01;       % Model learning rate
cell_size = 4;              % Spatial cell size

video_path='';

show_visualization=false;

% ================================================================================
% Main entry function for visual tracking
% ================================================================================
[positions, time] = tracker_ensemble(video_path, img_files, pos, target_sz, ...
    padding, lambda, output_sigma_factor, interp_factor, ...
    cell_size, show_visualization);

% ================================================================================
% Return results to benchmark, in a workspace variable
% ================================================================================
rects      = [positions(:,2) - target_sz(2)/2, positions(:,1) - target_sz(1)/2];
rects(:,3) = target_sz(2);
rects(:,4) = target_sz(1);
results.type   = 'rect';
results.res    = rects;
results.fps    = numel(img_files)/time;

end

