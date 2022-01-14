% Author and Developer: Dr. Taymaz Rahkar Farshi
% Battle Royale Optimization Algorithm (Continuous version)
% Neural Computing and Applications (Springer)
% www.taymaz.dev
% taymaz.farshi@gmail.com
% Istanbul 2020

function [Off1] = MyCrossOverFcn(Parent1,Parent2,Dim,Method,Eval)
%% For Case 4-6

switch Method
    case 1
        Off1 = Parent1+rand(Dim,1) .*(Parent2-Parent1);
    case 2
        Off1 = rand(Dim,1) .* (max([Parent1,Parent2],[],2) - min([Parent1,Parent2],[],2)) + min([Parent1,Parent2],[],2);
    case 3
        Beta1 = rand;
        Off1 = Beta1*Parent1 + (1-Beta1)*Parent2;
end



