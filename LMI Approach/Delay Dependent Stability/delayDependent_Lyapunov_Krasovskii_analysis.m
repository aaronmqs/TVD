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
K = -acker(A0,B,[-3 -2]);
A1 = B*K;

%% Simple delay-dependent stability (using simple Lyapunov-Krasovskii functional)
%
% System
%
% dx(t)/dt = A0*x(t) + A1*u(t-r), u(t) = K*x(t) - State Feedback Control
% dx(t)/dt = A0*x(t) + A1*K*x(t-r)
%
% LMI problem

% Decision variables
P = sdpvar(size(A0,1),size(A0,1),'symmetric');
R0 = sdpvar(size(A0,1),size(A0,1),'symmetric');
R1 = sdpvar(size(A0,1),size(A0,1),'symmetric');
S0 = sdpvar(size(A0,1),size(A0,1),'symmetric');
S1 = sdpvar(size(A0,1),size(A0,1),'symmetric');

% LMIs
LMI1 = P >= 0;
LMI2 = [(1/r)*(P*(A0+A1)+(A0+A1)'*P)+S0+S1, -P*A1*A0, -P*A1^2;
        -A0'*A1'*P, -S0, 0;
        -(A1^2)'*P, 0, -S1] <= 0;

LMI = [LMI1,LMI2];

optimize(LMI);
checkset(LMI); % Infeasible if the delay margin is smaller than the delay

sys = ss(A0,B,K,0);

bode(sys)



