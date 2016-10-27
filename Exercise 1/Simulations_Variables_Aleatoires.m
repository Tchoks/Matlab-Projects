close all; 
clear all;
p = [1/5,1/2,1/4,1/20];
n = 100;
x = sim_va(p,n)
hist(x);  % Histogram

lambda = 2;
y = sim_va_inv(lambda,n);

[z,avg,std_dev,r] = sim_compound_va(p,lambda,n)
plot(z)
%hist(z)

function [x] = sim_va(p,n)      % function to simulate X
%Inputs - p is the probability vector of length k
%       - n is the number of random
%       - integers from 1,2,...,k returned
%Output - a row vector of length n with entries
%         from the set {1,2,...,k} with
%         probabilities specified by p.
  k = size(p,2);
  u = rand(1,n);    % generate uniform random variables U~Uniform(0,1);
  x = zeros(1,n);
  for i=1:k
      x = x+i*(sum(p(1:i-1))<=u & u< sum(p(1:i)));
  end;
end


% function to simulate the inverse of X , F^-1
function [y] = sim_va_inv(lambda,n)
%Inputs - lambda the parameter of the exponential distribution
%       - is the number of random
%Output  - a row of vector with n entries
  u = rand(1,n);
  y = (-1/lambda)*log(1-u);
end

%function to simulate and approximate z = y.^x
function[z,_mean,std_dev,epsilon] = sim_compound_va(p,lambda,n)
%Outputs - a row vector with n entries
%        - mean of z
%        - standard deviation of z
%        - the acceptable interval r
   z = sim_va_inv(lambda,n).^sim_va(p,n);
   _mean = mean(z); % our mean
   std_dev = std(z); % our standard deviation
   epsilon = 1.96*std_dev/sqrt(n); % our range or epsilon for calculate the confidential Interval at 95%
   CI_95 = [_mean-epsilon,_mean+epsilon] % our Confidential Interval at 95%
end





