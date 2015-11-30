function ground_truth = load_groundtruth(base_path, video)


%see if there's a suffix, specifying one of multiple targets, for
%example the dot and number in 'Jogging.1' or 'Jogging.2'.
if numel(video) >= 2 && video(end-1) == '.' && ~isnan(str2double(video(end))),
    suffix = video(end-1:end);  %remember the suffix
    video = video(1:end-2);  %remove it from the video name
else
    suffix = '';
end

%full path to the video's files
if base_path(end) ~= '/' && base_path(end) ~= '\',
    base_path(end+1) = '/';
end
video_path = [base_path video '/'];

%try to load ground truth from text file (Benchmark's format)
filename = [video_path 'groundtruth_rect' suffix '.txt'];
f = fopen(filename);
assert(f ~= -1, ['No initial position or ground truth to load ("' filename '").'])

%the format is [x, y, width, height]
try
    ground_truth = textscan(f, '%f,%f,%f,%f', 'ReturnOnError',false);  
catch  %#ok, try different format (no commas)
    frewind(f);
    ground_truth = textscan(f, '%f %f %f %f');  
end
ground_truth = cat(2, ground_truth{:});
fclose(f);

end
