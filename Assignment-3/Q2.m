Gs=tf([10,-40],[1,7,10]);
Gs.iodelay=3

%%
bode(Gs)

%%
step(Gs)

%%
impulse(Gs)

%%
t=[0:0.05:50]';
u=2*sin(4.*t)+cos(0.1.*t);
