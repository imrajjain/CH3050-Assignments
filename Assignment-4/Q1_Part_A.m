%%
%CH3050 - Assignment4 | CH17B066
%Transfer funcn
Gs=zpk(-0.5,[-1/20,-1/10,-1/5,-1],1/(10*20*5));
Gs.iodelay=3;

%%
%Krishna and sundaresan approxn
[P,t]=step(Gs,0:1:200);
Gain=0.5;
%required t1 at 35.3% of SS value, and t2 at 85.3% of SS value
%i.e., t1 at Output = 0.353*0.5 and t2 at Output=0.853*0.5
o1=0.353*0.5;
o2=0.853*0.5;
tol=0.0001;
N=size(P,1);
for count=1:N
    if abs(P(count)-o1)<tol
        t1=count-1;
    end
    if abs(P(count)-o2)<tol
        t2=count-1;
    end
end

Delay=1.3*t1-0.29*t2;
Tau=0.67*(t2-t1);

FOPTD_Krishna=tf(Gain,[Tau,1],'iodelay',Delay);

%%
%Plotting responses
[Krishna_FOPTD,tKris]=step(FOPTD_Krishna,0:0.5:160)
figure
bode(Gs,FOPTD_Krishna)
%END