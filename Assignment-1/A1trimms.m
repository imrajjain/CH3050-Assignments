x0 = [0;0]
y0 = [0;0]
u0 = [80;100]
[X,U,Y] = trim('A1trim', x0, u0)

[A,B,C,D] = linmod('A1trim',X,u0)