%%
%Generating the input signal
Bmax=0.2;
Range=[-1,1];
N=2555;
Ts=0.2;
u1=idinput(N,'prbs',[0,Bmax],Range);
uin = [(0:1:length(u1)-1)'*Ts (u1)];

%%
%I/O data generation
data=iddata(out.ydata.Data,out.udata.Data,0.2);
figure
plot(data)

%%
%Splitting into train and test data
trndata=data(1:1400);
testdata=data(1401:end);

%%
%Removing the mean/Mean shifting
[dtrain,Tr]=detrend(trndata,0);
dtest=detrend(testdata,Tr);

%%
figure
plot(dtrain)

%%
%Estimating the FIR
FIR=impulseest(dtrain,[]);
figure
impulse(FIR,'sd',2)
figure
step(FIR)

%%
%Estimating parametric model using OE
model_oe=oe(dtrain,[2,2,3]);
figure
resid(model_oe,dtrain);
figure
compare(model_oe,dtest);
present(model_oe);

%%
datastar=iddata(out.ystardata.Data,out.udata.Data,0.2);
trnstardata=data(1:1400);
teststardata=data(1401:end);
dteststar=detrend(teststardata,Tr);
figure
compare(model_oe,dteststar);
