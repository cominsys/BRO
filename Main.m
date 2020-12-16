% Author and Developer: Dr. Taymaz Rahkar Farshi
% Battle Royale Optimization Algorithm (Continuous version)
% Neural Computing and Applications (Springer)
% www.taymaz.dev
% taymaz.farshi@gmail.com
% Istanbul 2020

clear, close all, clc
N = 200;
maxiter = 200;
MaxFault = 4;
CrossType = 1; % 1: (original Paper) 
NumRun = 1;
showopen = 0; % show only first 2 dimension of the problem space
cg_curve1 = zeros(1,maxiter);
for i = 9:9   % Select funct?ons to be evaluated
    Func = strcat('F',num2str(i)); % see Get_Functions_details
    [Res,cg_curve] = BRO_Fun(N,maxiter,Func,MaxFault,CrossType,NumRun,showopen);
    disp(Res);
end
