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

function pascal_score = p_computePascalScoreRect(r1, r2)

if nargin ~= 2 
    error('wrong number of input arguments');
end

% compute coordinates of both recangles
c1 = [r1(1) 
      r1(2) 
      r1(1)+r1(3)
      r1(2)+r1(4)];
c2 = [r2(1) 
      r2(2) 
      r2(1)+r2(3)
      r2(2)+r2(4)];
  
% compute coordinates of intersection
ci = [max(c1(1), c2(1)) 
      max(c1(2), c2(2)) 
      min(c1(3), c2(3)) 
      min(c1(4), c2(4))];

% compute width, height and area of intersection
wi = ci(3) - ci(1);
hi = ci(4) - ci(2);
ai = wi * hi;
if wi <= 0 || hi <= 0
    ai = 0;
end

% compute area of union
au = r1(3) * r1(4) + r2(3) * r2(4) - ai;

pascal_score = ai / au;