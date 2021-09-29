% transverse phase modulator
% optical wave is travelled X direction
% optical wave is polarized in Z direction
% modulation field is applied to Z direction

clear all;clc;close all;

% optical wave properties
f=3*(10^14); % frequency of optical wave
c=3*(10^8); % speed of light in free space

epsilon=1;

% medium properties
n_e=2.159;n_o=2.238;
r_33=30.8*(10^-12);r_13=8.6*(10^-12);

% device parameters
l=0.005;
d=5*(10^-6);
phi_pk=pi; % phase modulation depth

V_pk=(phi_pk*2*c*d)/(2*pi*f*(n_e^3)*r_33*l); 
V_pk_Y=(phi_pk*2*c*d)/(2*pi*f*(n_o^3)*r_13*l);
fprintf("Peak voltage for Z-polarized : %f V \n",V_pk)
fprintf("Peak voltage for Y-polarized : %f V \n",V_pk_Y)

V=[0 1 0 1 0 1 1 1 0 0];
t=1:10;

[t_up,V_up] = upsampling_h(V,t,50);
t1=1:length(t_up); % discreate time
f1=0.01; % discreate frequency f/fs

E_l_t=epsilon*exp(1j*2*pi*f*n_e*l/c)*exp(-1j*(2*pi*f1*t1+phi_pk*V_up));
E_l_t_Y=epsilon*exp(1j*2*pi*f*n_o*l/c)*exp(-1j*(2*pi*f1*t1+phi_pk*V_up));

figure(1)
subplot(2,1,1)
plot(t_up,real(V_up*V_pk),'b','LineWidth',2);
hold on;
plot(t_up,real(V_up*V_pk_Y),'r');
xlabel('time')
ylabel('Voltage [V]')
title('Electrical signal')
legend('Z-Polarized','Y-Polarized')

subplot(2,1,2)
plot(t_up,real(E_l_t),'b--','LineWidth',2);
hold on;
plot(t_up,real(E_l_t_Y),'r');
xlabel('time')
ylabel('Amplitude')
title('Transverse Phase modulated optical signal (\phi_{pk} = \pi)')
legend('Z-Polarized','Y-Polarized');

