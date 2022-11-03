function [loc] = create_locations(D,n_points,ord_freq)
    n_subgroups = max(size(ord_freq))
    loc = zeros(D,n_points); % pre-allocation
    n_sub_pop_points = n_points/n_subgroups;
    %p0 = get_loc(D,n_sub_pop_points,1);
    for i=1:n_subgroups
        %loc(:,(i-1)*n_sub_pop_points + 1 : i*n_sub_pop_points) = p0*(1/ord_freq(i));
        n_points_per_dim = round((n_sub_pop_points)^(1/D));
        end_point = 1/ord_freq(i)/n_points_per_dim*(n_points_per_dim-1);
        loc_temp = linspace(0,end_point,n_points_per_dim); % distribute population
        [loc_grid{1:D}] = ndgrid(loc_temp);
        for j=1:D
            X = reshape(loc_grid{:,j}, 1, n_sub_pop_points);
            loc(j,(i-1)*n_sub_pop_points + 1 : i*n_sub_pop_points)  = X(:);
        end
        %loc(:,(i-1)*n_sub_pop_points(1,i) + 1 : i*n_sub_pop_points(1,i)) = get_loc(D,n_sub_pop_points,1);
    end
end