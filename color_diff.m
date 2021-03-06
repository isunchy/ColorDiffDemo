%% read picture
close all;
n = 400; % length of sub picture

%% show crop picture
sub_pic_left = read_crop('left.jpeg', n);
% figure;
% imshow(sub_pic_left);

sub_pic_right = read_crop('right.jpeg', n);
% figure;
% imshow(sub_pic_right);

%% convert to YCbCr format
sub_pic_left_ycbcr = rgb2ycbcr(sub_pic_left);

%% draw density
sub_pic_left_v = reshape(sub_pic_left, [], 3);
sub_pic_right_v = reshape(sub_pic_right, [], 3);

% left density
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

% right density
right_density = get_density(sub_pic_right_v);
right_density_compress = get_compress_density(right_density);

% figure; hold on;
opacity = log(right_density_compress(:, 4) + 1);
opacity = opacity ./ max(opacity);
for it = 1 : size(right_density_compress, 1)
    tmp = num2cell(right_density_compress(it, :));
    [i, j, k, ~] = deal(tmp{:});
    l = opacity(it);
    scatter3(i,j,k,'filled', 'MarkerFaceColor', 'b', ...
                    'MarkerFaceAlpha',l);
end

% left diff density
left_density_diff = max((left_density - right_density),0);
left_density_diff_compress = get_compress_density(left_density_diff);

figure; hold on;
opacity = log(left_density_diff_compress(:, 4) + 1);
opacity = opacity ./ max(opacity);
for it = 1 : size(left_density_diff_compress, 1)
    tmp = num2cell(left_density_diff_compress(it, :));
    [i, j, k, ~] = deal(tmp{:});
    l = opacity(it);
    scatter3(i,j,k,'filled', 'MarkerFaceColor', 'r', ...
                    'MarkerFaceAlpha',l);
end

% right diff density
right_density_diff = max((right_density - left_density),0);
right_density_diff_compress = get_compress_density(right_density_diff);

figure; hold on;
opacity = log(right_density_diff_compress(:, 4) + 1);
opacity = opacity ./ max(opacity);
for it = 1 : size(right_density_diff_compress, 1)
    tmp = num2cell(right_density_diff_compress(it, :));
    [i, j, k, ~] = deal(tmp{:});
    l = opacity(it);
    scatter3(i,j,k,'filled', 'MarkerFaceColor', 'b', ...
                    'MarkerFaceAlpha',l);
end

