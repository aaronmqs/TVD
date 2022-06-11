function deltaMax = maxDelay(Ir,w,Dmax,Dmin,TOL,g2,Kp,Ki)

hold on

D0 = Dmin;
D(1) = Dmax;

D(2) = 0.5*(D(1) + D0);
g2.YData = w*D(2);
title("$K_P$ = "+Kp+", $K_I$ = "+Ki+", $\delta_{max}$ = "+D(2)+".",'Interpreter','latex')
pause(0.01)

r = min(Ir - w*D(2));
if r < 0
    D(3) = D0;
elseif r > 0
    D(3) = D(1);
end

k = 2;

while abs(min(Ir - w*D(k))) > TOL || min(Ir - w*D(k)) < 0

    D(k+2) = 0.5*(D(k) + D(k+1));
    g2.YData = w*D(k+2);
    title("$K_P$ = "+Kp+", $K_I$ = "+Ki+", $\delta_{max}$ = "+D(k+2)+".",'Interpreter','latex')
    pause(0.01)

    r = min(Ir - w*D(k+2));

    if r < 0
        D(k+3) = min(D(k+1),D(k));
    elseif r > 0
        D(k+3) = max(D(k+1),D(k));
    end

    k = k+2;

end

deltaMax = D(k);


