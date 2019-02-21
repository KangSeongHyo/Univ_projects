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

sa=ma.*cos(2.*pi.*65.*t);         %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sa=ma*cos(2*pi*65*t) carrierfrequency:65
         
sb=mb.*cos(2.*pi.*120.*t);        %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sb=mb*cos(2*pi*120*t) carrierfrequency:120

sc=mc.*cos(2.*pi.*180.*t);        %DSB-SC변조된 신호는 원신호와 반송파 cos(2*pi*fc*t)의 곱이므로 변조된신호 sc=mc*cos(2*pi*180*t) carrierfrequency:180

kabc=sa+sb+sc;                    %송신단에서 DSB-SC변조된 신호 sa(t), sb(t), sc(t)를 동시에 전송할때 그 신호를 kabc라고 지정.

kbb=kabc.*cos(2.*pi.*120.*t);     %신호 mb(t)만 복구하기 위해 mb(t)의 반송파 cos(2*pi*120*t)를 kabc와 한번더 곱하였음.(m(t)*cos(2*pi*fc*t)^2)lpf=m(t)/2임을 이용)

Kbb=Ts.*fftshift(fft(kbb,2048));  %LowPassFilter를 거치기 위해 푸리에 변환(fft)를 하여위 신호를 주파수 영역으로 나타냄 
                                  %fft의 사이즈는 2^n으로 표현되기에 시간축 사이즈인 2001과 가까운 2048로 지정해줌


%LowPassFilter 제작
 for i=1:length(ft)              %ft의 길이만큼 반복함
if abs(ft(i))<40                 %Ideal LPF cutoff frequency=40이므로 |ft|가 40보다 작으면
    lpf(i)=2;                    %필터값을 2로 지정. (1로 지정시, 시간축으로 역변환시 mb(t)/2가 나오게 됨.)
else
    lpf(i)=0;                    %|ft|가 40보다 작지않으면 0으로 지정.
end                              %if~else구문 end
 end                             %for 반복문 end
  
Dmb=lpf.*Kbb;                    %푸리에 변환을 한 신호에 LowPassFilter를 거침

figure(1);
subplot(2,1,1)
plot(ft,abs(Dmb))
xlabel('f(Hz)')
ylabel('m_B(f)')
title('m_B(f)')
grid on

Dmbt=fs.*ifft(ifftshift(Dmb),2048);  %LowPassFilter를 거친 신호를 다시 시간축으로  나타내기 위해 역푸리에 변환(ifft)을 함.
                                     %ifft의 사이즈는 2^n으로 표현되기에 2048로 지정.

Dmbt1=Dmbt(1:2001);                  %시간축에서의 사이즈는 2001개 이므로 역푸리에변환을 한 신호의 사이즈를 2001로 다시 지정.

figure(1);
subplot(2,1,2)
plot(t,abs(Dmbt1))
xlabel('t(sec)')
ylabel('m_B(t)')
legend(' -1 < t < 1 ')

grid on

mse=zeros(1,16);                          %결과 값 누적연산을 위해 0으로 초기화된 변수를 생성
iter=10000;                               %반복 횟수에 대한 변수
snr = 0:3:45;                             %SNR 설정 : 0~45까지 간격3으로 지정   
        

%반복횟수
for n=1:iter                              %10,000번 반복을 위한 반복문
     
for i=1:length(snr)                       %SNR의 길이만큼 반복을함.
    
    sa=ma.*cos(2.*pi.*65.*t);         
    sb=mb.*cos(2.*pi.*120.*t);      
    sc=mc.*cos(2.*pi.*180.*t);     
    kabc=sa+sb+sc;
  
    kbb=kabc.*cos(2.*pi.*120.*t);
    noise_kbb=noise(kbb,snr(i));          %kbb신호에 설정한 SNR값일때 noise를 겪음  
 
Kbb=Ts.*fftshift(fft(noise_kbb,2048));    %noise를 겪은 신호를 LowPassFilter를 씌우기 위해 푸리에 변환(fft)을함
                                          %fft의 사이즈는 2^n으로 표현되기에 2048로 지정.

Dmb=lpf.*Kbb;                             %푸리에변환한 신호에 LowPassFilter를 씌워줌


Dmbt=fs.*ifft(ifftshift(Dmb),2048);       %LowPassFilter를 거친 신호를 시간축으로 표현하기위해 역푸리에변환(iff)을 함.
                                          %ifft의 사이즈는 2^n으로 표현되기에 2048로 지정.

Dmbt1=Dmbt(1:2001);                       %시간축에서의 사이즈는 2001개 이므로 역푸리에변환을 한 신호의 사이즈를 2001로 다시 지정.
  
mse2(i)=mean(abs(mb-Dmbt1).^2);           %원신호 mb(t)와 설정한 SNR값일때 noise를 겪은 신호를 비교해줌.

end                                       %SNR 반복문의 end

mse=mse+mse2;                             %반복시행할때 마다 나온 MSE를 누적해서 저장.

end                                       %i0,000번 반복문의 end

MSE=mse/iter;                             %누적해서 저장한 값을 반복횟수로 나누어 평균값을 구함

figure(2);
semilogy(snr,MSE)
xlabel('SNR')
ylabel('MSE')
title (' MSE: SNR = 0 : 3 : 45 , iteration:10,000 ')
grid on

