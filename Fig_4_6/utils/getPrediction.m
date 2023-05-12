function [predictions] = getPrediction(amps,width,N,L,D,c,lambda0)
    % see Equation S.35 in Supp. Mat. Note that C_star can be skipped (only changing the fitted regressor).
    C_star = integral(@(phi) sin(phi).*exp(1/width*sin(phi)),-pi,pi);
    predictions = zeros(1,length(c));
    for i=1:length(c)
        if lambda0 == 1
            if c(i)==1
                lambda = 1;
            else
                lambda = (lambda0*c(i).^(0:(L-1)));
            end
        else
            lambda = (lambda0*c(i).^(0:(L-1)));
        end
        xi = 1./lambda;
        % Eq 8 in main text. Note the mean across all amplitudes in the
        % populations sharing lambda1 and D
        predictions(i) = 1/mean(amps,'all')*1/(2*pi^2)*width/N*exp(D/width)/besseli(0,1/width)^(D-1)/besseli(1,1/width)^3*C_star^2*mean(xi.^3)^2/mean(xi.^2)^3;
    end
end