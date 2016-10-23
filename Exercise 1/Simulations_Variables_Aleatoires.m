close all;              
p = [1/5,1/2,1/4,1/20];
n = 10;
x = sim_va(p,n);
hist(x);  % Histogram

function [x] = sim_va(p,n)      % function to simulate
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
