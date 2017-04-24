function init_scale_para(im_gray, target_sz, pos)

global para

im_sz=size(im_gray);
padding=1.8;
cell_size=4;

if target_sz(1)/target_sz(2)>2
    window_sz = floor(target_sz.*[1.4, 1+padding]);
elseif min(target_sz)>80 && prod(target_sz)/prod(im_sz(1:2))>0.1
    window_sz=floor(target_sz*2);

else        
    window_sz = floor(target_sz * (1 + padding));
end

app_sz=target_sz+2*cell_size;

nScales=33;
scale_sigma_factor=1/4;
scale_sigma = nScales/sqrt(33) * scale_sigma_factor;
ss = (1:nScales) - ceil(nScales/2);
ys = exp(-0.5 * (ss.^2) / scale_sigma^2);
para.ysf = single(fft(ys));

scale_step = 1.02;
ss = 1:nScales;
para.scaleFactors = scale_step.^(ceil(nScales/2) - ss);
%     currentScaleFactor = 1;

para.app_sz=app_sz;


if mod(nScales,2) == 0
    scale_window = single(hann(nScales+1));
    scale_window = scale_window(2:end);
else
    scale_window = single(hann(nScales));
end;

para.scale_window=scale_window;

scale_model_max_area = 512;
scale_model_factor = 1;
if prod(app_sz) > scale_model_max_area
    scale_model_factor = sqrt(scale_model_max_area/prod(app_sz));
end
para.scale_model_sz = floor(app_sz * scale_model_factor);
para.lambda=0.01;
para.interp_factor=0.01;

para.min_scale_factor = scale_step ^ ceil(log(max(5 ./ window_sz)) / log(scale_step));
para.max_scale_factor = scale_step ^ floor(log(min(im_sz(1:2)./ target_sz)) / log(scale_step));

% extract the training sample feature map for the scale filter
xs = get_scale_sample(im_gray, pos, app_sz, para.scaleFactors, para.scale_window, para.scale_model_sz);

% calculate the scale filter update
xsf = fft(xs,[],2);
para.sf_num = bsxfun(@times, para.ysf, conj(xsf));
para.sf_den = sum(xsf .* conj(xsf), 1);

end

