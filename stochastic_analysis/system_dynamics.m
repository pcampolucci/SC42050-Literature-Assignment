function [dx1, dx2] = system_dynamics(x1,x2,u,a,b,type)
%DER1 Summary of this function goes here
%   Detailed explanation goes here
if type == 1
    dx1 = -x1 + x1^2 +x1^3 + x1^2*x2 -x1*x2^2 + x2 + x1*u;
    dx2 = - a*x1 - 6*x2 + b*u;
end
if type == 2
    dx1 = -x1 + x1^2 +x1^3 + x1^2*x2 -x1*x2^2 + x2 + x1*u;
    dx2 = - 6*x2 + b*u;
end
if type == 3
    dx1 = -x1 + x1^2 +x1^3 + x1^2*x2 -x1*x2^2 + x2 + x1*u;
    dx2 = - 0.2172*a*x1 - 6*x2 + b*u;
end
end

