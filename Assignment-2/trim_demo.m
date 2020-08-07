[xs,us,ys] = trim('q1_trim',[1;1],0.8,[1;1],[],1,[]) %Finding steady-state
[A,B,C,D]=linmod('q1_trim',xs,0.8) %Linearzing the model
% ss_model=ss(A,B,C,D) %Final state-space model structure
[num,den]=ss2tf(A,B,C,D) %Finding the coefficients of Numerator and Denominator of two transfer functions
Gs=tf(num(2,:),den) %Transfer function relating T and Ca,in