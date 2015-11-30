function [positions, time] = tracker(video_path, img_files, pos, target_sz, ...
	padding, lambda, output_sigma_factor, interp_factor, cell_size, show_visualization)
%
%	
    
    im_sz=size(imread([video_path img_files{1}]));
    window_sz=get_search_window(target_sz,im_sz, padding);    
       
	
	%create regression labels, gaussian shaped, with a bandwidth
	%proportional to target size    
    
	output_sigma = sqrt(prod(target_sz)) * output_sigma_factor / cell_size;
    
    l1_patch_num=floor(window_sz/ cell_size);
    
	yf = fft2(gaussian_shaped_labels(output_sigma, l1_patch_num));
	
    %store pre-computed cosine window
	cos_window = hann(size(yf,1)) * hann(size(yf,2))';	
	
	if show_visualization,  %create video interface
		update_visualization = show_video(img_files, video_path);
	end
		
	%note: variables ending with 'f' are in the Fourier domain.

	time = 0;  %to calculate FPS
	positions = zeros(numel(img_files), 2);  %to calculate precision

    max_response=0;
    
	for frame = 1:numel(img_files),
		%load image
		im = imread([video_path img_files{frame}]);
		if size(im,3)== 1,
			im = repmat(im, [1,1,3]);
        end
        
        tic();

		if frame > 1
			%obtain a subwindow for detection at the position from last
			%frame, and convert to Fourier domain (its size is unchanged)
			patch = get_subwindow(im, pos, window_sz);
			zf = fft2(get_features(patch, cos_window));
			
			kzf = linear_correlation(zf, model_xf);
            
			response = gather(real(ifft2(model_alphaf .* kzf)));  %equation for fast detection

            max_response=max(response(:));
			%target location is at the maximum response. we must take into
			%account the fact that, if the target doesn't move, the peak
			%will appear at the top-left corner, not at the center (this is
			%discussed in the paper). the responses wrap around cyclically.
			[vert_delta, horiz_delta] = find(response == max(response(:)), 1);
			if vert_delta > size(zf,1) / 2,  %wrap around to negative half-space of vertical axis
				vert_delta = vert_delta - size(zf,1);
			end
			if horiz_delta > size(zf,2) / 2,  %same for horizontal axis
				horiz_delta = horiz_delta - size(zf,2);
			end
			pos = pos + cell_size * [vert_delta - 1, horiz_delta - 1];
		end

		%obtain a subwindow for training at newly estimated target position
		patch = get_subwindow(im, pos, window_sz);
        
		xf = fft2(get_features(patch, cos_window));

		kf = linear_correlation(xf, xf);

		alphaf = yf ./ (kf + lambda);   %equation for fast training

		if frame == 1,  %first frame, train with a single image
			model_alphaf = alphaf;
			model_xf = xf;
        else%if max_response>0.12
			%subsequent frames, interpolate model
			model_alphaf = (1 - interp_factor) * model_alphaf + interp_factor * alphaf;
			model_xf = (1 - interp_factor) * model_xf + interp_factor * xf;
            
		end

		%save position and timing
		positions(frame,:) = pos;
		time = time + toc();

		%visualization
		if show_visualization,
			box = [pos([2,1]) - target_sz([2,1])/2, target_sz([2,1])];
			stop = update_visualization(frame, box);
			if stop, break, end  %user pressed Esc, stop early
			
			drawnow
% 			pause(0.05)  %uncomment to run slower
        end		
    end
end

