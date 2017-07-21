%% Function: get picture pixel density
function density = get_density(pic_v)
    density = zeros(256,256,256);
    for i=1:size(pic_v,1)
        pix = pic_v(i, :) + 1;
        density(pix(1),pix(2),pix(3)) = ...
            density(pix(1),pix(2),pix(3)) + 1;
    end
end