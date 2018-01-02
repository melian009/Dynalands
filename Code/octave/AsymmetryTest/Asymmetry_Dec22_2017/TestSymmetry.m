%---------------------------------------------------------------------------
%Alex Rozenfeld Dic 2017 - Salvador/Brazil adapted by GM and Carlos KB
%Carlos Melian adapted to octave to run EULER server Dic 20 2017@EAWAG
%---------------------------------------------------------------------------
  %%% FIXED PARAMETERS do not touch them
  MaxRep = 1;          %number of replicates
  MaxGenerations = 100; %number of generations per replicates
  
  m=0.1; %migration rate
  v=0.001;%speciation rate 
  l=1-(m+v);%birth rate
  S = 30;%number of sites 
  J = 20;%individuals per site
  L=1000; % size of the landscape
  
  %Amplitudes, AS and frequencies GPTS values
  As = [0.025 0.05 0.075 0.1 0.12 0.2 0.4 0.6 0.8 1];
  GPTs = [1 5 10 50 100 500 1000 5000 10000 50000];
  
  show=true;
  showEach = 1;
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
            for k = 1:MaxGenerations,
              k%Generations       
              
              countgen = countgen + 1;
              r = A/2*(sin(2*pi*f*countgen)+1); % critical radius
              
              d = zeros(S,S);
              D = zeros(S,S);  %theshold matrix
              Di = zeros(S,S); %distance matrix
              Di2 = zeros(S,S);
              DIs = zeros(S,S);
              DIa = zeros(S,S);
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
               DIs = Di.*D;
              %Asymmetry
              for i2 = 1:S,
                for j2 = 1:S,
                    if i2 == j2;
                       Di2(i2,j2) = 0;
                    else
                       if sum(DIs(i2,:) > 0);
                          Di2(i2,j2) = (1/d(i2,j2))/(sum(DIs(i2,:)))^2;
                       else
                          Di2(i2,j2) = 0;
                       end 
                    end
                end
              end
              DIa=Di2.*D;
            
              %Quantify symmetry
              S1=abs(DIa(1:S,:) - DIa(:,1:S)');
              S1 = abs(triu(S1));
              hold off 
              subplot(2,3,5)
              imagesc(S1)
              colorbar
             
           %network
           %function ShowResults(ri,countgen,S,n,D,DIs,DIa)
           hold off
           subplot(2,3,1)
           title('Symmetry')
           surf(DIs)
           
           hold off
           subplot(2,3,4)
           imagesc(DIs)
           colorbar
           
           hold off
           subplot(2,3,3)
           title('Asymmetry')
           surf(DIa)
           
           hold off
           subplot(2,3,6)
           imagesc(DIa)
           colorbar 
             
           hold off  
           subplot(2,3,2)
           sizeFactor=10;
            for i=1:S,
            scatter(n(i,1),n(i,2),sizeFactor,'b','filled') %Sites
            hold on;
            hola=1;
            ixStConnected=find(D(i,:));
            for ix=ixStConnected,
              line([n(i,1) n(ix,1)]',[n(i,2) n(ix,2)]','color','r') %Links
            end
            end
            xlim([0 1000])
            ylim([0 1000])
            text(1,1050,['Realization: ' num2str(ri) '    Gen: ' num2str(countgen)])
            pause(0.001);
 
           end%loop of replicates
       end%ri
     end%GPTs
   end%As
       