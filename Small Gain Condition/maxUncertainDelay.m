function Lmax = maxUncertainDelay(Controller,Kp,Ki,w,Ir,L)

%     figure(2)
%     g1 = loglog(w,Ir,'b','Linewidth',2);
%     hold on
%     g2 = loglog(w,w*0,'r','LineWidth',1.5);
%     title(Controller + ": $K_P$ = , $K_I$ = , $\L_{max}$ = ",'Interpreter','latex')
%     xlim([w(1) w(end)])
%     ylim([10^-2 10^5])
%     legend('Ir','$\delta P$','Interpreter','latex')
%     xlabel("Frequency $\omega$ (rad/s)",'Interpreter','latex');
%     ylabel("Magnitude")
%     grid on
%     pause(0.1)

    Delay_found = 0;

    for MaxDelay = L

        if MaxDelay == max(L)
            disp("Maximum delay achieved")
            disp(Controller)
            disp(Kp)
            disp(Ki)
            return
        end

        deltaP = 2*abs(sin(w*MaxDelay/2));
        
        
%         g2.YData = deltaP;
%         title("$K_P$ = "+Kp+", $K_I$ = "+Ki+", $L_{max}$ = "+MaxDelay+".",'Interpreter','latex')
%         pause(0.1)

        for k = 1:length(w)
            if deltaP(k) >= Ir(k) % if the system is unstable
                Lmax = MaxDelay-0.01;
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

%     close 2

end