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