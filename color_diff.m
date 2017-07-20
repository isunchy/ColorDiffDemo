%% read picture
close all;
pic_left = imread('left.jpeg'); % small flower red
pic_right = imread('right.jpeg'); % large flower blue
height = size(pic_right,1);
width = size(pic_right,2);
n = 400; % length of sub picture
center = [height/2,width/2]; % center of sub picture
left_top = [center(1)-n/2, center(2)-n/2];

%% show crop picture
sub_pic_left = pic_left(left_top(1):left_top(1)+n-1, ...
    left_top(2):left_top(2)+n-1, :);
% figure;
% imshow(sub_pic_left);

sub_pic_right = pic_right(left_top(1):left_top(1)+n-1, ...
    left_top(2):left_top(2)+n-1, :);
% figure;
% imshow(sub_pic_right);

%% draw density
sub_pic_left_v = reshape(sub_pic_left, [], 3);
sub_pic_right_v = reshape(sub_pic_right, [], 3);

left_density = get_density(sub_pic_left_v);
left_density_compress = get_compress_density(left_density);

figure; hold on;
opacity = log(left_density_compress(:, 4) + 1);
opacity = opacity ./ max(opacity);
for it = 1 : size(left_density_compress, 1)
    tmp = num2cell(left_density_compress(it, :));
    [i, j, k, ~] = deal(tmp{:});
    l = opacity(it);
    scatter3(i,j,k,'filled', 'MarkerFaceColor', 'r', ...
                    'MarkerFaceAlpha',l);
end

%% Function: get picture pixel density
function density = get_density(pic_v)
    density = zeros(256,256,256);
    for i=1:size(pic_v,1)
        density(pic_v(i,1),pic_v(i,2),pic_v(i,3)) = ...
            density(pic_v(i,1),pic_v(i,2),pic_v(i,3)) + 1;
    end
end

%% Function: get compress density
function density_compress = get_compress_density(density)
    density_compress = zeros(nnz(density), 4);
    count = 1;
    for i=1:256
        for j=1:256
            for k=1:256
                if density(i,j,k)~=0
                    density_compress(count,:) = [i,j,k,density(i,j,k)];
                    count =count + 1;
                end
            end
        end
    end
end
