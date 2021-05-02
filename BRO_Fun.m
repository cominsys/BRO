% Author and Developer: Dr. Taymaz Rahkar Farshi
% Battle Royale Optimization Algorithm (Continuous version)
% Neural Computing and Applications (Springer)
% www.taymaz.dev
% taymaz.farshi@gmail.com
% Istanbul 2020
function [Res,cg_curve1] = BRO_Fun(N,maxiter,Func,MaxFault,CrossType,NumRun,showopen)
Res = [];
tic
cg_curve1 = zeros(1,maxiter);
for R = 1:NumRun
    disp(['Run: ' num2str(R) ' Start' ])
    Shrink = ceil(log10(maxiter));
    Step = round(maxiter/Shrink);
    %%
    soldier.xy = [];
    soldier.Fit = [];
    soldier.Fault  = zeros(1,N);
    flag.Fit = inf;
    soldier.xy = [];
    [lb,ub,Eval,Dim] = Get_Functions_details(Func);
    XMinMax = [lb',ub'];
    [U,V] = size(XMinMax);
    if Dim>U
        XMinMax = repmat(XMinMax(1,:),Dim,1);
    end
    
    ShrinkMinMax = XMinMax;
    %% Initialization
    
    xy = rand(Dim, N);
    for i=1:N
        soldier.xy(:,i) = xy(:,i).* (XMinMax(:, 2) - XMinMax(:, 1)) + XMinMax(:, 1);
        soldier.Fit(i) = Eval(soldier.xy(:,i));
    end
    
    flag.xy = [];
    flag.Fit = 0;
    
    [flag.Fit,indx] = min(soldier.Fit);
    flag.xy = soldier.xy(:,indx);
    
    %%
    STDdim = zeros(Dim,1);
    cg_curve = [];
    for iter = 1:maxiter
        cg_curve(iter) = flag.Fit;
        for i = 1:N
            Cn =  edistance( i,soldier.xy);
            xy = rand(Dim, 1);
            TempXY = xy.* (ShrinkMinMax(:, 2) - ShrinkMinMax(:, 1)) + ShrinkMinMax(:, 1);
            dam = i;
            Vic = Cn;
            if (soldier.Fit(Cn) > soldier.Fit(i))
                dam = Cn;
                Vic = i;
            end
            soldier.Fault(dam)= soldier.Fault(dam) + 1;
            soldier.Fault(Vic) = 0;
            if (soldier.Fault(dam) < MaxFault)
                soldier.xy(:,dam) = MyCrossOverFcn(soldier.xy(:,dam),flag.xy,Dim,CrossType,Eval);
            else
                soldier.xy(:,dam) = TempXY;
                soldier.Fault(dam) = 0;
            end
            for i = 1:Dim
                if soldier.xy(i,dam)<ShrinkMinMax(i,1)
                    soldier.xy(i,dam)=ShrinkMinMax(i,1);
                end
                if soldier.xy(i,Vic)<ShrinkMinMax(i,1)
                    soldier.xy(i,Vic)=ShrinkMinMax(i,1);
                    soldier.Fit(Vic) = Eval(soldier.xy(:,Vic));
                end
                if soldier.xy(i,dam)>ShrinkMinMax(i,2)
                    soldier.xy(i,dam)=ShrinkMinMax(i,2);
                end
                if soldier.xy(i,Vic)>ShrinkMinMax(i,2)
                    soldier.xy(i,Vic)=ShrinkMinMax(i,2);
                    soldier.Fit(Vic) = Eval(soldier.xy(:,Vic));
                end
                
            end
            soldier.Fit(dam) = Eval(soldier.xy(:,dam));
            if(soldier.Fit(dam)<flag.Fit)
                flag.Fit = soldier.Fit(dam);
                flag.xy = soldier.xy(:,dam);
            end
        end  
        if iter>=Step
            for i = 1:Dim
                STDdim (i) = std(soldier.xy(i,:));
                ShrinkMinMax(i,1) = flag.xy(i)-STDdim (i);
                ShrinkMinMax(i,2) = flag.xy(i)+STDdim (i) ;
            end
            %         Step
            Step = Step + round(Step/2);
        end
        for i = 1:Dim
            if ShrinkMinMax(i,1)<XMinMax(i,1)
                ShrinkMinMax(i,1) = XMinMax(i,1);
            end
            if ShrinkMinMax(i,2)>XMinMax(i,2)
                ShrinkMinMax(i,2) = XMinMax(i,2);
            end
        end
        if showopen
            r1 = ShrinkMinMax(1,1);
            r2 = ShrinkMinMax(2,1);
            r3 = ShrinkMinMax(1,2)-ShrinkMinMax(1,1);
            r4 = ShrinkMinMax(2,2)-ShrinkMinMax(2,1);
            rec = [r1 r2  r3 r4];
            pt = 0.01;   
            show(XMinMax,soldier.xy,Eval,pt,iter,rec,flag);
        end
    end    
    Res.fit(R) = flag.Fit;
    cg_curve1 = cg_curve1 + cg_curve;
end
cg_curve1 = cg_curve1/NumRun;
MeanTim = toc/NumRun;
MeanBest = mean(Res.fit);
StdBest = std(Res.fit);

Res.MeanTim =  MeanTim;
Res.MeanBest = MeanBest;
Res.StdBest = StdBest;
Res.Dim = Dim;
end
