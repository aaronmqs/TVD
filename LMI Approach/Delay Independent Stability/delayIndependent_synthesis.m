clear
clc;
close all;

% dx/dt(t) = A0x(t) + Bu(t-h)
% u(t) = Kx(t)
% G(s) = 2/(s^2 + 3s + 2)
% The static gain is 1, thus K = [1 0] makes the system marginally stable
% That's because the maximum magnitude of the Bode diagram is 0dB (1)
A0 = [-3 1;-2 0];
A1 = [0 2]';
C = eye(2);
D = 0;

% Stability of Time-Delay Systems - Keqin Gu, Vladimir L. Kharitonov and Jie Chen
% Same LMI for Razumikhin and Lyapunov-Krasovskii: closed loop stability
% condition
% S = alpha/P
% Y = K/P
P = sdpvar(size(A0,1),size(A0,1),'symmetric');
S = sdpvar(size(A0,1),size(A0,1),'symmetric');
Y = sdpvar(size(A1,2),size(A0,2));

LMI = [ P >= 0;
        S >= 0;
        [P*A0+A0'*P+S, A1*Y;
        Y'*A1', -S] <= 0;
    ];

optimize(LMI,S);
checkset(LMI);

P = value(P);
Y = value(Y);

K = Y*P;

sys_OL = ss(A0,A1,C,D);
sys_CL = ss(A0+A1*K,A1,C + D*K,zeros(size(D,1),size(D,2)));

bode(sys_OL)
grid on

figure

bode(sys_CL)
grid on
