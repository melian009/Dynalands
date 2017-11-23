for nu = 1:500;
J=10000;
Theta1=J*(nu/1000000);
S1(nu,1) = nu/1000000;
S1(nu,2) = 1+Theta1*log(1+((J-1)/Theta1));
end
plot(S1(:,1),S1(:,2))

