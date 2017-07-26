
%% cache file
path = "../725capture_correct/";
rear = ".bmp"

pref = {"wb1_wb2_", "wb1_wr1_"};
mid = {"1_", "2_", "3_", "4_"};
rank = {"1", "2", "3"};

% if not exist, then cache image
exist img_cache var;
if ans == 0
    "read images into cache"
    img_cache = cell(2, 4, 3);
    for id = 1:2
        for i = 1:4
            for j = 1:3
                filename = pref{id} + mid{i} + rank{j} + rear;
                img_cache{id, i, j} = imread(char(path + filename));
            end
        end
    end
end


%%
n = 200; % length of sub picture
up_offset = [0, -400];
down_offset = [0, 400];
[h, w, ~] = size(img_cache{1, 1, 1});
left_up = [w - n, h - n] / 2;

sub_sample = imcrop(img_cache{1, 1, 1}, [left_up(1), left_up(2), n, n]);
feature = zeros(numel(sub_sample), 2 * 4 * 3);

avg_rgb = zeros(3, 2 * 4 * 3);
theta = zeros(2 * 4 * 3, 1);
K = zeros(3, 2 * 4 * 3);

for id = 1:2
    for i = 1:4
        for j = 1:3
            rank = id * 4 * 3 + i * 3 + j - 15; 

            targ_left_up = left_up + down_offset;
            targ_img = imcrop(img_cache{id, i, j}, [targ_left_up(1), targ_left_up(2), n, n]);
            imshow(targ_img);
            targ_img = double(targ_img);

            base_left_up = left_up + up_offset;
            base_img = imcrop(img_cache{id, i, j}, [base_left_up(1), base_left_up(2), n, n]);
            imshow(base_img);
            base_img = double(base_img);

            feature(:, rank) = targ_img(:) - base_img(:);
            
            base_rgb = mean(reshape(base_img, [], 3));
            targ_rgb = mean(reshape(targ_img, [], 3));

            theta(rank) = dot(base_rgb, targ_rgb) / (norm(base_rgb) * norm(targ_rgb));

            avg_rgb(:, id * 4 * 3 + i * 3 + j - 15) = base_rgb(:);
        end
    end
end

%% analysis
br = 1 : (1 * 4 * 3);
rr = (1 * 4 * 3 + 1) : (2 * 4 * 3);

figure;
hold on;
scatter(theta(br, 1), br, 'b');
scatter(theta(rr, 1), rr, 'r');
hold off;
