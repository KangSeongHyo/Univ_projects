% Rayleigh_CH %

function [ch_coef] = Rayleigh_CH(CH_MODEL)

CH_Profile = zeros(CH_MODEL, 1); 
for cnt=1:CH_MODEL
    CH_Profile(cnt) = exp(-cnt/5);
end

ch_coef = randn(CH_MODEL,1) + i*randn(CH_MODEL, 1);
ch_coef = ch_coef.*CH_Profile;
ch_coef = ( ch_coef/sqrt(ch_coef'*ch_coef) ).';