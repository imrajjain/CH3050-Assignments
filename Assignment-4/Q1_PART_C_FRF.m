%%
%Transfer funcn
Gs=zpk(-0.5,[-1/20,-1/10,-1/5,-1],1/(10*20*5));
Gs.iodelay=3;
Gain=0.5;
[sGS,tGS]=step(Gs,0:0.5:160);

%%
%Least squares apprxn-SOPTD: Gain & Time Constant Estimation using FRF
[AR,Phi,wout]=bode(Gs);
options=optimoptions(@lsqcurvefit,'MaxFunctionEvaluations',500);
mparnew=lsqcurvefit(@(mparnew,wnew) AmpRatio(mparnew,wnew),[1,1,1]',wout,reshape(AR,1,size(wout,1))',[],[],options);

%%
%Least squares apprxn-SOPTD: Delay Estimation using FRF
Dnew=lsqcurvefit(@(Dnew,wnew) phase(mparnew,wnew,Dnew),[1],wout,(pi/180).*reshape(Phi,1,size(wout,1))',[],[],options);

%%
%SOPTD - Least Squares
LS_SOPTDnew=tf(mparnew(1),conv([mparnew(2),1],[mparnew(3),1]),'iodelay',Dnew);
[LS_SOPTD,tLS]=step(LS_SOPTDnew,0:0.5:160);
figure
bode(Gs,LS_SOPTDnew)

%%
%Function
function AR=AmpRatio(mparnew,w)
Kpnew=mparnew(1);
Tau1new=mparnew(2);
Tau2new=mparnew(3);


AR=Kpnew./(sqrt(1+Tau1new^2*w.^2).*sqrt(1+Tau2new^2*w.^2));
end

function Ph=phase(mparnew,w,Dnew)
Kpnew=mparnew(1);
Tau1new=mparnew(2);
Tau2new=mparnew(3);

Ph=-atan(Tau1new.*w)-atan(Tau2new.*w)-Dnew.*w;

end

