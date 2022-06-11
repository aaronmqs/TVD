clear; clc; close all;

path_ = "C:\Users\aaron\OneDrive\Área de Trabalho\Backup do Drive\2022.1\GPAR\TVD\Codes\Small Gain Condition\Data\";

[Kp,Ki,Lmax,delta_max] = TVD_Stability(10,30);
writematrix(Kp,path_ + "Kp")
writematrix(Ki,path_ + "Ki")
writematrix(Lmax,path_ + "Lmax")
writematrix(delta_max,path_ + "delta_max")

close all

[Kp_Skgstd,Ki_Skgstd,Lmax_Skgstd,delta_max_Skgstd] = TVD_Data("Skogestad");
writematrix(Kp_Skgstd,path_ + "Kp_Skgstd")
writematrix(Ki_Skgstd,path_ + "Ki_Skgstd")
writematrix(Lmax_Skgstd,path_ + "Lmax_Skgstd")
writematrix(delta_max_Skgstd,path_ + "delta_max_Skgstd")

close all

[Kp_sarif,Ki_sarif,Lmax_sarif,delta_max_sarif] = TVD_Data("Sarif");
writematrix(Kp_sarif,path_ + "Kp_sarif")
writematrix(Ki_sarif,path_ + "Ki_sarif")
writematrix(Lmax_sarif,path_ + "Lmax_sarif")
writematrix(delta_max_sarif,path_ + "delta_max_sarif")

close all

[Kp_Lee,Ki_Lee,Lmax_Lee,delta_max_Lee] = TVD_Data("Lee");
writematrix(Kp_Lee,path_ + "Kp_Lee")
writematrix(Ki_Lee,path_ + "Ki_Lee")
writematrix(Lmax_Lee,path_ + "Lmax_Lee")
writematrix(delta_max_Lee,path_ + "delta_max_Lee")

close all

[Kp_Chidambaram,Ki_Chidambaram,Lmax_Chidambaram,delta_max_Chidambaram] = TVD_Data("Chidambaram");
writematrix(Kp_Chidambaram,path_ + "Kp_Chidambaram")
writematrix(Ki_Chidambaram,path_ + "Ki_Chidambaram")
writematrix(Lmax_Chidambaram,path_ + "Lmax_Chidambaram")
writematrix(delta_max_Chidambaram,path_ + "delta_max_Chidambaram")