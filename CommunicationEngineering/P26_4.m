clc;
clear;

iter=100000;             %iteration 100000 iter ����    

snr=0:3:30;          % 0���� 30���� 3�� �������� �ϴ� snr ���� 

BER=zeros(1,11);    % ��Ʈ ���� �� ������ �����ϴ� BER,BER1 ���� 

BER1=zeros(1,11);

count=0;           % ��Ʈ ������ ������ �����ϴ� count ����

for n=1:iter       %100000�� �ݺ�
    
for i=1:length(snr)  %snr�� ���̸�ŭ �ݺ� 11��

   bit =randi([0,1],1,128);% 2��Ʈ ũ��128 �������Լ� ����
   
   ds=sqrt(2)*bit;         %OOK����

    ch=Rayleigh_CH(8);     %8 PATH 

    c_ds=convolution(ds,ch); %ä�����

     F_ch=fft(ch,256); %ä���Լ� Ǫ���� ��ȯ  

    N_ds=noise(c_ds,snr(i));%ä����� �Լ��� ����� �����. 

    Fn_ds=fft(N_ds,256); %������ ���� ����  Ǫ���� ��ȯ�Ѵ� 
    
    Fn_ds_comp1=Fn_ds./F_ch;% Ǫ���� ��ȯ�ѰͿ� Ǫ���� ä������ �������ش�
    
    Tn_ds1=ifft(Fn_ds_comp1,256);% ������ ���� ��ǻ���� �Ѵ� 
    
    Tn_ds_128=Tn_ds1(1:128);  %Ǫ���� �ϸ鼭 �þ ���̸� �ٽ� ���� ���� 128���� ������ش�
    
    for j=1:128    % ������ ��ȣ�� DC������ �������� ������ ��Ʈ�� ũ�� 1 ������ 0 �����Ѵ�
     if Tn_ds_128(j)< sqrt(2)*1/2
      R_ds(j)=0;
     else
      R_ds(j)=1;
      end
    end
    
   for k=1:128    % ������ ��ȣ�� ����ȣ�� �񱳸� �Ͽ� ��Ʈ�� �ٸ� �� n�� �����Ѵ� 
    n(k)= R_ds(k)~=bit(k);
   end
   
   m=sum(n);    %n�� ����� ���� �� ���� ���� m�� �����Ѵ�
   
   BER(i)=m;    %snr�� ���� ���� ��Ʈ�� ������ BER�� �����Ѵ�
end
   BER1=BER1+BER;  %���� ���յ� ������Ʈ�� ������ �ݺ��� ������ BER1�� �����Ѵ�
end
Ber=BER1/(128*iter); % Ber�� 100000�� �ݺ��� �ѿ��������� 128*100000(�ݺ�Ƚ��)�� �������ش� (���� ��Ʈ����/�Ѻ�Ʈ ����)
semilogy(snr,Ber)
grid on; 
xlabel('SNR')
ylabel('MSE')
title (' BER: SNR = 0 : 3 : 30 , iteration:100,000 ')
