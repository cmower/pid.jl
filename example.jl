include("pid.jl")

# global process_variable

pid = PIDControl.pid(4., 0.01, 0.1)

set_point::Float64 = 1.0
process_variable::Float64 = 0.2
time_step::Float64 = 0.1

n_steps::Int64 = 20

println("x(0) = ", process_variable)

for i in 1:n_steps
    global process_variable
    process_variable = PIDControl.next(pid, set_point, process_variable, time_step)
    println("x(", i, ") = ", process_variable)
end
