A = dlmread('DM2.txt');
count = 0;
for i = 1:99;
    for j = i+1:100;
        count = count +1;
        Asy(count,1) = abs(A(i,j) - A(j,i));
    end
end
Q = sort(Asy,'descend');
V = 1:length(Q);
plot(V,Q)