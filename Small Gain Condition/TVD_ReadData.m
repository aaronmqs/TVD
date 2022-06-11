clear; clc; close all;

path_ = "C:\Users\aaron\OneDrive\Área de Trabalho\Backup do Drive\2022.1\GPAR\TVD\Codes\Small Gain Condition\Data\";

Kp = readmatrix(path_ + "Kp");
Ki = readmatrix(path_ + "Ki");
Lmax =readmatrix(path_ + "Lmax");
delta_max = readmatrix(path_ + "delta_max");

Kp_Skgstd = readmatrix(path_ + "Kp_Skgstd");
Ki_Skgstd = readmatrix(path_ + "Ki_Skgstd");
Lmax_Skgstd = readmatrix(path_ + "Lmax_Skgstd");
delta_max_Skgstd = readmatrix(path_ + "delta_max_Skgstd");

Kp_sarif = readmatrix(path_ + "Kp_sarif");
Ki_sarif = readmatrix(path_ + "Ki_sarif");
Lmax_sarif = readmatrix(path_ + "Lmax_sarif");
delta_max_sarif = readmatrix(path_ + "delta_max_sarif");

Kp_Lee = readmatrix(path_ + "Kp_Lee");
Ki_Lee = readmatrix(path_ + "Ki_Lee");
Lmax_Lee = readmatrix(path_ + "Lmax_Lee");
delta_max_Lee = readmatrix(path_ + "delta_max_Lee");

Kp_Chidambaram = readmatrix(path_ + "Kp_Chidambaram");
Ki_Chidambaram = readmatrix(path_ + "Ki_Chidambaram");
Lmax_Chidambaram = readmatrix(path_ + "Lmax_Chidambaram");
delta_max_Chidambaram = readmatrix(path_ + "delta_max_Chidambaram");