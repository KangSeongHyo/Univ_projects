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
figure(1);
subplot(3,1,1);
plot(t,ma)
axis([-0.25 0.25 -1 3])

xlabel('t(sec)')
ylabel('m_A(t)')
title('m_A(t) ')
grid on


for i=1:length(t)                 %시간축 t의길이만큼 반복
if abs(t(i))<0.05                 %|t|가 0.05보다 작으면
    mb(i)=1-1*abs(20*t(i));       %mb(t)의 값을 1-1|20t|로 지정
else                              %|t|가 0.05보다 작지않으면
    mb(i)=0;                      %mb(t)의 값을 0으로 지정
end                               %if~else 구문을 끝내는 end
end                               %반복문을 끝내는 end
figure(1)
subplot(3,1,2)
plot(t,mb)
axis([-0.25 0.25 -1 3])
xlabel('t(sec)')
ylabel('m_B(t)')
title('2 - 1 m_B(t) ')

grid on

C=1;
for i=1:length(t)                 %시간축 t의 길이만큼 반복
if abs(t(i))<0.05                 %|t|가 0.05보다 작으면
    mc(i)= C;                     %mc(t)의 값을 1로지정
else                              %|t|가 0.05보다 작지않으면
    mc(i)=0;                      %mc(t)의 값을 0으로 지정
end                               %if~else 구문을 끝내는 end
end                               %반복문을 끝내는 end
figure(1)
subplot(3,1,3);
plot(t,mc)

axis([-0.25 0.25 -1 3])
xlabel('t(sec)')
ylabel('m_C(t)')
title(' m_C(t) ')

grid on


Ma=Ts.*fftshift(fft(ma,2048));  %ma(t)를 주파수축으로 나타내기 위해 푸리에변환(fft)를하고
figure(2);                      %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
subplot(3,1,1)
plot(ft,abs(Ma))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('m_A(f)')
title( ' m_A(f) ')
grid on

Mb=Ts.*fftshift(fft(mb,2048)); %mb(t)를 주파수축으로 나타내기 위해 푸리에변환(fft)를하고
figure(2);                     %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
subplot(3,1,2)
plot(ft,abs(Mb))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('m_B(f)')
title( ' m_B(f) ')
grid on



Mc=Ts.*fftshift(fft(mc,2048)); %mc(t)를 주파수축으로 나타내기 위해 푸리에변환(fft)를하고
figure(2);                     %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌
subplot(3,1,3);
plot(ft,abs(Mc))
figure(2);
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('m_C(f)')
title( ' m_C(f) ')
grid on

