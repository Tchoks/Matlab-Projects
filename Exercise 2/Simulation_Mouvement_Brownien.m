%Premiére simulation d'un mouvement brownien standard
clc;
close all;

 n = 5;
 m = 10000;
 delta_t = 1/m;
 Z = normrnd(0,1,m,n);
 [temps,W,mean_,std_dev] = sim_sbm(m,n,delta_t,Z);
 
 figure
 plot(temps,W);
 title('Graph of the standard brownian motion');
 xlabel('0 < temps < 1');
 ylabel('values of W');
 legend({'Trajectory 1','Trajectory 2','Trajectory 3','Trajectory 4','Trajectory 5'});
 
 hold on
 Szero = 100;
 sigma = 0.2;
 t = 0:delta_t:1;
 [temps,S,W] = sim_gbm(m,n,delta_t,Z,Szero,sigma);
 figure
 plot(temps,S);
 title('Graph of the geometric brownian motion');
 xlabel('0 < temps < 1');
 ylabel('values of S');
 legend({'Trajectory 1','Trajectory 2','Trajectory 3','Trajectory 4','Trajectory 5'});

function [temps,W,mean_,std_dev] = sim_sbm(m,n,delta_t,Z)    %function to simulate the standard brownian motion                                      
 %Inputs  - n is the number of simulated trajectory
 %        - m is the number of intervals of time period
 %        - delta_t is the length of one time period
 %        - z is the column vector m random varaibles i.i.d N~(0,1)
 %Outputs - temps to represent a value at time temps
 %        - W brownian motion trajectory simulated    
 
 W = zeros(m+1,n);  % Initialisation
 temps = zeros(m+1,1);
 for i=1:m
     W(i+1,:) = W(i,:) + sqrt(delta_t)*Z(i,:); % Sum by column
     temps(i+1,1) = temps(i,1) + delta_t;
 end;
 mean_ = mean(W);
 std_dev = std(W);
end

function [temps,S,W] = sim_gbm(m,n,delta_t,Z,Szero,sigma)
     %Z = normrnd(0,1,m,n);
     W = zeros(m+1,n);
     temps = zeros(m+1,1);
     S = zeros(m+1,n);
     S(1,:) = Szero * ones(1,n);
     
     for i=1:m
         W(i+1,:) = W(i,:) + sqrt(delta_t)*Z(i,:);
         temps(i+1,1) = temps(i,1) + delta_t;
         S(i+1,:) = S(i,:) + exp(sigma*W(i+1,:) - sigma^2*temps(i+1,1)/2); 
     end;

end


















