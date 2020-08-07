Gp=tf([1,4,8],[1,4,3,0]);
Gsens=tf(1,[1,10]);
%%

Kc=27.55;
KI=1
Gc=tf([27.55,KI],[1,0]);


%%
Kc=27.55;
s=tf('s');
Ls2=Gsens*Gp/(s*(1+Kc*Gsens*Gp))
rlocus(Ls2)

%%
figure
Ls1=Gsens*Gp
rlocus(Ls1)