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


kabc=sa+sb+sc;                    %�۽Ŵܿ��� DSB-SC������ ��ȣ sa(t), sb(t), sc(t)�� ���ÿ� �����Ҷ� �� ��ȣ�� kabc��� ����.

kbb=kabc.*cos(2.*pi.*120.*t);     %��ȣ mb(t)�� �����ϱ� ���� mb(t)�� �ݼ��� cos(2*pi*120*t)�� kabc�� �ѹ��� ���Ͽ���.(m(t)*cos(2*pi*fc*t)^2)lpf=m(t)/2���� �̿�)

Kbb=Ts.*fftshift(fft(kbb,2048));  %LowPassFilter�� ��ġ�� ���� Ǫ���� ��ȯ(fft)�� �Ͽ��� ��ȣ�� ���ļ� �������� ��Ÿ�� 
                                  %fft�� ������� 2^n���� ǥ���Ǳ⿡ �ð��� �������� 2001�� ����� 2048�� ��������

%LowPassFilter ����
 for i=1:length(ft)              %ft�� ���̸�ŭ �ݺ���
if abs(ft(i))<40                 %Ideal LPF cutoff frequency=40�̹Ƿ� |ft|�� 40���� ������
    lpf(i)=2;                    %���Ͱ��� 2�� ����. (1�� ������, �ð������� ����ȯ�� mb(t)/2�� ������ ��.)
else
    lpf(i)=0;                    %|ft|�� 40���� ���������� 0���� ����.
end                              %if~else���� end
 end                             %for �ݺ��� end
  
Dmb=lpf.*Kbb;                    %Ǫ���� ��ȯ�� �� ��ȣ�� LowPassFilter�� ��ħ

figure(1);
subplot(2,1,1)
plot(ft,abs(Dmb))
xlabel('f(Hz)')
ylabel('m_B(f)')
title('m_B(f)')
grid on


Dmbt=fs.*ifft(ifftshift(Dmb),2048);  %LowPassFilter�� ��ģ ��ȣ�� �ٽ� �ð�������  ��Ÿ���� ���� ��Ǫ���� ��ȯ(ifft)�� ��.
                                     %ifft�� ������� 2^n���� ǥ���Ǳ⿡ 2048�� ����.

Dmbt1=Dmbt(1:2001);                  %�ð��࿡���� ������� 2001�� �̹Ƿ� ��Ǫ������ȯ�� �� ��ȣ�� ����� 2001�� �ٽ� ����.

figure(1);
subplot(2,1,2)
plot(t,abs(Dmbt1))
xlabel('t(sec)')
ylabel('m_B(t)')
title(' m_B(t) ')
grid on



mse=zeros(1,16);                        %��� �� ���������� ���� 0���� �ʱ�ȭ�� ������ ����
iter=10000;                            %�ݺ� Ƚ���� ���� ����
snr = 0:3:45;                           %SNR ���� : 0~45���� ����3���� ����

%�ݺ�Ƚ��
for n=1:iter                            %10,000�� �ݺ��� ���� �ݺ���
    
for i=1:length(snr)                     %SNR�� ���̸�ŭ �ݺ�����.

sa=ma.*cos(2.*pi.*40.*t);             
sb=mb.*cos(2.*pi.*120.*t);       
sc=mc.*cos(2.*pi.*200.*t);       

kabc=sa+sb+sc;                  

kbb=kabc.*cos(2.*pi.*120.*t);         

noise_kbb=noise(kbb,snr(i));            %kbb��ȣ�� ������ SNR���϶� noise�� ����  
 
Kbb=Ts.*fftshift(fft(noise_kbb,2048));  %noise�� ���� ��ȣ�� LowPassFilter�� ����� ���� Ǫ���� ��ȯ(fft)����
                                        %fft�� ������� 2^n���� ǥ���Ǳ⿡ 2048�� ����.

Dmb=lpf.*Kbb;                           %Ǫ������ȯ�� ��ȣ�� LowPassFilter�� ������


Dmbt=fs.*ifft(ifftshift(Dmb),2048);     %LowPassFilter�� ��ģ ��ȣ�� �ð������� ǥ���ϱ����� ��Ǫ������ȯ(iff)�� ��.
                                        %ifft�� ������� 2^n���� ǥ���Ǳ⿡ 2048�� ����.

Dmbt1=Dmbt(1:2001);                     %�ð��࿡���� ������� 2001�� �̹Ƿ� ��Ǫ������ȯ�� �� ��ȣ�� ����� 2001�� �ٽ� ����.
 
  
mse2(i)=mean(abs(mb-Dmbt1).^2);         %����ȣ mb(t)�� ������ SNR���϶� noise�� ���� ��ȣ�� ������.

end                                     %SNR �ݺ����� end

mse=mse+mse2;                           %�ݺ������Ҷ� ���� ���� MSE�� �����ؼ� ����.
end                                     %i0,000�� �ݺ����� end

MSE=mse/iter;                           %�����ؼ� ������ ���� �ݺ�Ƚ���� ������ ��հ��� ����

figure(2);
semilogy(snr,MSE)
xlabel('SNR')
ylabel('MSE')
title (' MSE: SNR = 0 : 3 : 45 , iteration:10,000 ')
grid on
