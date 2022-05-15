function [Kc,Ki,Ti,DM_const,DM_var] = PI_Skogestad

% clear; clc; close all;

% %  LaTeX nas figuras
% set(groot, 'defaultAxesTickLabelInterpreter','latex'); % interpretador LateX para os eixos
% set(groot, 'defaultLegendInterpreter','latex'); % interpretador LateX para a legenda
% set(groot,'defaultTextInterpreter','latex'); % interpretador de texto padrao (LateX)

%%

% Definições iniciais

s = tf('s');

G = 1/(s+1); % planta de primeira ordem

L = 0.01:0.1:8;
DM_const = zeros(1,length(L));
DM_var = zeros(1,length(L));
Kc = zeros(1,length(L));
Ki = zeros(1,length(L));
Ti = zeros(1,length(L));

for i = 1:length(L)
    
    % Projeto de acordo com Skogestad 2002
    Kc(i) = 1/(2*L(i));
    Ti(i) = min(1,8*(L(i)));
    Ki(i) = Kc(i)/Ti(i);
    %C = Kc(i)*(1 + 1/(Ti(j)*s));
    C = Kc(i) + Ki(i)/s;
    
    % Margem de atraso
    DM_const(i) = min(allmargin(C*G).DelayMargin);
    %DM_const(i) = min(allmargin(C*G*exp(-L(i)*s)).DelayMargin);
    %DM_const(i) = 100*min(allmargin(C*G*exp(-L(i)*s)).DelayMargin)/L(i);
    
    for MaxDelay = 0.1:0.1:200
        if MaxDelay == max(MaxDelay)
            flag_teste = 1; % somente para saber que nenhum dos valores tornou o sistema instável
        end
        H = c2d(C*G,MaxDelay,'zoh');

        if isstable(feedback(H,1)) == 1
            continue
        else
            %H_est = c2d(C*G,MaxDelay-0.1,'zoh');
            DM_var(i) = MaxDelay;
            %DM_var(i) = 100*MaxDelay/L(i);
            break
        end
    end 
    
end

% Gráficos

% plot(L,DM_const,'LineWidth',3)
% 
% hold on
% 
% plot(L,DM_var,'LineWidth',3)
% legend('Margem de atraso - constante','Margem de atraso - dente de serra')
% xlabel('L: atraso');
% ylabel('Margem de atraso');
% grid on;
% 
% figure
% 
% plot3(Kc,Ti,DM_const,'LineWidth',3)
% hold on
% plot3(Kc,Ti,DM_var,'LineWidth',3)
% legend('Constant Delay','Variable Delay')
% xlabel('Kc: Proportional')
% ylabel('Ti: Integral')
% zlabel('Delay Margin')
% grid on
% 
% figure
% 
% plot(Ti,DM_const,'LineWidth',3)
% hold on
% plot(Ti,DM_var,'LineWidth',3)
% legend('Margem de atraso - constante','Margem de atraso - dente de serra')
% xlabel('Ti: Integral');
% ylabel('Margem de atraso');
% grid on;
% 
% figure
% 
% plot(Kc,DM_const,'LineWidth',3)
% hold on
% plot(Ti,DM_var,'LineWidth',3)
% legend('Margem de atraso - constante','Margem de atraso - dente de serra')
% xlabel('Kc: Proporcional');
% ylabel('Margem de atraso');
% grid on;

end