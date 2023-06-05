function [f,q, q_i,grad_q_i] = create_TCs(N, loc, xi, rates, width, b)

    n_subgroups = max(size(xi));
    n_sub_pop_points = N/n_subgroups;
    xi_vec = repmat(xi, 1, n_sub_pop_points);
    
    q_i = @(s,k) exp(1 ./ width .* (cos(2.*pi.*xi_vec.*(loc(k,:) - s(k))) - 1));
    grad_q_i = @(s,k) 1./width .* 2.*pi.*xi_vec .* sin(2.*pi.*xi_vec.*(loc(k,:) - s(k))) .*exp(1 ./ width .* (cos(2.*pi.*xi_vec.*(loc(k,:) - s(k))) - 1));

    %for convenience we also define the product of q_i's as a function. 
    q = @(s) prod(exp(1 ./ width .* (cos(2*pi*xi_vec.*(loc - s)) - 1)),1);

    f = @(s) rates.*prod((exp(1 ./ width .* (cos(2*pi*xi_vec.*(loc - s)) - 1))),1) + b;
    
    
end