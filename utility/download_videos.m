% DOWNLOAD_VIDEOS: this script downloads and extracts all videos to the
% path specified below.
%
% Chao Ma, 2015
% https://sites.google.com/site/chaoma99/

% Local path where the videos will be located.
% Note: if you change it here, you must also change it in the script
% RUN_TRACKER.m.
base_path = '/home/chao/Dataset/Benchmark';

% download 98 videos in the following website
url='http://cvlab.hanyang.ac.kr/tracker_benchmark/datasets.html';

html=urlread(url);

% parsing the sequence name from url txt
pat = 'seq/\w*.png';

matches = regexpi(html, pat, 'match');

videos = cell(1, length(matches));

for ii=1:length(matches)
    videos{ii}=strrep(strrep(matches{ii},'seq/',''), '.png', '');
end

if ~exist(base_path, 'dir'),  %create if it doesn't exist already
    mkdir(base_path);
end

pool=[];

if isempty(gcp)
    pool=parpool();
end

if isempty(pool),
    disp('Downloading videos one by one, this may take a while.')
    disp(' ')
    
    for k = 1:numel(videos),
        disp(['Downloading and extracting ' videos{k} '...']);
        if(~exist(fullfile(base_path, videos{k}), 'dir'))
            unzip(['http://cvlab.hanyang.ac.kr/tracker_benchmark/seq/' videos{k} '.zip'], base_path);
        end
    end
else
    %download all videos in parallel
    disp('Downloading videos in parallel, this may take a while.')
    disp(' ')
    
    parfor k = 1:numel(videos),
        if(~exist(fullfile(base_path, videos{k}), 'dir'))
            disp(['Downloading and extracting ' videos{k} '...']);
            unzip(['http://cvlab.hanyang.ac.kr/tracker_benchmark/seq/' videos{k} '.zip'], base_path);
        end
    end
    
    delete(pool);
end