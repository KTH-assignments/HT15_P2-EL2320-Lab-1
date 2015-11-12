% function h = observation_model(x,M,j)
% This function is the implementation of the h function.
% The bearing should lie in the interval [-pi,pi)
% Inputs:
%           x(t)        3X1
%           M           2XN
%           j           1X1
% Outputs:  
%           h           2X1
function h = observation_model(x,M,j)
% Fill In This Part

% h(1,1)
a = sqrt( (M(1,j) - x(1,1))^2 + (M(2,j) - x(2,1))^2);

% h(2,1)
b = atan2(M(2,j) - x(2,1), M(1,j) - x(1,1)) - x(3,1);

% Make sure -pi <= b <= pi
ang = mod(b + pi, 2 * pi) - pi;

% The final observation model
h = [a; ang];
end