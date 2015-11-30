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

function distance = p_computeCenterDistanceRect(r1, r2)

if nargin ~= 2 
    error('wrong number of input arguments');
end

% compute center coordinates of both recangles
c1 = [r1(1) + r1(3)/2
      r1(2) + r1(4)/2];
c2 = [r2(1) + r2(3)/2
      r2(2) + r2(4)/2];
    
% compute distance
v = c1 - c2;
distance = norm(v);