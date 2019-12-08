%-----------------------------------------
%Alpha-Gamma map for Phyto-Zoo-plankton
%Downloaded from November 10 2019
%https://sharkweb.smhi.se/


%Length of Day and Twilight
%http://herbert.gandraxa.com/length_of_day.xml
%-----------------------------------------

%https://wiki.octave.org/Dataframe_package
%https://stackoverflow.com/questions/32504203/install-octave-package-manually
pkg load dataframe
pkg load statistics
pkg load io

%----------_DATA-------------------------------
%c = csv2cell('sharkwebdataPhyto.csv');%test ok
%c10 date :: c13 lat :: c14 long :: c24 taxa

%Check columns!!
%c = csv2cell('sharkwebdataPhyto1819clean.csv');
%c = csv2cell('sharkwebdataPhyto20052019.csv',100);
c = csv2cell('sharkwebdataZoo20002019.csv',100);%Check 2005

%c9 date :: c1 lat :: c2 long :: c3 taxa

%Download
%c = csv2cell('sharkwebdataZoopl.csv');
%----------------------------------------------

%Delete empty cells (no LAT or LONG)
d = c(:,2:3);%LAT LONG
e = d(~any(cellfun('isempty', d), 2), :);
out = sortrows(e,1);%Increasing LAT


%LAT classes 
LATclas = 50;%latitude classes :: final run 100 classes
LATc = round(linspace(1,length(out) - 1,LATclas));

%T = zeros(1,1);
count = 0;
couplot = 0;

Timebin = unique(c(:,1));
 for k2 = 1:length(Timebin); ##Account for time when calculating the gamma pool
     for i = 1:length(LATc) - 1;

     for j = i+1:length(LATc);
        Alatgamma = zeros(1,1);idx = zeros(1,1);Latbin=zeros(1,1);Longbin=zeros(1,1);
        Latbin = unique(out(LATc(1,i):LATc(1,j),1));
        idgamma = find(ismember(c(:,2),Latbin(:,1)));
        idtime = find(ismember(c(idgamma,1),Timebin(k2,1)));
%debug--------
%Timebin(k2,1)
%length(idtime)
%pause
%-------------

        if ~isempty(idtime);
            Alatgamma = unique(c(idtime,4));%Gamma Latbin
            for k = 1:length(Latbin);
  
                idx = find(ismember(c(:,2),Latbin(k,1)));
                Longbin = unique(c(idx,3));
                for k1 = 1:length(Longbin); 
                    Alat = zeros(1,1);idy = zeros(1,1);
                    idy = find(ismember(c(idx,3),Longbin(k1,1)));            
       	            Alat = unique(c(idy,4));%Alpha
		    %k%k1%length(Alatgamma)%length(Alat)%pause
                    if length(Alat) < length(Alatgamma)
                       count = count + 1;
                       T(count,1) = Timebin(k2,1);%time
                       T(count,2) = Latbin(k,1);%LAT
                       T(count,3) = Longbin(k1,1);%LONG
                       T(count,4) = length(Alat);%alpha
                       T(count,5) = length(Alatgamma);%gamma
  
                    end

%hold on
%alpha = [T{count,3}];gamma = [T{count,4}];

%Check gradient
%set(gca,'ColorOrder',RGBcolors);
%set(gca,'color',RGBcolors);
%plot(alpha,gamma,'.','Markersize',28)

%plot(alpha,gamma,'.','Markersize',28,'Color',rand(1,3))%Works
%plot(alpha,gamma,'.','Markersize',28,'Color',[red green blue])%Works


               end
           end
          end
        break
        end
    end
end

%cell2csv('Ttime50LATclassPhyto.csv',T);
cell2csv('Ttime50LATclassZoo.csv',T);

%Check Oytput matrix T

%val1 = [T{:,1}];ize);                    % Standard Error Of The Mean
%val2 = [T{:,2}];
%alpha = [T{:,3}];
%gamma = [T{:,4}];

%fid = fopen(['T.csv'],'a');
%fprintf(fid, [repmat('%6.5f',1,size(T,2)), '\n'],T{:});
%fprintf(fid,'%e %e %e %e \n ',val1, val2, alpha, gamma)
%fclose(fid);


%alpha = [T{:,3}];gamma = [T{:,4}];  
%red=rand(1); green=rand(1); blue=rand(1);
%plot(alpha,gamma,'.','color',[red green blue],'Markersize',24)


