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
figure(1);
subplot(3,1,1);
plot(t,ma)
axis([-0.25 0.25 -1 3])

xlabel('t(sec)')
ylabel('m_A(t)')
title('m_A(t) ')
grid on


for i=1:length(t)                 %�ð��� t�Ǳ��̸�ŭ �ݺ�
if abs(t(i))<0.05                 %|t|�� 0.05���� ������
    mb(i)=1-1*abs(20*t(i));       %mb(t)�� ���� 1-1|20t|�� ����
else                              %|t|�� 0.05���� ����������
    mb(i)=0;                      %mb(t)�� ���� 0���� ����
end                               %if~else ������ ������ end
end                               %�ݺ����� ������ end
figure(1)
subplot(3,1,2)
plot(t,mb)
axis([-0.25 0.25 -1 3])
xlabel('t(sec)')
ylabel('m_B(t)')
title('2 - 1 m_B(t) ')

grid on

C=1;
for i=1:length(t)                 %�ð��� t�� ���̸�ŭ �ݺ�
if abs(t(i))<0.05                 %|t|�� 0.05���� ������
    mc(i)= C;                     %mc(t)�� ���� 1������
else                              %|t|�� 0.05���� ����������
    mc(i)=0;                      %mc(t)�� ���� 0���� ����
end                               %if~else ������ ������ end
end                               %�ݺ����� ������ end
figure(1)
subplot(3,1,3);
plot(t,mc)

axis([-0.25 0.25 -1 3])
xlabel('t(sec)')
ylabel('m_C(t)')
title(' m_C(t) ')

grid on


Ma=Ts.*fftshift(fft(ma,2048));  %ma(t)�� ���ļ������� ��Ÿ���� ���� Ǫ������ȯ(fft)���ϰ�
figure(2);                      %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������
subplot(3,1,1)
plot(ft,abs(Ma))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('m_A(f)')
title( ' m_A(f) ')
grid on

Mb=Ts.*fftshift(fft(mb,2048)); %mb(t)�� ���ļ������� ��Ÿ���� ���� Ǫ������ȯ(fft)���ϰ�
figure(2);                     %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������
subplot(3,1,2)
plot(ft,abs(Mb))
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('m_B(f)')
title( ' m_B(f) ')
grid on



Mc=Ts.*fftshift(fft(mc,2048)); %mc(t)�� ���ļ������� ��Ÿ���� ���� Ǫ������ȯ(fft)���ϰ�
figure(2);                     %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������
subplot(3,1,3);
plot(ft,abs(Mc))
figure(2);
axis([-500 500 0 0.1])
xlabel('f(Hz)')
ylabel('m_C(f)')
title( ' m_C(f) ')
grid on

