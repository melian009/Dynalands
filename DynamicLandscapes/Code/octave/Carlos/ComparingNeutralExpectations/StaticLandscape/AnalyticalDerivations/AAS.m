%following Vallade and Houchmandzadehe Physical Review E 2003
J = 10000;#sp abundance n
n = 10000;#max abun
nu = 0.0001;#mut or spe rate
Theta=((J-1)*nu)/(1-nu);
Theta1=J*nu;
for i = 1:n;
S(i,1) = (Theta/(Theta+i-1));
end
St = sum(S);


