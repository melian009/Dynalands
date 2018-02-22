%---------------------------------------------------------------------------
%Alex Rozenfeld Dic 2017 - Salvador/Brazil adapted by GM and Carlos KB
%Carlos Melian adapted to octave to run EULER server Dic 20 2017@EAWAG
%---------------------------------------------------------------------------
  %%% FIXED PARAMETERS do not touch them
  MaxRep = 100;          %number of replicates
  MaxGenerations = 100; %number of generations per replicates
  
  S = 100;%number of sites 
  L=1000; % size of the landscape
  
  %Amplitudes, AS and frequencies GPTS values
  As = [0.025 0.05 0.075 0.1 0.12 0.2 0.4 0.6 0.8 1];
  GPTs = [1 5 10 50 100 500 1000 5000 10000 50000];
  
    for ii = 1:10; % i refersw to values of amplitude
     for jj = 1:10; % j refers to values of frequency
        
        %give the parameters a specific combination of values 
        A = As(1,ii)*L;
        GPT = GPTs(1,jj); 
        f = 1/GPT;
        
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
            %for k = 1:MaxGenerations,  %Generations       
              
              countgen = countgen + 1;
              r = A/2*(sin(2*pi*f*countgen)+1); % critical radius
              
              D = zeros(S,S);  %theshold matrix
              Di = zeros(S,S); %distance matrix
        
              Dr = zeros(S,S);
              Dc = zeros(S,S);
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
              
              DI = Di+Di';
              %Sum rows
              for row = 1:S;
              Dr(row,:) = DI(row,:)/sum(DI(row,:));
              ar(row,1) = sum(Dr(row,:),2);
              %pause
              end
              %Sum columns
              for col = 1:S;
              Dc(:,col) = DI(:,col)/sum(DI(:,col));
              ac(1,col) = sum(Dc(:,col),1);
              %pause
              end
              
              %Symmetric
              Dsym = Dr + Dr';
              %pause
              %Convert Dsym to doubly stochastic matrix
              for k = 1:100000;
                v1(1,1:S) = unifrnd(0.95,1); 
                D1 = diag(v1,S,S);
                v2(1,1:S) = unifrnd(0.5,0.55);
                D2 = diag(v2,S,S);
                Ddsym = D1*Dsym*D2;
              
              
              Ddr = sum(Ddsym,2);
              Ddc = sum(Ddsym,1);
              %pause
              
              
              Qr = find(Ddr(:,1) < 1.05 & Ddr(:,1) > 0.95); 
              Qc = find(Ddc(1,:) < 1.05 & Ddr(1,:) > 0.95);
              
             %length(Qr)
             % length(Qc)
             %pause
              if length(Qr) == S && length(Qc) == S;
                Ddr
                Ddc
                v1
                v2
                Qr
                Qc
                pause
              end
              end
                           
              
              %DI=Dr+Dc'
              %pause
              %Find vectors
              
              
              %D1=D+D';
              %DI=DI.*D1;  %<========ALEX
              %Dc=cumsum(DI,2);
      
  
          end%ri
       end%GPTs
     end%As
