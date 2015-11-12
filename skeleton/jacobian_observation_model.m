% function H = jacobian_observation_model(mu_bar,M,j,z,i)
% This function is the implementation of the H function
% Inputs:
%           mu_bar(t)   3X1
%           M           2XN
%           j           1X1 which M column
%           z_hat       2Xn
%           i           1X1  which z column
% Outputs:  
%           H           2X3
function H = jacobian_observation_model(mu_bar,M,j,z_hat,i)
% Fill In This Part

% H(1,1)
h11 = (mu_bar(1,1) - M(1,j)) / z_hat(1,i);

% H(1,2)
h12 = (mu_bar(2,1) - M(2,j)) / z_hat(1,i);

% H(2,1)
h21 = (M(2,j) - mu_bar(2,1)) / (z_hat(1, i)^2);

% H(2,2)
h22 = (mu_bar(1,1) - M(1,j)) / (z_hat(1, i)^2);

H = [h11 h12 0; h21 h22 -1];

end
