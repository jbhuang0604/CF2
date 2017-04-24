function currentScaleFactor = estimate_scale( im_gray, pos, currentScaleFactor)

global para

% extract the test sample feature map for the scale filter
xs = get_scale_sample(im_gray, pos, para.app_sz, para.scaleFactors*currentScaleFactor, para.scale_window, para.scale_model_sz);

% calculate the correlation response of the scale filter
xsf = fft(xs,[],2);
scale_response = real(ifft(sum(para.sf_num .* xsf, 1) ./ (para.sf_den + para.lambda)));

% find the maximum scale response
recovered_scale = find(scale_response == max(scale_response(:)), 1);


currentScaleFactor = currentScaleFactor*para.scaleFactors(recovered_scale);
if currentScaleFactor < para.min_scale_factor
    currentScaleFactor = para.min_scale_factor;
elseif currentScaleFactor > para.max_scale_factor
    currentScaleFactor = para.max_scale_factor;
end

% update the scale model
%===========================
% extract the training sample feature map for the scale filter
xs = get_scale_sample(im_gray, pos, para.app_sz, currentScaleFactor * para.scaleFactors, para.scale_window, para.scale_model_sz);

% calculate the scale filter update
xsf = fft(xs,[],2);
new_sf_num = bsxfun(@times, para.ysf, conj(xsf));
new_sf_den = sum(xsf .* conj(xsf), 1);

para.sf_den = (1 - para.interp_factor) * para.sf_den + para.interp_factor * new_sf_den;
para.sf_num = (1 - para.interp_factor) * para.sf_num + para.interp_factor * new_sf_num;

end

