%---------------------------------------------------------------
%Testing asymmetry dynamic landscapes
%Melian@KB may 2017
%---------------------------------------------------------------
for ri = 1:1;
rand('seed',sum(100*clock));%Gmax = 100;
%G = unidrnd(Gmax,1,1);%Generations could be variable
S = 100;J = 100;%S sites and J inds. per site
R = ones(S,J);
countgen = 0;

for k = 1:1000;
        A = 100;%amplitude, is the peak deviation: 350 to match simulations in random landscapes
        f = 0.01;%ordinary frequency, number of cycles that occur each second of time
        sig = 0;%the phase
        countgen = countgen + 1;
        r = A*sin(2*pi*f*countgen + sig) + A;%starting point with r approx. A and countgen is generation season
       
        D = zeros(S,S);%theshold matrix
        Di = zeros(S,S);%distance matrix
        mu = S*(exp((-pi * (r/1000)^2 * S)));%site connectivity
        n = unifrnd(0,1000,S,2);

        for i = 1:S-1;
            for j = i+1:S;
                A = (n(i,1) - n(j,1))^2;%Euclidean distance
                B = (n(i,2) - n(j,2))^2;
                d(i,j) = sqrt(A + B);
                Di(i,j) = 1/d(i,j);
                if d(i,j) < r;%threshold
                   D(i,j) = 1;
                else
                   D(i,j) = 0;
                end
           end
        end
        DI=Di+Di';Dc=cumsum(DI,2);D1=D+D';
        %checking plot all same color
        %gplot(D1,n, "k.-")
        set (get (gca, ("children")), "markersize", 12);
        pause
        Pairs = zeros(1,2);cevents = 0;
        for j = 1:S*J;
            KillHab = unidrnd(S);
            KillInd = unidrnd(J);
            MigrantHab = unifrnd(0,max(Dc(KillHab,:)));
               for kr = 1:S;
                   if Dc(KillHab,kr) >= MigrantHab && D1(KillHab,kr) == 1;
                     MigrantInd = unidrnd(J);
                     R(KillHab,KillInd) = R(kr,MigrantInd);
                     cevents = cevents + 1;
                     Pairs(cevents,1) = KillHab;
                     Pairs(cevents,2) = MigrantInd;
                   end
                   break
               end
       
        end
 end%G
end                      
fid = fopen('Asymmetry.txt','a');fprintf(fid, [repmat('% 6f',1,size(Pairs,2)), '\n'],Pairs);fclose(fid); 






