% function [c,outlier, nu_bar, H_bar] = batch_associate(mu_bar,sigma_bar,z,M,Lambda_m,Q)
% This function should perform the maximum likelihood association and outlier detection.
% Note that the bearing error lies in the interval [-pi,pi)
%           mu_bar(t)           3X1
%           sigma_bar(t)        3X3
%           Q                   2X2
%           z(t)                2Xn
%           M                   2XN
%           Lambda_m            1X1
% Outputs:
%           c(t)                1Xn
%           outlier             1Xn
%           nu_bar(t)           2nX1
%           H_bar(t)            2nX3
function [c,outlier, nu_bar, H_bar] = batch_associate(mu_bar,sigma_bar,z,M,Lambda_m,Q)
% FILL IN HERE

% Declare the output matrices
c = [];
outlier = [];
nu_bar = [];
H_bar = [];

for j = 1:length(z)
  [c_ret, outlier_ret, nu_ret, S_ret, H_ret] = associate(mu_bar, sigma_bar, z(:,j), M, Lambda_m, Q);

  c(j) = c_ret;
  outlier(j) = outlier_ret;

  nu_bar = [nu_bar nu_ret(:,c_ret)'];
  H_bar = [H_bar H_ret(:,:,c_ret)'];
end

nu_bar = nu_bar';
H_bar = H_bar';

end
