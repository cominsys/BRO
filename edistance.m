% Author and Developer: Dr. Taymaz Rahkar Farshi
% Battle Royale Optimization Algorithm (Continuous version)
% taymaz.farshi@gmail.com
% Istanbul 2020

function [ indx ] = edistance(i,pbxy)
[U V] = size(pbxy);
for j = 1:V
    Dist(j) = sqrt(sum((pbxy(:,i) - pbxy(:,j)) .^ 2));
end
Dist(i) = inf;
[notuse_dist indx] = min(Dist);

end

