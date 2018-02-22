%---------------------------------------------------------------------------
%AR Dic 2017 - Salvador/Brazil adapted by GM and Carlos KB
%CM -- octave to run EULER server end DEC 2017@EAWAG
%CM -- sinkhornKnopp algorithm to obtain double stochastic matrix FEB2018@EAWAG
%---------------------------------------------------------------------------
  %%% FIXED PARAMETERS do not touch them
  clear;
  seed=17;
  %rng(seed);
  MaxRep = 20;          %number of replicates
  MaxGenerations = 50000; %number of generations per replicates
  
  
  m=0.1; %migration rate
  v=0.001;%speciation rate 
  l=1-(m+v);%birth rate
  S = 50;%number of sites 
  J = 100;%individuals per site
  L=1000; % size of the landscape
  
  
  %remove here-----------------------------------------
  %P_min=0.001;  %Probability of migration from distance (2)^0.5*L (provided connection)
  %K=P_min*exp(sqrt(2)); %normalisation constant... for Symmetric case
  % so P_ij(d=(2)^0.5*L)=P_min
  % and P_ij(d=0)=1;
  % P_ij(d)=K*e^(-d/L)   where d es d_ij  
  %-------------------------------------------------------------------
  
  %Amplitudes, AS and frequencies GPTS values
  As = [0.1];%[0.025 0.05 0.075 0.1 0.12 0.2 0.4 0.6 0.8 1];
  GPTs =[1 5 10 50 100 500 1000]; % GPT=1 is Static
                            % GPT>MaxGenerations doesn't make sense...
                            % correspond to 100, 50, 10, 5, 1 periods of r                           
    for ii = 1:length(As), % i refersw to values of amplitude
     for jj = 1:length(GPTs), % j refers to values of frequency
        
        %give the parameters a specific combination of values 
        A = As(1,ii)*L;
        GPT = GPTs(1,jj); 
        f = 1/GPT;
        
        %define matrices to compute gamma diversity
        GammaAcum=zeros(1,MaxGenerations);
        Gamma2Acum=zeros(1,MaxGenerations);
          %start loop of replicates
          for ri = 1:MaxRep;  ri
            %tic
            %Create the random geometric graph 
            n = unifrnd(0,L,S,2); %positions of sites
            
            %initial condition
            R = ones(S,J);       %the same species in every site
            %R=repmat([1:S]',1,J); %a different species in every site
            
            countgen = 0;Trios = zeros(1,3);cevents = 0;newSp = 100;
            gamma=[];
   
            %start loop of generations
            for k = 1:MaxGenerations,  %Generations  
              %if mod(k,10), disp(['A: ' num2str(A) ' - GPT: ' num2str(GPT) ' - G: ' num2str(k) ' / ' num2str(MaxGenerations)]); end
              countgen = countgen + 1;
              r = A/2*(sin(2*pi*f*countgen)+1); % critical radiu
              D = zeros(S,S);  %theshold matrix
              Di = zeros(S,S); %distance matrix
              %Create matrices using euclidean distance and connectivity threshold
              for i = 1:S-1,
                for j = i+1:S,
                  dx2 = (n(i,1) - n(j,1))^2;%Euclidean distance
                  dy2 = (n(i,2) - n(j,2))^2;
                  d(i,j) = sqrt(dx2 + dy2);
                  Sd(i,j) = 1/d(i,j);
                  if d(i,j) < r;%threshold
                     D(i,j) = 1;
                  else
                     D(i,j) = 0;
                  end
                end
              end
              D1=D+D';
              
              P1 = 0;P2 = 0;
              %Symmetric model following double stochastic matrix
              Sd(S,S) = 0;
              Sd=Sd+Sd';
              Sdf = sinkhornKnopp(Sd);
              P_ij = cumsum(Sdf,2);
              P_ji = cumsum(Sdf,1);
             
             MHP = unifrnd(0,1);
             KillHab = unidrnd(S);
             if MHP >= P_ij(KillHab,KillHab);
                MigrantHab = find(P_ij(KillHab,:) >= MHP,1); 
                
                %prob
                if MigrantHab > 1;
                P1 = P_ij(KillHab,MigrantHab) - P_ij(KillHab,MigrantHab - 1);
                else
                P1 = P_ij(KillHab,MigrantHab);
                end
             cevents = cevents + 1;
             Trios(cevents,1) = KillHab;
             Trios(cevents,2) = MigrantHab;
             Trios(cevents,3) = P1;           
             else
                MigrantHab = find(P_ji(:,KillHab) >= MHP,1);
                
                %prob
                 if MigrantHab > 1             
                 P2 = P_ji(MigrantHab,KillHab) - P_ji(MigrantHab - 1,KillHab);
                 else
                 P2 = P_ji(MigrantHab,KillHab);
                 end
             cevents = cevents + 1;
             Trios(cevents,1) = KillHab;
             Trios(cevents,2) = MigrantHab;
             Trios(cevents,3) = P2;
             end
            end
            fnam = sprintf('Sym_A%0.4f_GPT%04d.txt',As(1,ii),GPTs(1,jj));
            fid = fopen(fnam,'a');
            save([fnam 'migsym.dat'],'Trios');
          end
        end
      end
      