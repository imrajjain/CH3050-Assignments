
K=-1;
T=40;
th1=30;
th2=45;
alpha=0.4;
%%
G1=tf(K,[T,1]);
G1.iodelay=th1

G2=tf(alpha*K,[T,1]);
G2.iodelay=th1+th2

%%
Gs=G1+G2

