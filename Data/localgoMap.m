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
c = csv2cell('sharkwebdataPhyto20002019.csv',100);

%c9 date :: c1 lat :: c2 long :: c3 taxa

%Download
%c = csv2cell('sharkwebdataZoopl.csv');
%----------------------------------------------

%Delete empty cells (no LAT or LONG)
d = c(:,2:3);%LAT LONG
e = d(~any(cellfun('isempty', d), 2), :);
out = sortrows(e,1);%Increasing LAT


%LAT classes 
LATclas = 100;%latitude classes
LATc = round(linspace(1,length(out) - 1,LATclas));

%T = zeros(1,1);
count = 0;
for i = 1:length(LATc) - 1;

%Plotting Latitudinal Gradient :: check unifrnd(0+i,1+i)
RGB_colors = [unifrnd(0,1) unifrnd(0,1) unifrnd(0,1)]; % RGB colors

    for j = i+1:length(LATc);
        Alatgamma = zeros(1,1);idx = zeros(1,1);Latbin=zeros(1,1);Longbin=zeros(1,1);

        Latbin = unique(out(LATc(1,i):LATc(1,j),1));
        idgamma = find(ismember(c(:,2),Latbin(:,1)));
        Alatgamma = unique(c(idgamma,4));%Gamma Latbin
        for k = 1:length(Latbin);
  
            idx = find(ismember(c(:,2),Latbin(k,1)));
            Longbin = unique(c(idx,3));

            for k1 = 1:length(Longbin); 
                Alat = zeros(1,1);idy = zeros(1,1);
                idy = find(ismember(c(idx,3),Longbin(k1,1)));            
	        Alat = unique(c(idy,4));%Alpha
%k
%k1
%length(Alatgamma)
%length(Alat)
%pause
               if length(Alat) < length(Alatgamma)

                count = count + 1;
                T(count,1) = Latbin(k,1);%LAT
                T(count,2) = Longbin(k1,1);%LONG
                T(count,3) = length(Alat);%alpha
                T(count,4) = length(Alatgamma);%gamma
               
               end

hold on
alpha = [T{count,3}];gamma = [T{count,4}];

%Check gradient
set(gca,'ColorOrder',RGB_colors);
set(gca,'color',RGB_colors);
plot(alpha,gamma,'.','Markersize',28)

             end
        end
        break
    end
end
xlabel('alpha',"fontsize",14)
ylabel('gamma',"fontsize",14)
set(gca,'fontsize',14);

%Check Oytput matrix T

%val1 = [T{:,1}];
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


