%% Assignment 5 CH3050
%CH17B066 | Raj Jain
%Q2
clear
clc

%%
s=tf('s');
Gp=tf([2,2],[10,7,1],'iodelay',2);

%% PART A
Kc=1;
Gc=Kc;
Lg=series(Gc,Gp);
Gm0=8.2;
% Bode plot of Lg
hbp = bodeplot(Lg);
hbp.showCharacteristic('AllStabilityMargins')

for Kc=0:0.001:2
    [Gm,Pm,~,wcp]=margin(series(Kc,Gp));
    Gm=mag2db(Gm);
    if abs(Gm-Gm0)<10^-2
        break
    end
end
Gm
Pm

margin(series(Kc,Gp))

%% PART B
Pm0=60;
for Ki=0:0.0001:0.2
    [Gm2,Pm2,wcg2,wcp2]=margin(series(Kc*(1+Ki/s),Gp));
    if abs(Pm2-Pm0)<0.01
        break
    end
end
tau=1/Ki
Gm2=mag2db(Gm2)
Pm2
%% PART C
Gc2=Kc*(1+Ki/s);
figure
step(Gc2/(1+Gc2*Gp))
title('Gur')
yline(0.5,'LineStyle',':')
figure
Gcl2=feedback(series(Gc2,Gp),1);
step(Gcl2)
title('Closed Loop Step Response')

%% PART D
Gc2=Kc*(1+1/tau/s);
S=1/(1+Gc2*Gp);
w=linspace(0.001,1000,10000000);
[mag,phase,l]=bode(S,w);
trapz(l, log(abs(mag(:))))
