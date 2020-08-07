%%
%Transfer funcn
Gs=zpk(-0.5,[-1/20,-1/10,-1/5,-1],1/(10*20*5));
Gs.iodelay=3;
Gain=0.5;

%%
%Least squares apprxn-SOPTD: Parameter estimatiom
[ystep,tk]=step(Gs,0:0.1:200);
plot(tk,ystep)
D=3;
options=optimoptions(@lsqcurvefit,'MaxFunctionEvaluations',500);
mpar=lsqcurvefit(@(mpar,tdata) modpred(mpar,tdata,D),[0.5,5,10]',tk(31:end),ystep(31:end),[],[],options);

%%
%SOPTD - Least Squares
LS_SOPTD=tf(mpar(1),conv([mpar(2),1],[mpar(3),1]),'iodelay',D);
figure
step(Gs,LS_SOPTD)
figure
bode(Gs,LS_SOPTD)

%%
%Function
function yhat=modpred(mpar,tdata,D)
Kp=mpar(1);
Tau1=mpar(2);
Tau2=mpar(3);

B=Tau1^2/(Tau2-Tau1);
C=Tau2^2/(Tau1-Tau2);

yhat=Kp*(1+B/Tau1*exp(-(tdata-D)./Tau1)+C/Tau2*exp(-(tdata-D)./Tau2));
end




