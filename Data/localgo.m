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
%c10 date :: c13 lat :: c14 long :: c25 taxa

%Check columns!!
%c = csv2cell('sharkwebdataPhyto1819.csv');
%c15 date :: c19 lat :: c20 long :: c64 taxa

%Download
%c = csv2cell('sharkwebdataZoopl.csv');
%----------------------------------------------

%Obtain local richness per date-long-lat values
DATE = unique(c(:,15));
count = 0;
for i = 1:length(DATE);
    idx = find(ismember(c(:,15),(DATE(i,1))));

    LAT = unique(c(idx,19));
    LONG = unique(c(idx,20));

    latlog = 0;
    A = zeros(1,1);
    for j = 1:length(LAT);
        for k = 1:length(LONG);
            idy = find(ismember(c(idx,19),(LAT(j,1))));
            idz = find(ismember(c(idx,20),(LONG(k,1)))); 
            Alat = unique(c(idy,64));
            Along = unique(c(idz,64));
            length(Alat);
            length(Along);
            latlog = latlog + 1;
            A(latlog,1) = length(Alat);
        end
    end
      count = count + 1;
      T(i,1) = count;
      T(i,2) = mean(A);%alpha
      T(i,3) = length(unique(c(idx,64)));%gamma
hold on
red=rand(1); green=rand(1); blue=rand(1);
plot(T(i,2),T(i,3),'.','color',[red green blue],'Markersize',24)
end

xlabel('alpha',"fontsize",14)
ylabel('gamma',"fontsize",14)
set(gca,'fontsize',14);

