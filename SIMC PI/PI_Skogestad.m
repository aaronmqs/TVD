function [Kc,Ki,Ti,DM_const,DM_var] = PI_Skogestad

% Uses the Skogestad IMC Tuing Rule for the PI Controller
% Skogestad, S. (2003). Simple analytic rules for model reduction and pid controller tuning. Journal of Process Control, (3), 291–309.

%% Initial definitions

s = tf('s');

G = 1/(s+1); % first order model

L = 0.01:0.1:8;
DM_const = zeros(1,length(L));
DM_var = zeros(1,length(L));
Kc = zeros(1,length(L));
Ki = zeros(1,length(L));
Ti = zeros(1,length(L));

for i = 1:length(L)
    
    % Tuned accordingly to Skogestad 2002
    Kc(i) = 1/(2*L(i));
    Ti(i) = min(1,8*(L(i)));
    Ki(i) = Kc(i)/Ti(i);
    %C = Kc(i)*(1 + 1/(Ti(j)*s));
    C = Kc(i) + Ki(i)/s;
    
    % Delay Margin
    DM_const(i) = min(allmargin(C*G).DelayMargin);
    
    for MaxDelay = 0.1:0.1:200
        if MaxDelay == max(MaxDelay)
            % flag_teste = 1; % this flag indicates if none of the values turned the system unstable
        end
        H = c2d(C*G,MaxDelay,'zoh');

        if isstable(feedback(H,1)) == 1
            continue
        else
            DM_var(i) = MaxDelay;
            break
        end
    end 
    
end

end