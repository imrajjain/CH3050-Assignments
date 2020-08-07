%%
%Transfer funcn
Gs=zpk(-0.5,[-1/20,-1/10,-1/5,-1],1/(10*20*5));
Gs.iodelay=3;
Gain=0.5;

%%
%FOPTD apprxn - Half Rule
Tau = 20+10/2;
Df=3+10/2+5+1-2;
SHR_FOPTD=tf(Gain,[Tau,1],'iodelay',Df);

%SOPTD apprxn - Half Rule
Tau1=20;
Tau2=10+5/2;
Ds=3+5/2+1-2;
SHR_SOPTD=tf(Gain,conv([Tau1,1],[Tau2,1]),'iodelay',Ds);

%Plotting
figure
step(Gs,SHR_FOPTD,SHR_SOPTD)
figure
bode(Gs,SHR_FOPTD,SHR_SOPTD)

%
[SHR_FO,tFO]=step(SHR_FOPTD,0:0.5:160);
[SHR_SO,tSO]=step(SHR_SOPTD,0:0.5:160);