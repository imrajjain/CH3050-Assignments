%%
%Transfer funcn
Gs=zpk(-0.5,[-1/20,-1/10,-1/5,-1],1/(10*20*5));
Gs.iodelay=3;
Gain=0.5;

%%
%Least squares apprxn-SOPTD: Parameter estimatiom using Step Response
[ystepnew,tknew]=step(Gs,0:0.1:200);
plot(tknew,ystepnew)
D=3;
options=optimoptions(@lsqcurvefit,'MaxFunctionEvaluations',500);
mparnew=lsqcurvefit(@(mparnew,tdatanew) modpred(mparnew,tdatanew),[0.5,5,10,1]',tknew,ystepnew,[],[],options);

%%
%SOPTD - Least Squares
LS_SOPTDnew=tf(mparnew(1),conv([mparnew(2),1],[mparnew(3),1]),'iodelay',mparnew(4));
step(Gs,LS_SOPTDnew)
figure
bode(Gs,LS_SOPTDnew)

%%
%Function
function yhat=modpred(mparnew,tdatanew)
Kpnew=mparnew(1);
Tau1new=mparnew(2);
Tau2new=mparnew(3);
Dnew=mparnew(4);

B=Tau1new^2/(Tau2new-Tau1new);
C=Tau2new^2/(Tau1new-Tau2new);

yhat=Kpnew*(1+B/Tau1new*exp(-(tdatanew-Dnew)./Tau1new)+C/Tau2new*exp(-(tdatanew-Dnew)./Tau2new));
end




