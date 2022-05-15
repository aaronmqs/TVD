clear; clc; close all;

%%

% Initial definitions

s = tf('s');

G = 1/(s+1); % first order model

tic

% Data obtained from Skogestad Tuning Rule
[Kc_s,Ki_s,Ti_s,DM_const,DM_var] = PI_Skogestad;

Kc = 0.05:0.1:10;
Ki = 0.05:0.1:3;
Ti = zeros(1,length(Ki));

L = zeros(length(Kc),length(Ki));
alfa = L;

for i = 1:length(Kc)
    for j = 1:length(Ki)
        disp(100*i/length(Kc))
        
        Ti(j) = Kc(i)/Ki(j);
        %C = Kc(i)*(1 + 1/(Ti(j)*s));
        C = Kc(i) + Ki(j)/s;
        
        % Delay Margin
        L(i,j) = allmargin(C*G).DelayMargin;
        
        % Maximum allowable amplitude for sawtooth delay
        for MaxDelay = 0.1:0.1:200
            if MaxDelay == max(MaxDelay)
                flag_teste = 1;
            end
            H = c2d(C*G,MaxDelay,'zoh');

            if isstable(feedback(H,1)) == 1
                continue
            else
                H_est = c2d(C*G,MaxDelay-0.1,'zoh');
                alfa(i,j) = MaxDelay;
                break
            end
        end 

    end
end

%%

% Graphics

l = surf(Ki,Kc,L); % delay margin
l.FaceColor = '#99ff99';
hold on;
a = surf(Ki,Kc,alfa); % Maximum allowable amplitude for sawtooth delay
a.FaceColor = '#cc99ff';
hold on
plot3(Ki_s,Kc_s,DM_var,'LineWidth',3) % Maximum allowable amplitude for sawtooth delay (Skogestad Tuning Rule)
xlabel('Ki: integral');
ylabel('Kp: proportional');
zlabel('Maximum Time-Delay');
legend('Constant Time-Delay','Sawtooh','Sawtooth - Skogestad')
%title('Comparative Analysis')
axis([0 3 0 2])

figure

a = surf(Ki,Kc,alfa); % Maximum allowable amplitude for sawtooth delay
a.FaceColor = '#cc99ff';
hold on
plot3(Ki_s,Kc_s,DM_var,'LineWidth',3) % Maximum allowable amplitude for sawtooth delay (Skogestad Tuning Rule)
xlabel('Ki: integral');
ylabel('Kc: proportional');
zlabel('Maximum Sawtooth Value');
legend('Sawtooth Delay','Sawtooth Delay - Skogestad')
axis([0 3 0 2])

figure

% Comparative figure
l = surf(Ki,Kc,L); % delay margin
l.FaceColor = '#99ff99';
hold on
plot3(Ki_s,Kc_s,DM_const,'LineWidth',4) % Delay Margin (Skogestad Tuning Rule)
xlabel('Ki: integral');
ylabel('Kp: proportional');
zlabel('Delay Margin');
legend('Cosntant Time-Delay','Cosntant Time-Delay - Skogestad')
axis([0 3 0 2])

toc