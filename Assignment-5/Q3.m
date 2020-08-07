%% Assignment 5 CH3050
%CH17B066 | Raj Jain
%Q3
clear
clc

%%
Gp=tf(2,[1,3,-10],'iodelay',1);
Gp1=tf(2,[1,3,-10]);
Gc=1;

%% Part (b)
figure
nyp=nyquistplot(Gc*Gp)
nyp.showCharacteristic('AllStabilityMargins')

%% Part(c) - Step response of part (a)
Gc1=6;
Gcl1=Gc1*Gp1/(1+Gc1*Gp1);
figure
step(Gcl1)
title('Step response of closed loop system with Gc1=6 snd ignoring delay in the process TF')

%% Part(c)- Step response of part (b)
Gc2=4.207;
Gcl2=Gc2*Gp/(1+Gc2*Gp);
figure
step(Gcl2)
title('Step response of closed loop system with Gc2=4.207')

%% Part(c) - Pade's approximation
s=tf('s');
Gp3=Gp1*(1-s/2+s^2/12)/((1+s/2+s^2/12));
Gc3=2.21;
Gcl3=Gc3*Gp3/(1+Gc3*Gp3);
figure
step(Gcl3)
title("Step response of closed loop system with Gc3=2.21 snd Pade's approximation")