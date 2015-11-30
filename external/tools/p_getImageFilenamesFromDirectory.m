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

function images = p_getImageFilenamesFromDirectory(directory)

if nargin ~= 1
    error('wrong number of input arguments');
end
if nargout ~= 1
    error('wrong number of output arguments');
end

filenames = dir(directory);

allowed_extensions{1} = '.bmp';
allowed_extensions{2} = '.jpg';
allowed_extensions{3} = '.png';

% find all files with allowed extensions in the given directory
current_image = 1;
for i = 1:length(filenames)
    [pathstr, name, extension] = fileparts(filenames(i).name);
    for j = 1: length(allowed_extensions)
        if strcmp(allowed_extensions{j}, extension)
            images{current_image} = [directory,filesep,filenames(i).name];
            current_image = current_image + 1;
        end
    end
end


