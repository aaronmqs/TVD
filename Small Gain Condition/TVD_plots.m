close all

%% Plots the TVD_Stability data
figure
subplot(2,2,1)
a = surf(Ki,Kp,delta_max); % Maximum allowable amplitude for time-varying delay
a.FaceColor = '#cc99ff';
title("Maximum time-varying delay")
xlabel('Ki: integral');
ylabel('Kp: proportional');
zlabel('Maximum Time-Delay');
view([1 1 1])

subplot(2,2,3)
l = surf(Ki,Kp,Lmax); % Maximum allowable amplitude for time-varying delay
l.FaceColor = '#99ff99';
title("Maximum constant delay")
xlabel('Ki: integral');
ylabel('Kp: proportional');
zlabel('Maximum Time-Delay');
view([1 1 1])

subplot(2,2,[2 4])
l = surf(Ki,Kp,Lmax); % delay margin
l.FaceColor = '#99ff99';
hold on;
a = surf(Ki,Kp,delta_max); % Maximum allowable amplitude for time-varying delay
a.FaceColor = '#cc99ff';
title("Compared analysis")
xlabel('Ki: integral');
ylabel('Kp: proportional');
zlabel('Maximum Time-Delay');
legend('Constant Delay','Varying Delay','Location','northeast')
view([1 1 1])

sgtitle("PI analysis whith TVD")

%% Constant delay analysis
figure 

l = surf(Ki,Kp,Lmax); % Maximum allowable amplitude for time-varying delay
l.FaceColor = '#99ff99';
hold on
l = surf(Ki,Kp,delta_max); % Maximum allowable amplitude for time-varying delay
l.FaceColor = '#cc99ff';
hold on
plot3(Ki_Skgstd,Kp_Skgstd,Lmax_Skgstd,'b','LineWidth',3) 
hold on
plot3(Ki_sarif,Kp_sarif,Lmax_sarif,'r','LineWidth',3) 
hold on
plot3(Ki_Lee,Kp_Lee,Lmax_Lee,'y','LineWidth',3) 
hold on
plot3(Ki_Chidambaram,Kp_Chidambaram,Lmax_Chidambaram,'g','LineWidth',3) 
axis([0 1.1 0 1])

xlabel('Ki: integral');
ylabel('Kp: proportional');
zlabel('Maximum Time-Delay');
view([1 1 1])

%% Varying delay analysis

hold on
plot3(Ki_Skgstd,Kp_Skgstd,delta_max_Skgstd,'b','LineWidth',3) 
hold on
plot3(Ki_sarif,Kp_sarif,delta_max_sarif,'r','LineWidth',3) 
hold on
plot3(Ki_Lee,Kp_Lee,delta_max_Lee,'y','LineWidth',3) 
hold on
plot3(Ki_Chidambaram,Kp_Chidambaram,delta_max_Chidambaram,'g','LineWidth',3) 
axis([0 1.1 0 1])
legend("General case","Skogestad 2003","Sarif 2020","Lee 1998","Chidambaram 2004",'Location','northeast')
xlabel('Ki: integral');
ylabel('Kp: proportional');
zlabel('Maximum Time-Delay');
view([1 1 1])

legend("Maximum Constant delay","Maximum varying delay","Skogestad 2003","Sarif 2020","Lee 1998","Chidambaram 2004",'Location','northeast')

%% Constant Delay X Varying Delay
figure

subplot(4,1,1)
plot(Lmax_Skgstd,delta_max_Skgstd,'b',"LineWidth",2)
legend("Skogestad","Location","northeast")
grid on

subplot(4,1,2)
plot(Lmax_sarif,delta_max_sarif,'r',"LineWidth",2)
legend("Sarif","Location","northeast")
grid on

subplot(4,1,3)
plot(Lmax_Lee,delta_max_Lee,'y',"LineWidth",2)
legend("Lee","Location","northeast")
grid on

subplot(4,1,4)
plot(Lmax_Chidambaram,delta_max_Chidambaram,'g',"LineWidth",2)
legend("Chidambaram","Location","northeast")
grid on

xlabel("Maximum constant delay")
sgtitle("Maximum time-varying delay")

%% Evolution of Maximum delays

figure 

C = 1:length(Lmax_Skgstd);

subplot(4,1,1)
plot(C,Lmax_Skgstd,C,delta_max_Skgstd,"LineWidth",2)
legend("Constant Delay","Varying Delay","Location","northeast")
grid on
ylabel("Skogestad")

subplot(4,1,2)
plot(C,Lmax_sarif,C,delta_max_sarif,"LineWidth",2)
legend("Constant Delay","Varying Delay","Location","northeast")
grid on
ylabel("Sarif")


subplot(4,1,3)
plot(C,Lmax_Lee,C,delta_max_Lee,"LineWidth",2)
legend("Constant Delay","Varying Delay","Location","northeast")
grid on
ylabel("Lee")


subplot(4,1,4)
plot(C,Lmax_Chidambaram,C,delta_max_Chidambaram,"LineWidth",2)
legend("Constant Delay","Varying Delay","Location","northeast")
grid on
ylabel("Chidambaram")
xlabel("PI Controller index")

sgtitle("Maximum delays evolution")

