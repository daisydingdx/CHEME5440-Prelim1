% symbolic variables
syms X Z;

% given non-dimentional parameters
alpha_x=1.5;
beta_x=5.0;
zx=0.4;
nzx=2.7;
xz=1.5;
nxz=2.7;
delta_z=1.0;
n_max=1000;

% low concentration balance
Xini=0;
Zini=0;
S_l=linspace(0,1.0,n_max); %low
X_l=linspace(0,1.0,n_max);  %low

for n=1:n_max
        S=S_l(n);
        eqn1= 0==(alpha_x+beta_x*S)/(1+S+(Z/zx)^nzx)-X;
        eqn2= 0==1/(1+(X/xz)^nxz)-delta_z*Z;
        [solX, solZ] = vpasolve([eqn1,eqn2],[X,Z],[Xini Zini]); % @ss
        
        X_l(n)=double(solX);
        Xini=double(solX);
        Zini=double(solZ);
end 
%Plot
figure;
hold on
title('Q2(c)');
plot(S_l,X_l);xlabel('S');ylabel('X');

% high Concentratoin balance
Xini=5;
Zini=5;
S_h=linspace(2,0.5,n_max); % high
X_h=linspace(0,1.0,n_max); % high

for n=1:n_max
        S=S_h(n);
        eqn1= 0==(alpha_x+beta_x*S)/(1+S+(Z/zx)^nzx)-X;
        eqn2= 0==1/(1+(X/xz)^nxz)-delta_z*Z;
        [solX, solZ] = vpasolve([eqn1,eqn2],[X,Z],[Xini Zini]); % @ss
        
        X_h(n)=double(solX);
        Xini=double(solX);
        Zini=double(solZ);
end 
%Plot
figure;
hold on
title('Q2(c)');
plot(S_h,X_h);xlabel('S');ylabel('X');
