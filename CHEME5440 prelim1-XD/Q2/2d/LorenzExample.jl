using DifferentialEquations
using Plots
gr(size=(500,500), show = true)  #use the gr backend for plotting

#Function for the lorenz equation
#u[1] = x; u[2] = y; u[3] = z
function lorenz!(du,u,p,t)
 du[1] = 10.0*(u[2]-u[1])               #dx/dt
 du[2] = u[1]*(28.0-u[3]) - u[2]        #dy/dt
 du[3] = u[1]*u[2] - (8/3)*u[3]         #dz/dt
end

u0 = [1.0;0.0;0.0]                      #intial conditions
tspan = (0.0,100.0)                     #start and end time
prob = ODEProblem(lorenz!,u0,tspan)     #Create an ODE problem for the Lorenz fxn
sol = solve(prob)                       #Solve the system

#Plot the results; the vars=(0,1) argument specifies to plot X (column 1 of sol)
#vs t (column 0 of sol)
plt1 = plot(sol,vars=(0,1), xaxis="t", yaxis = "X" )
display(plt1)

#Plot the results; the vars=(0,3) argument specifies to plot Z (column 3 of sol)
#vs t
plt2 = plot(sol,vars=(0,3), xaxis="t", yaxis = "Z")
display(plt2)

#Plot the results; the vars=(1,2,3) argument specifies to plot X vs Y vs Z
plt3 = plot(sol,vars=(1,2,3), xaxis="X", yaxis="Y", zaxis="Z")
display(plt3)

######################  EXAMPLE OF CONTROL STRUCTURES  ########################

#Additional example of loop an if control structure
#In this basic problem, create an array of numbers from 0 to 10.  Loop through
#the numbers and store all odd numbers in one array and even numbers
#in another array
nums = range(0, stop=10, step=1)   #Numbers from 0 to 10 in increments of 1
odds = zeros(0)                          #Container to hold odd numbers
evens = zeros(0)                         #Container to hold even numbers

#Loop over nums and check if the current number is even or odd
for i = 1:length(nums)
    #Check to see if remainder of the current number / 2 - 0
    if nums[i] % 2 == 0
        append!(evens, nums[i])      #Add the number to the evens container
    else
        append!(odds, nums[i])       #Add to the odds container
    end
end

#Print the contents of the two containers
println("even numbers: ", evens)
println("odd numbers: ", odds)
