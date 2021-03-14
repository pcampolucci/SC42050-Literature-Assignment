% Function to generate a multi-step custom membership function
% using 8 parameters for the input argument x
function out = custmf2(x,params)

for i = 1:length(x)
    y(i) = 1 - 1/(1+exp((x(i)+params(1))/params(2))) - 1/(1+exp(-(x(i)-params(1))/params(2)));
end

out = y'; % Scale the output to lie between 0 and 1.

end

