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


sa=ma.*cos(2.*pi.*40.*t);         %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sa=ma*cos(2*pi*40*t) carrierfrequency:40
         
sb=mb.*cos(2.*pi.*120.*t);        %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sb=mb*cos(2*pi*120*t) carrierfrequency:120

sc=mc.*cos(2.*pi.*200.*t);        %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sc=mc*cos(2*pi*200*t) carrierfrequency:200


na_0=noise(sa,0);                     %SNR=0일때, 신호sa(t)가AWGN 채널을 통과된 신호를 na_0이라고지정
Na_0=Ts.*fftshift(fft(na_0,2048));    %na_0을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고 
                                      %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌

figure(1)
subplot(3,1,1)
plot(ft,abs(Na_0))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_A_0(f)')
title( ' s_A(f), SNR=0 ')
grid on

na_20=noise(sa,20);                  %SNR=20일때, 신호sa(t)가AWGN 채널을 통과된 신호를 na_20이라고지정
Na_20=Ts.*fftshift(fft(na_20,2048)); %na_20을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고 
                                     %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
figure(1)
subplot(3,1,2)
plot(ft,abs(Na_20))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_A_2_0(f))')
title( ' s_A(f), SNR=20 ')
grid on

na_30=noise(sa,30);                   %SNR=30일때, 신호sa(t)가AWGN 채널을 통과된 신호를 na_30이라고지정
Na_30=Ts.*fftshift(fft(na_30,2048));  %na_30을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고 
                                      %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
figure(1)
subplot(3,1,3)
plot(ft,abs(Na_30))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_A_3_0(f)')
title( ' s_A(f), SNR=30 ')
grid on

 
nb_0=noise(sb,0);                     %SNR=0일때, 신호sb(t)가AWGN 채널을 통과된 신호를 nb_0이라고지정
Nb_0=Ts.*fftshift(fft(nb_0,2048));    %nb_0을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고  
                                      %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
figure(2)
subplot(3,1,1)
plot(ft,abs(Nb_0))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_B_0(f)')
title( ' s_B(f), SNR=0 ')
grid on

nb_20=noise(sb,20);                  %SNR=20일때, 신호sb(t)가AWGN 채널을 통과된 신호를 nb_20이라고지정
Nb_20=Ts.*fftshift(fft(nb_20,2048)); %nb_20을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고  
                                     %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
figure(2)
subplot(3,1,2)
plot(ft,abs(Nb_20))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_B_2_0(f)')
title( ' s_B(f), SNR=20 ')
grid on

nb_30=noise(sb,30);                  %SNR=30일때, 신호sb(t)가AWGN 채널을 통과된 신호를 nb_30이라고지정
Nb_30=Ts.*fftshift(fft(nb_30,2048)); %nb_30을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고  
                                     %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
figure(2)
subplot(3,1,3)
plot(ft,abs(Nb_30))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_B_3_0(f)')
title( ' s_B(f), SNR=30 ')
grid on



nc_0=noise(sc,0);                    %SNR=0일때, 신호sc(t)가AWGN 채널을 통과된 신호를 nc_0이라고지정
Nc_0=Ts.*fftshift(fft(nc_0,2048));   %nc_0을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고  
                                     %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌

figure(3)
subplot(3,1,1)
plot(ft,abs(Nc_0))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_C_0(f)')
title( ' s_C(f), SNR=0 ')
grid on

nc_20=noise(sc,20);                  %SNR=20일때, 신호sc(t)가AWGN 채널을 통과된 신호를 nc_20이라고지정
Nc_20=Ts.*fftshift(fft(nc_20,2048)); %nc_20을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고  
                                     %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌


figure(3)
subplot(3,1,2)
plot(ft,abs(Nc_20))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_C_2_0(f)')
title( ' s_C(f), SNR=20 ')
grid on


nc_30=noise(sc,30);                  %SNR=30일때, 신호sc(t)가AWGN 채널을 통과된 신호를 nc_30이라고지정
Nc_30=Ts.*fftshift(fft(nc_30,2048)); %nc_30을 주파수축으로 나타내기 위해 푸리에변화(fft)를 하고  
                                     %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌



figure(3)
subplot(3,1,3)
plot(ft,abs(Nc_30))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_C_3_0(f)')
title( ' s_C(f), SNR=30 ')
grid on

 
