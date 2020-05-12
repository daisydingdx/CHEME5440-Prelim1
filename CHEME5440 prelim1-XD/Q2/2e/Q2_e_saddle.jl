using DifferentialEquations
using Plots
gr(size=(500,500), show = true)  #use the gr backend for plotting

#Function for the lorenz equation
#u[1] = x; u[2] = y; u[3] = z
function Q2_e(du,u,p,t)

#given non-dimentional parameters
    S= 50000   #Selected S value, above saddle point
    alpha_x=0.039;
    alpha_y=4.3^(-3);
    beta_x=6.1;
    beta_y=5.7;
    delta_y=1.05;
    delta_z=1.04;
    zx=1.3*10^(-5);
    yz=0.011;
    xz=0.12;
    xy=7.9*10^(-4);
    nzx = 2.32
    nxy = 2
    nxz = 2
    nyz = 2

    du[1] =  (alpha_x+beta_x*S)/(1+S+(u[3]/zx)^nzx) - u[1]             #dx/dt
    du[2] =  (alpha_y +beta_y*S)/(1+S+(u[1]/xy)^nxy) - delta_y*u[2]       #dy/dt
    du[3] =  1/(1+(u[1]/xz)^nxz+(u[2]/yz)^nyz) - delta_z*u[3]        #dz/dt
end

u0 = [0.0;0.0;0.0]                      #intial conditions
tspan = (0.0,50.0)                     #start and end time
prob = ODEProblem(Q2_e,u0,tspan)     #Create an ODE problem for the Lorenz fxn
sol = solve(prob)                       #Solve the system

#steady state
SS_index=length(sol.t)

X_SS=sol[1,SS_index]
Y_SS=sol[2,SS_index]
Z_SS=sol[3,SS_index]

print("\n X_ss = ")
print(X_SS)
print("\n Y_ss = ")
print(Y_SS)
print("\n Z_ss = ")
print(Z_SS)

#model S
S_model=100.0
tspan=(0.0,50.0)

#cell 1
SS_1=[X_SS,Y_SS,Z_SS]
prob=ODEProblem(Q2_e,SS_1,tspan,S_model)
sol_1=solve(prob)

#cell 2
Increase=1.25
SS_2=Increase*[X_SS,Y_SS,Z_SS]
prob=ODEProblem(Q2_e,SS_2,tspan,S_model)
sol_2=solve(prob)

#cell 3
Decrease=0.75
SS_3=Decrease*[X_SS,Y_SS,Z_SS]
prob=ODEProblem(Q2_e,SS_3,tspan,S_model)
sol_3=solve(prob)

plot!(sol_1.t,sol_1[3,:],label=["Steady state"])
plot!(sol_2.t,sol_2[3,:],label=["Increase"])
plot!(sol_3.t,sol_3[3,:],label=["Decrease"])


# the oscillation is incoherent
