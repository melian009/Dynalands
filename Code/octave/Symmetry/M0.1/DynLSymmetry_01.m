%---------------------------------------------------------------------------
%AR Dic 2017 - Salvador/Brazil adapted by GM and Carlos KB
%CM -- octave to run EULER server end DEC 2017@EAWAG
%CM -- sinkhornKnopp algorithm to sample symmetric DSM FEB2018@EAWAG
%---------------------------------------------------------------------------
  %%% FIXED PARAMETERS do not touch them
  clear;
  %seed=17;
  %rng(seed);
  MaxRep = 1;          %number of replicates
  MaxGenerations = 100; %number of generations per replicates
  
  m=0.3; %migration rate
  v=0.001;%speciation rate 
  l=1-(m+v);%birth rate
  S = 10;%number of sites 
  J = 100;%individuals per site
  L=1000; % size of the landscape
  
  %Amplitudes, AS and frequencies GPTS values
  As = [0.025 0.05 0.075 0.1 0.12 0.2 0.4 0.6 0.8 1];
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
          for ri = 1:MaxRep;   
            %tic
            %Create the random geometric graph 
            n = unifrnd(0,L,S,2); %positions of sites
            
            %initial condition
            R = ones(S,J);       %the same species in every site
            %R=repmat([1:S]',1,J); %a different species in every site
            
            countgen = 0;Pairs = zeros(1,2);cevents = 0;newSp = 100;
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
                
              %Symmetric model following double stochastic matrix
              Sd(S,S) = 0;
              Sd=Sd+Sd';
              Sdf = sinkhornKnopp(Sd);
              P_ij = cumsum(Sdf,2);
              P_ji = cumsum(Sdf,1)
              %-------------------------

              
              %Demographic events of the generation happen according to their probability
              for t = 1:J*S,  %MonteCarlo Time
                %if mod(t,10), disp(['t: ' num2str(t) ' / ' num2str(J*S)]); end
                KillHab = unidrnd(S);
                KillInd = unidrnd(J);
                ep=unifrnd(0,1,1);  %event probability
                if ep < m,  
                  
                   %Migration: forcing m to be m? Some A,f produces empty P_ij matrix!!
                   %Migration prior and posterior differ -- obtain posterior
                   MHP = unifrnd(0,1);
                   KillHab = unidrnd(S);
                   if MHP >= P_ij(KillHab,KillHab);
                      MigrantHab = find(P_ij(KillHab,:) >= MHP,1);    
                   else
                      MigrantHab = find(P_ji(:,KillHab) >= MHP,1);
                   end                                  
                    
                    if numel(MigrantHab)>0 && D1(KillHab,MigrantHab) == 1, 
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
              end%t
              
              Sp_eachSt=arrayfun(@(ix) unique(R(ix,:)), [1:size(R,1)],'uniformoutput',false);
              %alpha(g)%Num of species at each site for present generation
              alpha = arrayfun(@(v) length(cell2mat(v)),Sp_eachSt);
              gamma(countgen) = numel(unique(R));
              alphaM(countgen) = mean(alpha);
              alphaSD(countgen) = std(alpha);
            end%loop generations  
            
            fnam = sprintf('Sym_A%0.4f_GPT%04d.txt',As(1,ii),GPTs(1,jj));
            fid = fopen(fnam,'a');
            %fprintf(fid,'%f %f %f %3f %3f\n',ri,countgen,gamma,alphaM,alphaSD);    
            %fnam1 = sprintf('gamma%d %d %d %d %d.txt',ri,As(1,ii),A,GPT,f);
            %fid = fopen(fnam1,'w');
            fprintf(fid, [repmat('% 6f ',1,size(gamma,2)), '\n'],gamma);
            fprintf(fid, [repmat('% 6f ',1,size(alphaM,2)), '\n'],alphaM);
            fprintf(fid, [repmat('% 6f ',1,size(alphaSD,2)), '\n'],alphaSD);
            fclose(fid);
            mpost = cevents/(MaxGenerations*S*J)
            save([fnam '_migr_events.dat'],'Pairs', 'ri', 'mpost');
            %toc
          end%ri
     end%GPTs
    end%As
