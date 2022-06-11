function [Kp,Ki,Lmax,delta_max] = TVD_Stability(Kimax,Kpmax)

    % clear; clc; close all;

    %% Initial definitions

    s = tf('s');
    
    tau = 1;
    K = 1;
    G = K/(tau*s+1); % first order model
    w = 0.0001:0.0001:10; % frequency vector
    
    GainStep = 0.01;
    Kp = 2*GainStep:2*GainStep:Kpmax; % proportional gain
    Ki = 3*GainStep:3*GainStep:Kimax; % integral gain
    
    delta_max = zeros(length(Kp),length(Ki)); % largest maximum magnitude of the time-varying delay
    Lmax = delta_max;
    
    Ir = zeros(1,length(w));
    MaxDelay = 0;
    
%     figure(1)
%     g1 = loglog(w,Ir,'b','Linewidth',2);
%     hold on
%     g2 = loglog(w,w*MaxDelay,'r','LineWidth',1.5);
%     title("$K_P$ = , $K_I$ = , $\delta_{max}$ = ",'Interpreter','latex')
%     xlim([w(1) w(end)])
%     ylim([10^-2 10^5])
%     legend('Ir','$\omega \cdot \delta_{max}$','Interpreter','latex')
%     xlabel("Frequency $\omega$ (rad/s)",'Interpreter','latex');
%     ylabel("Magnitude")
%     grid on
    
    for i = 1:length(Kp)
        for j = 1:length(Ki)
    
            disp(100*i/length(Kp))
    
            C = Kp(i) + Ki(j)/s; % PI Controller
            Delay_found = 0; % the largest maximum delay wasn't found yet
            
            Ir = squeeze(abs(freqresp((1 + C*G)/(C*G),w))); % robustness index for a given controller C(i,j)
            Ir = Ir'; % turning Ir into a line vector

            Lmax(i,j) = maxUncertainDelay("",Kp(i),Ki(j),w,Ir,0:0.01:80); % maximum constant delay

    
%             g1.YData = Ir;
%             title("$K_P$ = "+Kp(i)+", $K_I$ = "+Ki(j)+", $\delta_{max}$ = ",'Interpreter','latex')
%             pause(0.1)
            
            % Bisection method
            % delta_max(i,j) = maxDelay(Ir,w,50,0,10^-2,g2,Kp(i),Ki(j));
    
    % Algorithm for not using the bisection method   
            SearchStep = 0.01;
            aux = 0:SearchStep:80;
            for MaxDelay = aux
    
%                 g2.YData = w*MaxDelay;
%                 title("$K_P$ = "+Kp(i)+", $K_I$ = "+Ki(j)+", $\delta_{max}$ = "+MaxDelay+".",'Interpreter','latex')
%                 pause(0.1)
    
                if MaxDelay == max(aux)
                    flag_teste = 1;
                end

                for k = 1:length(w)
                    if w(k)*MaxDelay >= Ir(k) % if the system is unstable
                        delta_max(i,j) = MaxDelay-SearchStep;
                        Delay_found = 1;
                        break 
                    else
                        continue
                    end
                end

                if Delay_found == 1
                    break
                end

            end
        end
    end

end