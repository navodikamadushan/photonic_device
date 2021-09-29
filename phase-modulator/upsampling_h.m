% upsampling the signal by holding the number

% Copyright (c) 2021 Navodika Karunasingha <navodikaefac@gmail.com>
function [t_new,signal_new] = upsampling_h(signal,t,factor)
t_max=t(length(t));
dt=t_max/(length(signal)*factor);
t_new=t(1)-1:dt:(t_max-dt);
signal_new=[];
    for ii=0:length(signal)-1
        if signal(ii+1) == 1
           for jj=1:factor
               signal_new(ii*factor+jj)=1;
           end
        else
            for jj=1:factor
               signal_new(ii*factor+jj)=0;
            end           
    end
end