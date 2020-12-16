function Show(XMinMax,X,Eval,pt,t,rec,flag)

Mode = 0; % Countour = 0; Surface = 1;
[x1, x2] = meshgrid(XMinMax(1,1): 0.1:XMinMax(1,2),XMinMax(2,1): 0.1:XMinMax(2,2));


[sx, sy] = size(x1);
meshX(1, :) = reshape(x1, 1, (sx*sy));

[sx, sy] = size(x2);
meshX(2, :) = reshape(x2, 1, (sx*sy));

fx = Eval(meshX)*(1);
fx = reshape(fx, sx, sy);

if Mode
    surf(x1,x2,fx);
    view(0, 90);
else
    contourf(x1,x2,fx,15);
end

% title(['itaration ' num2str(LionsWorld.Run.LC) '/' num2str(LionsWorld.Run.MaxLC)]);
% xlabel('x1');
% ylabel(t);
% zlabel('fx');
hold on;
plot(X(1,:),X(2,:),'w+','MarkerSize', 8, 'LineWidth', 3);
%         hold on
        plot(flag.xy(1,:),flag.xy(2,:),'*b','LineWidth',2);
%         hold off
    rectangle('Position',[rec(1) rec(2)  rec(3) rec(4)]);
    xlabel(strcat('Itaration',num2str(t)),'FontSize',14,'FontWeight','bold');
hold off
if pt>0
    pause(pt);
else
    pause;
end

end

