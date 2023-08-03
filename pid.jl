module PIDControl

mutable struct PID
    Kp::Float64 # proportional gain
    Ki::Float64 # integral gain
    Kd::Float64 # derivative gain
    integral::Float64 # integral accumulated over time
    prev_error::Float64 # error from prvious time step
end

function pid(Kp::Float64, Ki::Float64, Kd::Float64)
    return PID(Kp, Ki, Kd, 0.0, 0.0)
end

function print(pid::PID)
    println("Kp=", pid.Kp)
    println("Ki=", pid.Ki)
    println("Kd=", pid.Kd)
    println("integral=", pid.integral)
    println("prev_error=", pid.prev_error)
end

function manipulated_variable(
    pid::PID,
    set_point::Float64,
    process_variable::Float64,
    time_step::Float64,
    )

    error = set_point - process_variable
    pid.integral += error * time_step
    derivative = (error - pid.prev_error) / time_step;

    P = pid.Kp * error
    I = pid.Ki * pid.integral
    D = pid.Kd * derivative

    manip_variable = P + I + D

    pid.prev_error = error

    return manip_variable

end

function next(
    pid::PID,
    set_point::Float64,
    process_variable::Float64,
    time_step::Float64,
    )
    mv = manipulated_variable(pid, set_point, process_variable, time_step)
    return process_variable + time_step * mv
end

end
