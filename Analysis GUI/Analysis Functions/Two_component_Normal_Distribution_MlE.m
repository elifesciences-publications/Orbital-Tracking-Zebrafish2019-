function [Mean1, Mean2, Var1, Var2,p] = Two_component_Normal_Distribution_MlE(Velocity_Data)
%Maximum likelyhood estimation for two component normal distribution.
% This function calculates the Estimators and Confidence Intervals for ...
% the two maxima and width

Velocity_Data=Velocity_Data(Velocity_Data<1);
Velocity_Data=Velocity_Data(Velocity_Data>0.1);

% Two component normal distribution
pdf_normmixture = @(x,p,mu1,mu2,sigma1,sigma2) ...
p*normpdf(x,mu1,sigma1) + (1-p)*normpdf(x,mu2,sigma2);

% Mle options
options = statset('MaxIter',10000, 'MaxFunEvals',10000);

%Bounds
lb = [0 0 0 0.01 0.01];
ub = [1 1.25 1.25 1 1];

% Start Parameters
pStart = .5;
muStart = 0.5; quantile(Velocity_Data,[.25 .75]);
sigmaStart = 0.05;%sqrt(var(Velocity_Data) - .25*diff(muStart).^2);
start = [pStart muStart muStart sigmaStart sigmaStart];

%Perform MLE
[Ests] = mle(Velocity_Data, 'pdf',pdf_normmixture, 'start',start, ...
'lower',lb, 'upper',ub, 'options',options);
p=Ests(1);


if Ests(2) > Ests(3)
    Mean1=Ests(2);
    Mean2=Ests(3);
    Var1=Ests(4);
    Var2=Ests(5);
    p=1-p;
else
    Mean1=Ests(3);
    Mean2=Ests(2);
    Var1=Ests(5);
    Var2=Ests(4);
end

end

