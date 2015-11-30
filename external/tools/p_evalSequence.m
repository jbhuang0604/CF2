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

function p_evalSequence(base_directory, sequence, runs)

if nargin ~= 3 
    error('wrong number of input arguments');
end

% set plot style
color{1} = 'b';
color{2} = 'r--';
color{3} = 'g-.';
color{4} = 'k-';
color{5} = 'm:';
linewidth = 2;
fontsize = 10;


% get input data
sequence_directory = [base_directory sequence];
groundtruth = p_readLog([sequence_directory filesep sequence '_gt.txt']);

num_frames = size(groundtruth, 1);
for i = 1 : length(runs)
    run_log{i} = p_readLog([sequence_directory filesep sequence '_' runs{i} '.txt']);
    if size(run_log{i}) ~= size(groundtruth);
        error(['size of groundtruth and run: ' runs{i} 'do not match']);
    end
end

% compute error curves
index = 1;
for frame = 1:num_frames
    r_gt = groundtruth(frame,:);
    if (sum(r_gt) > 0)
        for i = 1 : length(runs)
            r_run = run_log{i}(frame,:);
            distance_score(i, index) = p_computeCenterDistanceRect(r_gt, r_run);
            pascal_score(i, index) = p_computePascalScoreRect(r_gt, r_run);
        end 
        index = index + 1;        
    end
end

% plot distance curves
figure, hold on, 
set(gca, 'FontSize', fontsize, 'FontWeight', 'bold', 'LineWidth', linewidth)
title([sequence ': distance score']), xlabel('frame'), ylabel('center distance [pixel]') 
m_distance_score = mean(distance_score');
for i = 1 : length(runs)
    plot(distance_score(i,:), color{i}, 'LineWidth', linewidth);
    legend_labels{i} = sprintf('%s: %3.3f', runs{i}, m_distance_score(i));
end
legend(legend_labels, 'Interpreter', 'none');

% plot pascal curves
figure, hold on, 
set(gca, 'FontSize', fontsize, 'FontWeight', 'bold', 'LineWidth', linewidth)
title([sequence ': pascal score']), xlabel('frame'), ylabel('pascal score') 
m_pascal_score = mean(pascal_score' > 0.5);
for i = 1 : length(runs)
    plot(pascal_score(i,:), color{i}, 'LineWidth', linewidth);
    legend_labels{i} = sprintf('%s: %0.3f', runs{i}, m_pascal_score(i));
end
legend(legend_labels, 'Interpreter', 'none');



