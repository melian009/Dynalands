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
c = csv2cell('sharkwebdataPhyto20052019.csv',100);

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
couplot = 0;
for i = 1:length(LATc) - 1;

%Plotting Latitudinal Gradient :: check unifrnd(0+i,1+i)
%a1 = unifrnd(0,1) + i;
%b1 = unifrnd(0,1) + i;
%c1 = unifrnd(0,1) + i;
%red=couplot + i; green=couplot + i; blue=couplot + i;
%RGBcolors = [1 1 1]; % RGB colors

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
                T(count,1) = 
                T(count,1) = Latbin(k,1);%LAT
                T(count,2) = Longbin(k1,1);%LONG
                T(count,3) = length(Alat);%alpha
                T(count,4) = length(Alatgamma);%gamma
               
               end

hold on
alpha = [T{count,3}];gamma = [T{count,4}];

%Check gradient
%set(gca,'ColorOrder',RGBcolors);
%set(gca,'color',RGBcolors);
%plot(alpha,gamma,'.','Markersize',28)

%plot(alpha,gamma,'.','Markersize',28,'Color',rand(1,3))%Works
%plot(alpha,gamma,'.','Markersize',28,'Color',[red green blue])%Works


             end
        end
        break
    end
end

%hold on
%plot([T{1:13,3}],[T{1:13,4}],'.','Markersize',24,'Color',[0.85 0.5 0.5])
%plot([T{14:52,3}],[T{14:52,4}],'.','Markersize',24,'Color',[0.75 0.25 0.5])
%plot([T{53:79,3}],[T{53:79,4}],'.','Markersize',24,'Color',[0.75 0.5 0.75])
%plot([T{80:132,3}],[T{80:132,4}],'.','Markersize',24,'Color',[0.75 0.85 0.75])
%plot([T{133:189,3}],[T{133:189,4}],'.','Markersize',24,'Color',[0.25 0.25 0.25])
%plot([T{190:230,3}],[T{190:230,4}],'.','Markersize',24,'Color',[0.9 0.5 0.85])
%plot([T{231:250,3}],[T{231:250,4}],'.','Markersize',24,'Color',[0.65 0.65 0.65])
%plot([T{251:266,3}],[T{251:266,4}],'.','Markersize',24,'Color',[0.35 0.65 0.65])
%plot([T{267:530,3}],[T{267:530,4}],'.','Markersize',24,'Color',[0.15 0.35 0.65])
%plot([T{531:880,3}],[T{531:880,4}],'.','Markersize',24,'Color',[0.05 0.15 0.65])
%plot([T{881:1035,3}],[T{881:1035,4}],'.','Markersize',24,'Color',[0.01 0.05 0.65])
%plot([T{1036:1264,3}],[T{1036:1264,4}],'.','Markersize',24,'Color',[0.001 0.01 0.65])

xlabel('alpha',"fontsize",14)
ylabel('gamma',"fontsize",14)
set(gca,'fontsize',14);

%Plot gradient classes ---------------------------------------------------------
T1alpha.mean = mean([T{1:13,3}]);
T1gamma.mean = mean([T{1:13,4}]);
N1.size = length([T{1:13,3}]);

%RGBcolors = [255 0 0];
%set(gca,'Colororder',RGBcolors);
SEMalpha1 = std([T{1:13,3}]) / sqrt(N1.size);                    % Standard Error Of The Mean
SEMgamma1 = std([T{1:13,4}]) / sqrt(N1.size-1);            % 95% Confidence Intervals
CI95alpha1 = SEMalpha1 * tinv(0.975, N1.size-1);              % 95% Confidence Intervals
CI95gamma1 = SEMgamma1 * tinv(0.975, N1.size-1); 
plot(mean([T{1:13,3}]),mean([T{1:13,4}]),'k.','Markersize',24)
hold on
errorbar(T1alpha.mean, T1gamma.mean, CI95gamma1,CI95alpha1,'~>')
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
T2alpha.mean = mean([T{14:52,3}]);
T2gamma.mean = mean([T{14:52,4}]);
N2.size = length([T{14:52,3}]);

SEMalpha2 = std([T{14:52,3}]) / sqrt(N2.size);                    % Standard Error Of The Mean
SEMgamma2 = std([T{14:52,4}]) / sqrt(N2.size-1);            % 95% Confidence Intervals
CI95alpha2 = SEMalpha1 * tinv(0.975, N2.size-1);              % 95% Confidence Intervals
CI95gamma2 = SEMgamma1 * tinv(0.975, N2.size-1); 
plot(mean([T{14:52,3}]),mean([T{14:52,4}]),'k.','Markersize',24)
hold on
errorbar(T2alpha.mean, T2gamma.mean, CI95gamma2,CI95alpha2,'~>')
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
T3alpha.mean = mean([T{53:79,3}]);
T3gamma.mean = mean([T{53:79,4}]);
N3.size = length([T{53:79,3}]);

SEMalpha3 = std([T{53:79,3}]) / sqrt(N3.size);                    % Standard Error Of The Mean
SEMgamma3 = std([T{53:79,4}]) / sqrt(N3.size-1);            % 95% Confidence Intervals
CI95alpha3 = SEMalpha1 * tinv(0.975, N3.size-1);              % 95% Confidence Intervals
CI95gamma3 = SEMgamma1 * tinv(0.975, N3.size-1); 
plot(mean([T{53:79,3}]),mean([T{53:79,4}]),'k.','Markersize',24)
hold on
errorbar(T3alpha.mean, T3gamma.mean, CI95gamma3,CI95alpha3,'~>')
%--------------------------------------------------------------------------------

%Plot gradient classes ---------------------------------------------------------
T4alpha.mean = mean([T{80:132,3}]);
T4gamma.mean = mean([T{80:132,4}]);
N4.size = length([T{1:13,3}]);

SEMalpha4 = std([T{80:132,3}]) / sqrt(N4.size);                    % Standard Error Of The Mean
SEMgamma4 = std([T{80:132,4}]) / sqrt(N4.size-1);            % 95% Confidence Intervals
CI95alpha4 = SEMalpha4 * tinv(0.975, N4.size-1);              % 95% Confidence Intervals
CI95gamma4 = SEMgamma4 * tinv(0.975, N4.size-1); 
plot(mean([T{80:132,3}]),mean([T{80:132,4}]),'b.','Markersize',24)
hold on
errorbar(T4alpha.mean, T4gamma.mean, CI95gamma4,CI95alpha4,'~>')
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
T5alpha.mean = mean([T{133:189,3}]);
T5gamma.mean = mean([T{133:189,4}]);
N5.size = length([T{133:189,3}]);

SEMalpha5 = std([T{133:189,3}]) / sqrt(N5.size);                    % Standard Error Of The Mean
SEMgamma5 = std([T{133:189,4}]) / sqrt(N5.size-1);            % 95% Confidence Intervals
CI95alpha5 = SEMalpha1 * tinv(0.975, N5.size-1);              % 95% Confidence Intervals
CI95gamma5 = SEMgamma1 * tinv(0.975, N5.size-1); 
plot(mean([T{133:189,3}]),mean([T{133:189,4}]),'b.','Markersize',24)
hold on
errorbar(T5alpha.mean, T5gamma.mean, CI95gamma5,CI95alpha5,'~>')
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
T6alpha.mean = mean([T{190:230,3}]);
T6gamma.mean = mean([T{190:230,4}]);
N6.size = length([T{190:230,3}]);

SEMalpha6 = std([T{190:230,3}]) / sqrt(N6.size);                    % Standard Error Of The Mean
SEMgamma6 = std([T{190:230,4}]) / sqrt(N6.size-1);            % 95% Confidence Intervals
CI95alpha6 = SEMalpha6 * tinv(0.975, N6.size-1);              % 95% Confidence Intervals
CI95gamma6 = SEMgamma6 * tinv(0.975, N6.size-1); 
plot(mean([T{190:230,3}]),mean([T{190:230,4}]),'b.','Markersize',24)
hold on
errorbar(T6alpha.mean, T6gamma.mean, CI95gamma6,CI95alpha6,'~>')
%--------------------------------------------------------------------------------

%Plot gradient classes ---------------------------------------------------------
T7alpha.mean = mean([T{231:250,3}]);
T7gamma.mean = mean([T{231:250,4}]);
N7.size = length([T{231:250,3}]);

SEMalpha7 = std([T{231:250,3}]) / sqrt(N7.size);                    % Standard Error Of The Mean
SEMgamma7 = std([T{231:250,4}]) / sqrt(N7.size-1);            % 95% Confidence Intervals
CI95alpha7 = SEMalpha7 * tinv(0.975, N7.size-1);              % 95% Confidence Intervals
CI95gamma7 = SEMgamma7 * tinv(0.975, N7.size-1); 
plot(mean([T{231:250,3}]),mean([T{231:250,4}]),'m.','Markersize',24)
hold on
errorbar(T7alpha.mean, T7gamma.mean, CI95gamma7,CI95alpha7,'~>')
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
T8alpha.mean = mean([T{251:266,3}]);
T8gamma.mean = mean([T{251:266,4}]);
N8.size = length([T{251:266,3}]);

SEMalpha8 = std([T{251:266,3}]) / sqrt(N8.size);                    % Standard Error Of The Mean
SEMgamma8 = std([T{251:266,4}]) / sqrt(N8.size-1);            % 95% Confidence Intervals
CI95alpha8 = SEMalpha8 * tinv(0.975, N8.size-1);              % 95% Confidence Intervals
CI95gamma8 = SEMgamma8 * tinv(0.975, N8.size-1); 
plot(mean([T{251:266,3}]),mean([T{251:266,4}]),'m.','Markersize',24)
hold on
errorbar(T8alpha.mean, T8gamma.mean, CI95gamma8,CI95alpha8,'~>')
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
T9alpha.mean = mean([T{267:530,3}]);
T9gamma.mean = mean([T{267:530,4}]);
N9.size = length([T{267:530,3}]);

SEMalpha9 = std([T{267:530,3}]) / sqrt(N9.size);                    % Standard Error Of The Mean
SEMgamma9 = std([T{267:530,4}]) / sqrt(N9.size-1);            % 95% Confidence Intervals
CI95alpha9 = SEMalpha9 * tinv(0.975, N9.size-1);              % 95% Confidence Intervals
CI95gamma9 = SEMgamma9 * tinv(0.975, N9.size-1); 
plot(mean([T{267:530,3}]),mean([T{267:530,4}]),'m.','Markersize',24)
hold on
errorbar(T9alpha.mean, T9gamma.mean, CI95gamma9,CI95alpha9,'~>')
%--------------------------------------------------------------------------------

%Plot gradient classes ---------------------------------------------------------
T10alpha.mean = mean([T{531:880,3}]);
T10gamma.mean = mean([T{531:880,4}]);
N10.size = length([T{531:880,3}]);

SEMalpha10 = std([T{531:880,3}]) / sqrt(N10.size);                    % Standard Error Of The Mean
SEMgamma10 = std([T{531:880,4}]) / sqrt(N10.size-1);            % 95% Confidence Intervals
CI95alpha10 = SEMalpha10 * tinv(0.975, N10.size-1);              % 95% Confidence Intervals
CI95gamma10 = SEMgamma10 * tinv(0.975, N10.size-1); 
plot(mean([T{531:880,3}]),mean([T{531:880,4}]),'k.','Markersize',24)
hold on
errorbar(T10alpha.mean, T10gamma.mean, CI95gamma10,CI95alpha10,'~>')
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
T11alpha.mean = mean([T{881:1035,3}]);
T11gamma.mean = mean([T{881:1035,4}]);
N11.size = length([T{881:1035,3}]);

SEMalpha11 = std([T{881:1035,3}]) / sqrt(N11.size);                    % Standard Error Of The Mean
SEMgamma11 = std([T{881:1035,4}]) / sqrt(N11.size-1);            % 95% Confidence Intervals
CI95alpha11 = SEMalpha11 * tinv(0.975, N11.size-1);              % 95% Confidence Intervals
CI95gamma11 = SEMgamma11 * tinv(0.975, N11.size-1); 
plot(mean([T{881:1035,3}]),mean([T{881:1035,4}]),'k.','Markersize',24)
hold on
errorbar(T11alpha.mean, T11gamma.mean, CI95gamma11,CI95alpha11,'~>')
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
T12alpha.mean = mean([T{1036:1264,3}]);
T12gamma.mean = mean([T{1036:1264,4}]);
N12.size = length([T{1036:1264,3}]);

SEMalpha12 = std([T{1036:1264,3}]) / sqrt(N12.size);                    % Standard Error Of The Mean
SEMgamma12 = std([T{1036:1264,4}]) / sqrt(N12.size-1);            % 95% Confidence Intervals
CI95alpha12 = SEMalpha12 * tinv(0.975, N12.size-1);              % 95% Confidence Intervals
CI95gamma12 = SEMgamma12 * tinv(0.975, N12.size-1); 
plot(mean([T{1036:1264,3}]),mean([T{1036:1264,4}]),'k.','Markersize',24)
hold on
errorbar(T12alpha.mean, T12gamma.mean, CI95gamma12,CI95alpha12,'~>')
%--------------------------------------------------------------------------------


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


