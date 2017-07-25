%% read image and crop a n*n image from center  
function sub_pic = read_crop(filename, n)
    img = imread(filename); 
    [h, w, ~] = size(img);
    
    sub_pic = imcrop(img, [ (w - n)/2, (h - n)/2, n, n]);
end