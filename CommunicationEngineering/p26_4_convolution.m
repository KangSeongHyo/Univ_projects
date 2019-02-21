function y= convolution(x,h) 

Ni = length(x); 
Nh = length(h); 
y = zeros(1,Ni+Nh); 
t = zeros(1,Nh); 
for i = 1:Ni+Nh-1 
if i<=Ni 
t(1)= x(i); 
for j = 1:Nh 
y(i) = y(i) + h(j)*t(j); 
end 
for k = Nh:-1:2 
t(k) = t(k-1); 
end 
else 
t(1)= 0; 
for j = 1:Nh 
y(i) = y(i) + (h(j)*t(j)); 
end 

for k = Nh:-1:2 
t(k) = t(k-1); 
end 
end 
end
