clear
clc;
close all;

% G(s) = 1/(s*(s+1))
% dx/dt(t) = A0x(t) + Bu(t-h)
% u(t) = Kx(t)
% G(s) = 2/(s^2 + 3s + 2)

%% Model parameters
s = tf('s');
G = 1/(s*(s+1));
r = 0.2268;
% [num,den] = tfdata(G,'v');
% [A,B,C,D] = tf2ss(num,den);
A0 = [-1 1;0 0];
B = [0;1];
C = [1 0];
K = acker(A0,B,[-3 -2]);
A1 = -B*K;

%% Simple delay-dependent stability (based on Razumikhin Theorem)
%
% System
%
% dx(t)/dt = A0*x(t) + A1*u(t-r), u(t) = K*x(t) - State Feedback Control
% dx(t)/dt = A0*x(t) + A1*K*x(t-r)
% dx(t)/dt = (A0 + A1)*x(t) + Distrbances%
% Disturbances = A1*(x(t-r) - x(t))
%
% LMI problem
%
% P*(A0 + A1)+(A0 + A1)'*P + r*(R0 + R1) < 0
% [alphak*P-Rk, -P*A1*Ak; -Ak'*A1'*P, -alphak*P] < 0, k in {1,2} 
% Closed-loop: A1 <- A1*K

% Decision variables
alpha0 = sdpvar(1);
alpha1 = sdpvar(1);
P = sdpvar(size(A0,1),size(A0,1),'symmetric');
alpha0P = sdpvar(size(A0,1),size(A0,1),'symmetric');
alpha1P = sdpvar(size(A0,1),size(A0,1),'symmetric');
R0 = sdpvar(size(A0,1),size(A0,1));
R1 = sdpvar(size(A0,1),size(A0,1));


LMI1 = P >= 0;
LMI2 = P*(A0 + A1)+(A0 + A1)'*P + r*(R0 + R1) <= 0;
LMI3 = [alpha0P-R0, -P*A1*A0; -A0'*A1'*P, -alpha0P] <= 0;
LMI4 = [alpha1P-R1, -P*A1*A1; -A1'*A1'*P, -alpha1P] <= 0;
LMI5 = alpha0 >= 0;
LMI6 = alpha1 >= 0;

LMI = [LMI1,LMI2,LMI3,LMI4];

optimize(LMI)
checkset(LMI); % Infeasible if the delay margin is smaller than the delay

sys = ss(A0,B,-K,0);
bode(sys)



