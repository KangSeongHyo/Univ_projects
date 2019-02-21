clc;
clear;

iter=100000;             %iteration 100000 iter 생성    

snr=0:3:30;          % 0부터 30까지 3을 간격으로 하는 snr 생성 

BER=zeros(1,11);    % 비트 오류 총 개수를 저장하는 BER,BER1 생성 

BER1=zeros(1,11);

count=0;           % 비트 오류의 개수를 저장하는 count 생성

for n=1:iter       %100000번 반복
    
for i=1:length(snr)  %snr의 길이만큼 반복 11번

   bit =randi([0,1],1,128);% 2비트 크기128 디지털함수 생성
   
   ds=sqrt(2)*bit;         %OOK복조

    ch=Rayleigh_CH(8);     %8 PATH 

    c_ds=convolution(ds,ch); %채널통과

     F_ch=fft(ch,256); %채널함수 푸리에 변환  

    N_ds=noise(c_ds,snr(i));%채널통과 함수에 노이즈를 씌운다. 

    Fn_ds=fft(N_ds,256); %노이즈 씌운 것을  푸리에 변환한다 
    
    Fn_ds_comp1=Fn_ds./F_ch;% 푸리에 변환한것에 푸리에 채널으로 나누어준다
    
    Tn_ds1=ifft(Fn_ds_comp1,256);% 복원한 것을 역퓨리에 한다 
    
    Tn_ds_128=Tn_ds1(1:128);  %푸리에 하면서 늘어난 길이를 다시 원래 길이 128으로 만들어준다
    
    for j=1:128    % 복원된 신호를 DC성분을 기준으로 각각의 비트를 크면 1 작으면 0 저장한다
     if Tn_ds_128(j)< sqrt(2)*1/2
      R_ds(j)=0;
     else
      R_ds(j)=1;
      end
    end
    
   for k=1:128    % 복조된 신호와 원신호를 비교를 하여 비트가 다를 때 n에 저장한다 
    n(k)= R_ds(k)~=bit(k);
   end
   
   m=sum(n);    %n에 저장된 수를 다 더한 것을 m에 저장한다
   
   BER(i)=m;    %snr에 따른 에러 비트의 개수를 BER에 저장한다
end
   BER1=BER1+BER;  %최종 종합된 에러비트의 개수를 반복할 때마다 BER1에 저장한다
end
Ber=BER1/(128*iter); % Ber에 100000번 반복한 총에러개수를 128*100000(반복횟수)로 나누어준다 (에러 비트개수/총비트 개수)
semilogy(snr,Ber)
grid on; 
xlabel('SNR')
ylabel('MSE')
title (' BER: SNR = 0 : 3 : 30 , iteration:100,000 ')
