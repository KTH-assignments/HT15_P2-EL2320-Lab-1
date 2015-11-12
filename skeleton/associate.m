% function [c,outlier, nu, S, H] = associate(mu_bar,sigma_bar,z_i,M,Lambda_m,Q)
% This function should perform the maximum likelihood association and outlier detection.
% Note that the bearing error lies in the interval [-pi,pi)
%           mu_bar(t)           3X1
%           sigma_bar(t)        3X3
%           Q                   2X2
%           z_i(t)              2X1
%           M                   2XN
%           Lambda_m            1X1
% Outputs:
%           c(t)                1X1
%           outlier             1X1
%           nu^i(t)             2XN
%           S^i(t)              2X2XN
%           H^i(t)              2X3XN
function [c,outlier, nu, S, H] = associate(mu_bar,sigma_bar,z_i,M,Lambda_m,Q)
% FILL IN HERE

% Declare the z_hat matrix
z_hat = [];

% Declare the Jacobian H matrix
H = [];

% Declare the innovation
nu = [];

% Declare the S matrix
S = [];

% And finally the likelihood matrix
psi = [];

% For every landmark
for j = 1:length(M)
  z_hat(:,j) = observation_model(mu_bar, M, j);
  H(:,:,j) = jacobian_observation_model(mu_bar, M, j, z_hat(:,j), 1);
  S(:,:,j) = H(:,:,j) * sigma_bar * H(:,:,j)' + Q;
  nu(:,j) = z_i - z_hat(:,j);

  % Make sure the bearing error lies in the interval [-pi,pi)
  nu(2,j) = mod(nu(2,j) + pi, 2 * pi) - pi;

  psi(j) = det(2 * pi * S(:,:,j))^(-1/2) * exp((-1/2) * nu(:,j)' * inv(S(:,:,j)) * nu(:,j));
end

[c_max c] = max(psi);

nu_max = nu(:,c);
S_max = S(:,:,c);
H_max = H(:,:,c);

% Mahalanobis distance
D_M = nu_max' * inv(S_max) * nu_max;

% Line 58 in ekf_localize.m suggests variable `outlier` is a boolean
if D_M >= Lambda_m
  outlier = true;
else
  outlier = false;
end

end
