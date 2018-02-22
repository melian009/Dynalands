%---------------------------------------------------------------------------
%Alex Rozenfeld Dic 2017 - Salvador/Brazil adapted by GM and Carlos KB
%Carlos Melian adapted to octave to run EULER server Dic 20 2017@EAWAG
%---------------------------------------------------------------------------
  %%% FIXED PARAMETERS do not touch them
  MaxRep = 1;          %number of replicates
  MaxGenerations = 1; %number of generations per replicates
  
  m=0.1; %migration rate
  v=0.001;%speciation rate 
  l=1-(m+v);%birth rate
  S = 25;%number of sites 
  J = 25;%individuals per site
  L=1000; % size of the landscape
  
  %Amplitudes, AS and frequencies GPTS values
  As = [0.025 0.05 0.075 0.1 0.12 0.2 0.4 0.6 0.8 1 2 5 10 20];
  GPTs = [1 5 10 50 100 500 1000 5000 10000 50000];
  
    for ii = 1:10; % i refersw to values of amplitude
     for jj = 1:10; % j refers to values of frequency
        
        %give the parameters a specific combination of values 
        A = As(1,ii)*L
        GPT = GPTs(1,jj) 
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
              
              d = zeros(S,S);
              D = zeros(S,S);  %theshold matrix
              Di = zeros(S,S); %distance matrix
              Di2 = zeros(S,S);
              %Create matrices using euclidean distance and connectivity threshold
              for i = 1:S,
                for j = 1:S,
                    if i == j;
                      d(i,j) = 0;
                    else
                      A = (n(i,1) - n(j,1))^2;%Euclidean distance
                      B = (n(i,2) - n(j,2))^2;
                      d(i,j) = sqrt(A + B);
                      Di(i,j) = 1/d(i,j);
                    end    
                      
                    if d(i,j) < r;
                       D(i,j) = 1;
                    else
                       D(i,j) = 0;
                    end
                end
              end
              %DI=Di+Di';
              %D1=D+D';
              %DI=DI.*D1;  %<========ALEX
              DIs = Di.*D;
              %Dc=cumsum(DI,2);
             
            
              %Asymmetry
              for i2 = 1:S,
                for j2 = 1:S,
                    if i2 == j2;
                       Di2(i2,j2) = 0;
                    else
                       Di2(i2,j2) = d(i2,j2)/(sum(d(i2,:))); 
                       %Di2(j2,i2) = d(j2,i2)/(sum(d(j2,:)));
                    end
                end
              end
              %DI2=Di2;
              %D1=D+D'
              DIa=Di2.*D;  %<========ALEX
              %Dc=cumsum(DI,2);
            %pause
              %Quantify symmetry
              %S1=DI(1:S,:) - DI(:,1:S)';
              %S2=abs(DI2(1:S,:) - DI2(:,1:S)');
              %S2=sort(S2,'descend');
            
           %v=1:S;
           %plot(2,1,1)
           %imagesc()
           %plot(S1,v,'o')
          
           subplot(2,2,1)
           surf(DIs)
           subplot(2,2,2)
           imagesc(DIs)
           
           subplot(2,2,3)
           surf(DIa)
           subplot(2,2,4)
           imagesc(DIa)
           %subplot(2,1,2)
           %imagesc(S2)
           %plot(S2,v,'o')
           %axis([-10 10 0 S])
           %DI2
           pause
            
          end%loop of replicates
          end%ri
       end%GPTs
     end%As
