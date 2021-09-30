% Amplitude modulator
% optical wave is travelled Z direction
% Input optical wave is polarized in y direction (Due to input polarizer)
% Output optical wave is polarized in x direction (Due to output polarizer/analyzer)
% modulation field is applied to Z direction

clear all;clc;

% optical wave properties
f=3*(10^14); % frequency of optical wave
c=3*(10^8); % speed of light in free space
lambda=c/f;

epsilon=1;

%% medium properties

% GaAs
n_o_GaAs=3.50;
r_41_GaAs=1.2*(10^-12);

%% device parameters
l=0.005;
d=5*(10^-6);
V_pi_GaAS=lambda/(2*(n_o_GaAs^3)*r_41_GaAs); % Half wave voltage for GaAs

% modulation electric field
V=[0 1 0 1 0 1 1 1 0 0];
t=1:10;
[t_up,V_up] = upsampling_h(V,t,50);

% Voltage controlled-phase retardation
d_pi=(V_up*pi/V_pi_GaAS); % GaAs

figure(1)
subplot(3,1,1)
plot(t_up,V_up,'b','LineWidth',2);
xlabel('time')
ylabel('Voltage [V]')
title('Electrical signal')


subplot(3,1,2)
plot(t_up,d_pi,'g','LineWidth',2);
xlabel('time')
ylabel('Phase Retardation')
title("Phase Retardation of GaAs Longitudinal Polarization modulated optical signal (\lambda ="+lambda*1e06+"\mu m)")

figure(2)
d_pi_all=0:2*pi/100:pi;
T=0.5*(1-cos(d_pi_all)); % Transmittance of the amplitude modulator
plot(d_pi_all,T)
set(gca,'XTick',0:pi/2:pi)
set(gca,'XTickLabel',{'0','\pi/2','\pi'})
xlabel('Phase retardation, \Delta\phi')
ylabel('Transmittance, T')


f1=0.05;% discreate frequency
t1=1:500;% discreate time
E_l_t=0.5*epsilon*(1-exp(1j*d_pi)).*exp(-1j*2*pi*f1*t1).*exp(1j*(2*pi/lambda)*l*(n_o_GaAs-0.5*(n_o_GaAs^3)*r_41_GaAs*V_up/l));
figure(1);
subplot(3,1,3)
plot(t_up,real(E_l_t),'LineWidth',2)
xlabel('time')
ylabel('Output Electric Field')
title("Amplitude modulated Optical signal")



