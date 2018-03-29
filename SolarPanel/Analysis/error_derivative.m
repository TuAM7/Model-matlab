
errfun(8.51,0.23,0.36)

function err = errfun(volt,amp,Isc)
    syms I m U;

    Ur=0.0259;          % Thermal voltage [V]
    Is=1*10^(-8);       % Reverse saturation current [A]
    N=16;               % Amount of solar cells

    eqn = I == Isc - Is*(exp(U/(m*Ur*N))-1)
    eqn = solve(eqn,m)

    du = diff(eqn,U)
    di = diff(eqn,I)

    Verr = (volt.*0.005 + 0.01);
    Ierr = (amp.*0.015 + 0.0001);

    U = volt;
    I = amp;
    eval(eqn)

    err = Verr.*eval(du) + Ierr.*eval(di)
end
