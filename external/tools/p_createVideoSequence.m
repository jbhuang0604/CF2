% Copyright (c) 2009 
% Jakob Santner
% Institute for Computer Graphics and Vision (ICG)
% Graz University of Technology
% Inffeldgasse 16/II
% 8010 Graz, AUSTRIA
%
% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the 
% "Software"), to deal in the Software without restriction, including 
% without limitation the rights to use, copy, modify, merge, publish, 
% distribute, sublicense, and/or sell copies of the Software, and to 
% permit persons to whom the Software is furnished to do so, subject 
% to the following conditions:
%
% The above copyright notice and this permission notice shall be included 
% in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
% CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
% TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%
% If you use this software in scientific research, compare to our results
% and cite our papers.

function p_createVideoSequence(base_directory, sequence, video, results)

if nargin ~= 4 
    error('wrong number of input arguments');
end

% get input data
sequence_directory = [base_directory sequence];
image_files = p_getImageFilenamesFromDirectory([sequence_directory filesep 'imgs']);

num_tracks = size(results,2);
for i = 1:num_tracks
    track{i} = p_readLog([sequence_directory filesep results(i).file]);
end

num_frames = length(image_files);
for i = 1:num_tracks
    if size(track{i}, 1) ~= num_frames
        error('size of track(s) and length of sequence do not match');
    end
end

fprintf('\n');

mkdir([sequence_directory filesep 'out']);

msg = [];
if (video)
    aviobj = avifile([sequence_directory filesep 'out' filesep sequence '_results.avi'],'fps', 30);
    for frame = 1:num_frames
        img = imread(image_files{frame});        
        for i = 1:num_tracks
            rect = track{i}(frame,:);
            img = p_drawRect(img, rect, results(i).color, results(i).width, results(i).name);
        end
        aviobj = addframe(aviobj, img);  
        for i = 1:length(msg)
            fprintf('\b');
        end
        msg = sprintf('frame %d of %d (%3.1f percent)', frame, num_frames, frame/num_frames*100);        
        fprintf('%s',msg);
    end
    aviobj = close(aviobj);
else
    for frame = 1:num_frames
        img = imread(image_files{frame});
        for i = 1:num_tracks
            rect = track{i}(frame,:);
            img = p_drawRect(img, rect, results(i).color, results(i).width, results(i).name);
        end
        imwrite(img,[sequence_directory filesep 'out' filesep sequence '_results_' sprintf('%d',frame) '.jpg']);
        for i = 1:length(msg)
            fprintf('\b');
        end
        msg = sprintf('frame %d of %d (%3.1f percent)', frame, num_frames, frame/num_frames*100);        
        fprintf('%s',msg);
    end   
end
fprintf('\n');



