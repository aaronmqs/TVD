function [Kp,Ki,Lmax,delta_max] = TVD_Data(Controller)

    % clear; clc; close all;

    %% Initial definitions

    s = tf('s');
    
    tau = 1;
    K = 1;
    G = K/(tau*s+1); % first order model
    w = 0.0001:0.0001:10; % frequency vector
    
    Lsptep = 0.001;
    L = Lsptep:Lsptep:10;
    Lmax = zeros(1,length(L));
    delta_max = zeros(1,length(L));
    Kp = zeros(1,length(L));
    Ki = zeros(1,length(L));
    lambda = (1/5)*tau;

    Ir = zeros(1,length(w));
    MaxDelay = 0;
    
%     g1 = loglog(w,Ir,'b','Linewidth',2);
%     hold on
%     g2 = loglog(w,w*MaxDelay,'r','LineWidth',1.5);
%     title(Controller + ": PI: $K_P$ = , $K_I$ = , $\delta_{max}$ = ",'Interpreter','latex')
%     xlim([w(1) w(end)])
%     ylim([10^-2 10^5])
%     legend('Ir','$\omega \cdot \delta_{max}$','Interpreter','latex')
%     xlabel("Frequency $\omega$ (rad/s)",'Interpreter','latex');
%     ylabel("Magnitude")
%     grid on
    
    for i = 1:length(L)

        if Controller == "Skogestad"
            tau_c = L(i);
            Kp(i) = (1/K)*tau/(tau_c + L(i));
            Ki(i) = Kp(i)/min(tau,4*(tau_c + L(i)));
        elseif Controller == "Sarif"
            Kp(i) = tau/(K*(lambda+L(i)));
            Ki(i) = 1/(K*(lambda+L(i)));            
        elseif Controller == "Lee"
            lambda = (1/3)*L(i);
            Kp(i) = tau/(K*(lambda+L(i)));
            Ki(i) = Kp(i)/(tau + (L(i)^2)/(2*(lambda + L(i))));                
        elseif Controller == "Chidambaram"
            Kp(i) = (1/K)*(0.5 + tau/L(i));
            Ki(i) = Kp(i)/(tau + 0.5*L(i));                
        else
            disp("Controller not found");
            return
        end

        C = Kp(i) + Ki(i)/s;

        Delay_found = 0; % the largest maximum delay wasn't found yet

        Ir = squeeze(abs(freqresp((1 + C*G)/(C*G),w))); % robustness index for a given controller C(i,j)
        Ir = Ir'; % turning Ir into a line vector    

        % Delay Margin
        Lmax(i) = maxUncertainDelay(Controller,Kp(i),Ki(i),w,Ir,0:0.01:500); % maximum constant delay        

%         g1.YData = Ir;
%         title(Controller + ": PI: $K_P$ = "+Kp(i)+", $K_I$ = "+Ki(i)+", $\delta_{max}$ = ",'Interpreter','latex')   
%         pause(0.1)
        
        SearchStep = 0.01;
        aux = 0:SearchStep:80;        
        for MaxDelay = aux

%             g2.YData = w*MaxDelay;
%             title(Controller + ": PI: $K_P$ = "+Kp(i)+", $K_I$ = "+Ki(i)+", $\delta_{max}$ = "+MaxDelay+".",'Interpreter','latex')
%             pause(0.1)

            for k = 1:length(w)
                if w(k)*MaxDelay >= Ir(k) % if the system is unstable
                    delta_max(i) = MaxDelay-SearchStep;
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