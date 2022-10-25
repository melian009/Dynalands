pkg load dataframe
pkg load statistics
pkg load io
pkg load geometry
pkg load matgeom
pkg load mapping

%https://sourceforge.net/p/octave/package-releases/391/
%Installed matgeom geometry mapping

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

%Plot alpha as function of LAT-LONG
    for j = 1:N;
        id1 = find(ismember(c(:,2),us(j,1)));
        id2 = find(ismember(c(:,3),us(j,2)));
        id = intersect(id1,id2);
        
        
        a = str2num(cell2mat(us(j,1)));
        SM1 = deg2sm(a,"earth");

        b = str2num(cell2mat(us(j,2)));
        SM2 = deg2sm(b,"earth");

        alpha(j,1) = SM1(1,1);
        alpha(j,2) = SM2(1,1);
        [ids]=unique(c(id,4));
        alpha(j,3) = length(ids)
       

  %Alat = unique(c(idy,64));
  %          Along = unique(c(idz,64));
  %         length(Alat);
  %          length(Along);
  %          latlog = latlog + 1;
  %          A(latlog,1) = length(Alat);
  %      end
  %  end


    end
%end
plot3(alpha(:,1),alpha(:,2),alpha(:,3),'o')



%1. Gamma
%Gamma = unique(c(:,4));
%G = length(Gamma);%Regional sp.

%2. Sampling Binomial P(Alpha == Gamma)  
%for i = 1:40000;
%    Sites = randsample(length(c),i);%Randomly chosen sites, i = 1, 2, 3, N
    %[~,ids]=unique(cell2mat(c(Sites,4)),'rows')%Count unique sp from Sites
    
%     ids1 = unique(c(Sites,4));
%     [~,ids2]=unique(c(Sites,4));

%    p = length(ids1)/G;%Prob alpha == gamma
%    p1 = length(ids2)/G;
%    Pr(i,1) = length(Sites);
    %V = 1:i;
    %Ptemp = binocdf(1,N,p);%Only last prob-value 
%    Pr(i,2) = p;
%    Pr(i,3) = p1;
%pause
%end
%hold on
%plot(Pr(:,1),Pr(:,2),'ko')
%hold on
%plot(Pr(:,1),Pr(:,3),'ko')


