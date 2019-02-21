clc;
clear;
Ts=0.001;                          %샘플링주기
t=-1:Ts:1;                         % 시간축 t의 범위 지정
fs=1000;                           %샘플링 주파수
ft=-fs/2:fs/2048:fs/2-fs/2048;     %주파수축 f의 범위 

A=2; 
for i=1:length(t)                  % 시간축 t의 길이만큼 반복
if abs(t(i))<0.04                  %|t|가 0.04보다 작을때
    ma(i)=A*(1-1*abs(25*t(i)));    %ma(t)의 값을 A(1-1|25t|)로 지정.
    
else
    ma(i)=0;                       % |t|가 0.04보다 작지않을때 ma(t)의 값은 0으로 지정.
end                                %if~else구문을 끝내는 end
end                                %반복문을 끝내는 end


for i=1:length(t)                 %시간축 t의길이만큼 반복
if abs(t(i))<0.05                 %|t|가 0.05보다 작으면
    mb(i)=1-1*abs(20*t(i));       %mb(t)의 값을 1-1|20t|로 지정
else                              %|t|가 0.05보다 작지않으면
    mb(i)=0;                      %mb(t)의 값을 0으로 지정
end                               %if~else 구문을 끝내는 end
end                               %반복문을 끝내는 end


C=1;
for i=1:length(t)                 %시간축 t의 길이만큼 반복
if abs(t(i))<0.05                 %|t|가 0.05보다 작으면
    mc(i)= C;                     %mc(t)의 값을 1로지정
else                              %|t|가 0.05보다 작지않으면
    mc(i)=0;                      %mc(t)의 값을 0으로 지정
end                               %if~else 구문을 끝내는 end
end                               %반복문을 끝내는 end


Ma=Ts.*fftshift(fft(ma,2048));    %ma(t)를 주파수축으로 나타내기 위해 푸리에변환(fft)를하고
                                  %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌

Mb=Ts.*fftshift(fft(mb,2048));    %mb(t)를 주파수축으로 나타내기 위해 푸리에변환(fft)를하고
                                  %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌



Mc=Ts.*fftshift(fft(mc,2048));    %mc(t)를 주파수축으로 나타내기 위해 푸리에변환(fft)를하고
                                  %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌


                                  
                                  
sa=ma.*cos(2.*pi.*40.*t);         %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sa=ma*cos(2*pi*40*t) carrierfrequency:40

Sa=Ts.*fftshift(fft(sa,2048));    %sa(t)를 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고
                                  %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
subplot(3,1,1)                   
plot(ft,abs(Sa))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_A(f)')
title( ' s_A(f) ')
grid on

 

sb=mb.*cos(2.*pi.*120.*t);       %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sb=mb*cos(2*pi*120*t) carrierfrequency:120

Sb=Ts.*fftshift(fft(sb,2048));   %sb(t)를 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고
                                 %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
subplot(3,1,2)
plot(ft,abs(Sb)) 
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_B(f)')
title( ' s_B(f) ')
grid on

    
sc=mc.*cos(2.*pi.*200.*t);       %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sc=mc*cos(2*pi*200*t) carrierfrequency:200

Sc=Ts.*fftshift(fft(sc,2048));   %sb(t)를 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고 
                                 %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
subplot(3,1,3)
plot(ft,abs(Sc)) 
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_C(f)')
title( ' s_C(f) ')
grid on


