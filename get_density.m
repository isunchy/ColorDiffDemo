%% Function: get picture pixel density
function density = get_density(pic_v)
    density = zeros(256,256,256);
    for i=1:size(pic_v,1)
        density(pic_v(i,1),pic_v(i,2),pic_v(i,3)) = ...
            density(pic_v(i,1),pic_v(i,2),pic_v(i,3)) + 1;
    end
end