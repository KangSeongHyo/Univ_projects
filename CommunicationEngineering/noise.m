function [awgn_data, n_power] = noise(data,SNR)
[MP_row,MP_col]=size(data);
    n_power=sqrt(1/(2*(10^(SNR/10))));
    noise=(randn(MP_row,MP_col) + randn(MP_row,MP_col)*1i).*n_power;
    awgn_data = data + noise;  