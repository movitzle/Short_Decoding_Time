function [amps_adj] = get_amp_adj(D, N, loc, xi, width, mu, type)
    switch nargin
        case 7
            option = type;
        case 6
            option = 'population';
        otherwise
            error('Not enough/ Too many input parameters');
    end
    n_subgroups = max(size(xi));
    n_sub_pop_points = N/n_subgroups;
    xi_vec = repmat(xi, 1, n_sub_pop_points);
    n_subgroups = max(size(width));
    n_sub_pop_points = N/n_subgroups;
    width_vec = repmat(width,1,n_sub_pop_points);
    q_i_temp = @(s,k) exp(1 ./ width_vec .* (cos(2*pi*xi_vec.*(loc(k,:) - s)) - 1));
    norm_const = 1;
    for j=1:D
        norm_const = norm_const.*integral(@(s) q_i_temp(s,j), 0, 1, 'ArrayValued', true);
    end
    if strcmp(option, 'population')
        amps_adj = mu/(sum(norm_const));
    elseif strcmp(option, 'individual')
        amps_adj = (mu/N)./norm_const;
    else
        error('Choice of ampitudes not correctly defined');
    end
end