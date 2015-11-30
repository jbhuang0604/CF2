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

function img = p_drawRect(img, rect, color, width, name);

if nargin < 4 && nargin > 5
    error('wrong number of input arguments');
end
if nargout ~= 1
    error('wrong number of output arguments');
end

f = figure('Visible','off'); imshow(img);
rectangle('Position',rect, 'LineWidth',width, 'EdgeColor', color);
[height, width, depth] = size(img);
xlim([1,width]);
ylim([1,height]);

if nargin == 5
    text(rect(1) + 10, rect(2) + 10, name, 'FontSize', 12, 'Color', color, 'FontWeight', 'bold');
end

F = getframe;
img = F.cdata;
close(f);