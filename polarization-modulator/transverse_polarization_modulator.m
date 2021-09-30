% Transverse polarization modulator
% optical wave is travelled X direction
% optical wave is polarized in YZ direction
% modulation field is applied to Z direction

clear all;clc;close all;

% optical wave properties
f=3*(10^14); % frequency of optical wave
c=3*(10^8); % speed of light in free space
lambda=c/f;

epsilon_Z=1;
epsilon_Y=1;

%% medium properties
% LiNO3
n_e=2.159;n_o=2.238;
r_33=30.8*(10^-12);r_13=8.6*(10^-12);

% GaAs
n_o_GaAs=3.50;
r_41_GaAs=1.2*(10^-12);

%% device parameters
l=0.005;
d=5*(10^-6);
V_pi=(lambda/((n_e^3)*r_33-(n_o^3)*r_13))*(d/l); % Half wave voltage for LiNO3
V_pi_GaAS=lambda/(2*(n_o_GaAs^3)*r_41_GaAs); % Half wave voltage for GaAs

%% bias voltage
m=l*(n_o-n_e)/lambda;
dl=l-(fix(m)*lambda/(n_o-n_e));
V_b=2*(n_e-n_o)*dl*V_pi/lambda; 
fprintf("Required bia voltage : %f V \n",V_b)



% modulation electric field
V=[0 1 0 1 0 1 1 1 0 0];
t=1:10;
[t_up,V_up] = upsampling_h(V,t,50);

% Voltage controlled-phase retardation
d_pi_1=(V_up-V_b)*pi/V_pi; %d_pi - 2*m*Pi for LiNO3
d_pi_2=(V_up*pi/V_pi_GaAS); % GaAs

figure(1)
subplot(3,1,1)
plot(t_up,V_up,'b','LineWidth',2);
xlabel('time')
ylabel('Voltage [V]')
title('Electrical signal')

subplot(3,1,2)
plot(t_up,d_pi_1,'r','LineWidth',2);
xlabel('time')
ylabel('Phase Retardation')
title("Phase Retardation of LiNO_{3} Transverse Polarization modulated optical signal (\lambda ="+lambda*1e06+"\mu m)")

subplot(3,1,3)
plot(t_up,d_pi_2,'g','LineWidth',2);

xlabel('time')
ylabel('Phase Retardation')
title("Phase Retardation of GaAs Longitudinal Polarization modulated optical signal (\lambda ="+lambda*1e06+"\mu m)")



