%---------------------------------------------------------------------------
%Alex Rozenfeld Dic 2017 - Salvador/Brazil adapted by GM and Carlos KB
%Carlos Melian adapted to octave to run EULER server end DEC 2017@EAWAG
%---------------------------------------------------------------------------
  %%% FIXED PARAMETERS do not touch them
  MaxRep = 100;          %number of replicates
  MaxGenerations = 500; %number of generations per replicates
  
  rng(3);

  m=0.1; %migration rate
  v=0.001;%speciation rate 
  l=1-(m+v);%birth rate
  S = 100;%number of sites 
  J = 100;%individuals per site
  L=1000; % size of the landscape
  
  %Amplitudes, AS and frequencies GPTS values
  As = [0.075];%0.05 0.075 0.1 0.12 0.2 0.4 0.6 0.8 1];
  GPTs = [1 5 10 50 100 500 1000 5000 10000 50000];
  
    for ii = 1:10; % i refersw to values of amplitude
     for jj = 1:10; % j refers to values of frequency
        
        %give the parameters a specific combination of values 
        A = As(1,ii)*L;
        GPT = GPTs(1,jj); 
        f = 1/GPT;
        
        %define matrices to compute gamma diversity
        GammaAcum=zeros(1,MaxGenerations);
        Gamma2Acum=zeros(1,MaxGenerations);
  
          %start loop of replicates
          for ri = 1:MaxRep;       
            %Create the random geometric graph 
            n = unifrnd(0,L,S,2); %positions of sites
            
            %initial condition
            R = ones(S,J);       %the same species in every site
            %R=repmat([1:S]',1,J); %a different species in every site
            
            countgen = 0;Pairs = zeros(1,2);cevents = 0;newSp = 100;
            gamma=[];
   
            %start loop of generations
            for k = 1:MaxGenerations,  %Generations       
              
              countgen = countgen + 1;
              r = A/2*(sin(2*pi*f*countgen)+1); % critical radius
              
              D = zeros(S,S);  %theshold matrix
              Di = zeros(S,S); %distance matrix
        
              %Create matrices using euclidean distance and connectivity threshold
              for i = 1:S-1,
                for j = i+1:S,
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
             
              DI=Di+Di';
              D1=D+D';
              DI=DI.*D1;  %<========ALEX
              Dc=cumsum(DI,2);
        
              %Demographic events of the generation happen according to their probability
              for j = 1:J*S,  %MonteCarlo Time
                KillHab = unidrnd(S);
                KillInd = unidrnd(J);
                ep=unifrnd(0,1,1);  %event probability
                if ep < m,  %Migration
                % For Asymmetric migration (asymmetry comes from network topology)...
                MigrantHabProb = unifrnd(0,max(Dc(KillHab,:)));
                MigrantHab = find(Dc(KillHab,:) >= MigrantHabProb);
                if D1(KillHab,MigrantHab) == 1; 
               
                %4. Implement local birth dynamics and speciation dynamics
                MigrantInd = unidrnd(J);  
                cevents = cevents + 1;
                Pairs(cevents,1) = KillHab;
                Pairs(cevents,2) = MigrantHab(1,1); 
                R(KillHab,KillInd)=R(MigrantHab(1,1),MigrantInd);            
                end
                elseif ep <= m+v,  %mutation
                newSp = newSp +1;
                R(KillHab,KillInd) = newSp;
                else               %birth
                BirthLocalInd = unidrnd(J);
                while BirthLocalInd == KillInd,
                BirthLocalInd = unidrnd(J);
                end
                R(KillHab,KillInd) = R(KillHab,BirthLocalInd);
              end
            %Species at each site:
            Sp_eachSt=arrayfun(@(ix) unique(R(ix,:)), [1:size(R,1)],'uniformoutput',false);
            %alpha(g)%Num of species at each site for present generation
            alpha = arrayfun(@(v) length(cell2mat(v)),Sp_eachSt);
            gamma(countgen) = numel(unique(R));
            alphaM(countgen) = mean(alpha);
            alphaSD(countgen) = std(alpha);        
      end%k   
        end%loop of replicates
         fnam = sprintf('Symmetry%d %d.txt',As(1,ii),GPTs(1,jj));
          fid = fopen(fnam,'a');
          %fprintf(fid,'%f %f %f %3f %3f\n',ri,countgen,gamma,alphaM,alphaSD);    
          %fnam1 = sprintf('gamma%d %d %d %d %d.txt',ri,As(1,ii),A,GPT,f);
          %fid = fopen(fnam1,'w');
          fprintf(fid, [repmat('% 6f ',1,size(gamma,2)), '\n'],gamma);
          fprintf(fid, [repmat('% 6f ',1,size(alphaM,2)), '\n'],alphaM);
          fprintf(fid, [repmat('% 6f ',1,size(alphaSD,2)), '\n'],alphaSD);
          fclose(fid);
          end%ri
       end%GPTs
     end%As
