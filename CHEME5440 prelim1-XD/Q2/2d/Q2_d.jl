using DifferentialEquations
using Plots
gr(size=(500,500), show = true)  #use the gr backend for plotting

#Function for the lorenz equation
#u[1] = x; u[2] = y; u[3] = z
function Q2_d(du,u,p,t)

#given non-dimentional parameters
    S=0.02;   # 0.02, 10, 10^5
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
prob = ODEProblem(Q2_d,u0,tspan)     #Create an ODE problem for the Lorenz fxn
sol = solve(prob)                       #Solve the system


#plot
plt1 = plot(sol,vars=(0,1), xaxis="t", yaxis = "X" )
display(plt1)

plt2 = plot(sol,vars=(0,2), xaxis="t", yaxis = "Y")
display(plt2)

plt3 = plot(sol,vars=(0,3), xaxis="t", yaxis = "Z")
display(plt3)

plt4= plot(plt1,plt2,plt3)

savefig(plt4, "./0.02.png")
