pkg load dataframe
pkg load statistics
pkg load io

%----------_DATA-------------------------------------------------------------------------------------
%c = csv2cell('sharkwebdataPhyto1819clean.csv');
c = csv2cell('sharkwebdataPhyto20052019.csv',100);
%c = csv2cell('sharkwebdataZoo20002019.csv',100);%Check 2005
%c9 date :: c1 lat :: c2 long :: c3 taxa
%----------------------------------------------------------------------------------------------------

%https://es.mathworks.com/matlabcentral/answers/52708-how-to-find-unique-rows-in-cell-array-in-matlab
[~,idx]=unique(cell2mat(c(:,2:3)),'rows');%Position of sites
us = c(idx,2:3);%unique sites
N = length(idx);%Sampling sites

%1. Gamma
Gamma = unique(c(:,4));
G = length(Gamma);%Regional sp.

%2. Sampling Binomial P(Alpha == Gamma)  
for i = 1:40000;
    Sites = randsample(length(c),i);%Randomly chosen sites, i = 1, 2, 3, N
    %[~,ids]=unique(cell2mat(c(Sites,4)),'rows')%Count unique sp from Sites
    
     ids1 = unique(c(Sites,4));
     [~,ids2]=unique(c(Sites,4));

    p = length(ids1)/G;%Prob alpha == gamma
    p1 = length(ids2)/G;
    Pr(i,1) = length(Sites);
    %V = 1:i;
    %Ptemp = binocdf(1,N,p);%Only last prob-value 
    Pr(i,2) = p;
    Pr(i,3) = p1;
%pause
end
hold on
plot(Pr(:,1),Pr(:,2),'ko')
%hold on
%plot(Pr(:,1),Pr(:,3),'ko')


