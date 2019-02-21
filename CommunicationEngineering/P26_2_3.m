clc;
clear;
Ts=0.001;                          %���ø��ֱ�
t=-1:Ts:1;                         % �ð��� t�� ���� ����
fs=1000;                           %���ø� ���ļ�
ft=-fs/2:fs/2048:fs/2-fs/2048;     %���ļ��� f�� ���� 

A=2; 
for i=1:length(t)                  % �ð��� t�� ���̸�ŭ �ݺ�
if abs(t(i))<0.04                  %|t|�� 0.04���� ������
    ma(i)=A*(1-1*abs(25*t(i)));    %ma(t)�� ���� A(1-1|25t|)�� ����.
    
else
    ma(i)=0;                       % |t|�� 0.04���� ���������� ma(t)�� ���� 0���� ����.
end                                %if~else������ ������ end
end                                %�ݺ����� ������ end


for i=1:length(t)                 %�ð��� t�Ǳ��̸�ŭ �ݺ�
if abs(t(i))<0.05                 %|t|�� 0.05���� ������
    mb(i)=1-1*abs(20*t(i));       %mb(t)�� ���� 1-1|20t|�� ����
else                              %|t|�� 0.05���� ����������
    mb(i)=0;                      %mb(t)�� ���� 0���� ����
end                               %if~else ������ ������ end
end                               %�ݺ����� ������ end


C=1;
for i=1:length(t)                 %�ð��� t�� ���̸�ŭ �ݺ�
if abs(t(i))<0.05                 %|t|�� 0.05���� ������
    mc(i)= C;                     %mc(t)�� ���� 1������
else                              %|t|�� 0.05���� ����������
    mc(i)=0;                      %mc(t)�� ���� 0���� ����
end                               %if~else ������ ������ end
end                               %�ݺ����� ������ end


sa=ma.*cos(2.*pi.*40.*t);         %DSB-SC������ ��ȣ�� ����ȣ�� �ݼ��� cos(2*pi*fc*t)�� ���̹Ƿ� �����Ƚ�ȣ sa=ma*cos(2*pi*40*t) carrierfrequency:40
         
sb=mb.*cos(2.*pi.*120.*t);        %DSB-SC������ ��ȣ�� ����ȣ�� �ݼ��� cos(2*pi*fc*t)�� ���̹Ƿ� �����Ƚ�ȣ sb=mb*cos(2*pi*120*t) carrierfrequency:120

sc=mc.*cos(2.*pi.*200.*t);        %DSB-SC������ ��ȣ�� ����ȣ�� �ݼ��� cos(2*pi*fc*t)�� ���̹Ƿ� �����Ƚ�ȣ sc=mc*cos(2*pi*200*t) carrierfrequency:200


na_0=noise(sa,0);                     %SNR=0�϶�, ��ȣsa(t)��AWGN ä���� ����� ��ȣ�� na_0�̶������
Na_0=Ts.*fftshift(fft(na_0,2048));    %na_0�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ� 
                                      %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������

figure(1)
subplot(3,1,1)
plot(ft,abs(Na_0))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_A_0(f)')
title( ' s_A(f), SNR=0 ')
grid on

na_20=noise(sa,20);                  %SNR=20�϶�, ��ȣsa(t)��AWGN ä���� ����� ��ȣ�� na_20�̶������
Na_20=Ts.*fftshift(fft(na_20,2048)); %na_20�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ� 
                                     %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������
figure(1)
subplot(3,1,2)
plot(ft,abs(Na_20))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_A_2_0(f))')
title( ' s_A(f), SNR=20 ')
grid on

na_30=noise(sa,30);                   %SNR=30�϶�, ��ȣsa(t)��AWGN ä���� ����� ��ȣ�� na_30�̶������
Na_30=Ts.*fftshift(fft(na_30,2048));  %na_30�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ� 
                                      %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������
figure(1)
subplot(3,1,3)
plot(ft,abs(Na_30))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_A_3_0(f)')
title( ' s_A(f), SNR=30 ')
grid on

 
nb_0=noise(sb,0);                     %SNR=0�϶�, ��ȣsb(t)��AWGN ä���� ����� ��ȣ�� nb_0�̶������
Nb_0=Ts.*fftshift(fft(nb_0,2048));    %nb_0�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ�  
                                      %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������
figure(2)
subplot(3,1,1)
plot(ft,abs(Nb_0))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_B_0(f)')
title( ' s_B(f), SNR=0 ')
grid on

nb_20=noise(sb,20);                  %SNR=20�϶�, ��ȣsb(t)��AWGN ä���� ����� ��ȣ�� nb_20�̶������
Nb_20=Ts.*fftshift(fft(nb_20,2048)); %nb_20�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ�  
                                     %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������
figure(2)
subplot(3,1,2)
plot(ft,abs(Nb_20))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_B_2_0(f)')
title( ' s_B(f), SNR=20 ')
grid on

nb_30=noise(sb,30);                  %SNR=30�϶�, ��ȣsb(t)��AWGN ä���� ����� ��ȣ�� nb_30�̶������
Nb_30=Ts.*fftshift(fft(nb_30,2048)); %nb_30�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ�  
                                     %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������
figure(2)
subplot(3,1,3)
plot(ft,abs(Nb_30))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_B_3_0(f)')
title( ' s_B(f), SNR=30 ')
grid on



nc_0=noise(sc,0);                    %SNR=0�϶�, ��ȣsc(t)��AWGN ä���� ����� ��ȣ�� nc_0�̶������
Nc_0=Ts.*fftshift(fft(nc_0,2048));   %nc_0�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ�  
                                     %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������

figure(3)
subplot(3,1,1)
plot(ft,abs(Nc_0))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_C_0(f)')
title( ' s_C(f), SNR=0 ')
grid on

nc_20=noise(sc,20);                  %SNR=20�϶�, ��ȣsc(t)��AWGN ä���� ����� ��ȣ�� nc_20�̶������
Nc_20=Ts.*fftshift(fft(nc_20,2048)); %nc_20�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ�  
                                     %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������


figure(3)
subplot(3,1,2)
plot(ft,abs(Nc_20))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_C_2_0(f)')
title( ' s_C(f), SNR=20 ')
grid on


nc_30=noise(sc,30);                  %SNR=30�϶�, ��ȣsc(t)��AWGN ä���� ����� ��ȣ�� nc_30�̶������
Nc_30=Ts.*fftshift(fft(nc_30,2048)); %nc_30�� ���ļ������� ��Ÿ���� ���� Ǫ������ȭ(fft)�� �ϰ�  
                                     %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������



figure(3)
subplot(3,1,3)
plot(ft,abs(Nc_30))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('s_C_3_0(f)')
title( ' s_C(f), SNR=30 ')
grid on

 
