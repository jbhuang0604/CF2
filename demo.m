

addpath('utility','model','cf_scale','external/matconvnet/matlab');


vl_setupnn();

% Note that the default setting does not enable GPU
% TO ENABLE GPU, recompile the MatConvNet toolbox  
vl_compilenn();

run_tracker('MotorRolling', 1, 1);