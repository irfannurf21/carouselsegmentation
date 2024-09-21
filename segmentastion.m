[fileName, filePath] = uigetfile({'*.jpg;*.png;*.bmp','Image Files (*.jpg, *.png, *.bmp)'}, 'Pilih File Gambar');
if isequal(fileName, 0)
    disp('File selection canceled.');
    return;
end

img = imread(fullfile(filePath, fileName));

[imgHeight, imgWidth, ~] = size(img);

desiredAspectRatio = 4/5; % desired your ratio

numSegments = floor(imgWidth / (desiredAspectRatio * imgHeight));

segmentWidth = floor(imgWidth / numSegments);
segmentHeight = floor(segmentWidth / desiredAspectRatio);

if segmentHeight > imgHeight
    segmentHeight = imgHeight;
end

if segmentWidth < 100  
    disp('Segmentation too small.');
    return;
end

outputFolder = fullfile(filePath, 'export');
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end
    
for i = 1:numSegments
    xStart = (i-1) * segmentWidth + 1;
    xEnd = min(i * segmentWidth, imgWidth); 
    
    croppedImg = img(1:segmentHeight, xStart:xEnd, :);
    
    filename = sprintf('part_%d.jpg', i);
    imwrite(croppedImg, fullfile(outputFolder, filename));
    
    figure, imshow(croppedImg); % show figure
    
end


