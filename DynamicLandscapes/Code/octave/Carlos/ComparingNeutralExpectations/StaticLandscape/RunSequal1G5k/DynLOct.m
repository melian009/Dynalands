%----------------------------------------------------------------------
%General dynamic landscapes
%Melian@KB May 2017
%Palamara&Melian June 2017 version from scratch
%Alex Rozenfeld June 2017


%Comparing neutral expectations GM and CM DEC 05 2017
%A == 0 
%Output times series of gamma to compare with neutral iim
%----------------------------------------------------------------------
function DynLOct()
  
  %show=true;
  %showEach = 1;
  for ri = 1:100,    
    S = 100;J = 100;
    %1. Implement a general case with zero-sum dynamics 
    %combining static-dynamic vs. symmetric-asymmetric scenarios (non-stationary Gillespie later)
    %Be sure that the mij + lambda + nu == 1
    %----------------------------------------------------------- 
    n = unifrnd(0,1000,S,2); %sites!
    
    %1 diff species each site
    %R = zeros(S,J);
    %for v = 1:S;
    %    R(v,1:J) = repmat(v,J,1);
    % end
    %newSp = S + 1;
    %------------------------
    R = ones(S,J);
    newSp = 1;
    %------------------
    countgen = 0;
    Pairs = zeros(1,2);cevents = 0;
    G=6000;
    alpha=zeros(G,S);
    gamma=[];
            
    fnam = sprintf('file%d.txt',ri);
    fid = fopen(fnam,'w');

    for k = 1:G,  %Generations...        
        A = 0;%amplitude, is the peak deviation: 
        %350 to match simulations in random landscapes
        f = 0.1;%ordinary frequency, number of 
        %cycles that occur each second of time
        sig = 0;%the phase
        countgen = countgen + 1;
        r = A/2*(sin(2*pi*f*countgen + sig)+1);        
        D = zeros(S,S);%theshold matrix
        Di = zeros(S,S);%distance matrix        
        for i = 1:S-1,
            for j = i+1:S,
                A = (n(i,1) - n(j,1))^2;%Euclidean distance
                B = (n(i,2) - n(j,2))^2;
                d(i,j) = sqrt(A + B);
                Di(i,j) = 1/d(i,j);   
                
                %3. This is the simplest kernel
                %Do we need to implement more asymmetric situations, like 1/(d(i,j)^x) with x > 1;
                %Implement asymmetry as d(i,j)/(sum i to all)
                %Asymmetry as a function of richness == habitat quality
                
                %We have to go throughout all the matrix to account for asymmetry ij dif ji
                
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
               
        m = 0;  %migration from the blocks
        v = unifrnd(0.00001,0.001,1);%regional migration?
        l=1-(m+v);
        
        for j = 1:J*S,  %MonteCarlo Time
            KillHab = unidrnd(S);
            KillInd = unidrnd(J);
            
            ep=unifrnd(0,1,1);  %event probability
            if ep < m,  %Migration
            if max(Dc(KillHab) > 0);%NaN when max(Dc(KillHab,:))) == 0
              MigrantHabProb = unifrnd(0,max(Dc(KillHab,:)));
              MigrantHab = find(Dc(KillHab,:) >= MigrantHabProb);  
            
              if D1(KillHab,MigrantHab(1,1) == 1);  %<---- Si el sitio elegido para migrar 
                                           % no est� conectado entonces se
                                           % pierde la oportunidad de
                                           % procesar!!!! Ya no es mas
                                           % tiempo MC. Con el arregle en
                                           % DI, el sitio elegido estar�
                                           % siempre conectado. Comprobar!
               
               %4. Implement local birth dynamics and speciation dynamics
               
               MigrantInd = unidrnd(J);  
               cevents = cevents + 1;
               Pairs(cevents,1) = KillHab;
               Pairs(cevents,2) = MigrantHab(1,1); 
               
               R(KillHab,KillInd)=R(MigrantHab(1,1),MigrantInd);            
              end
            end%cancel case NaN  
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
        end
        
        %Species at each site:
        
        Sp_eachSt=arrayfun(@(ix) unique(R(ix,:)), [1:size(R,1)],'uniformoutput',false);
        %alpha(g) Num of species at each site for present generation
        alpha(countgen,1:S) = arrayfun(@(v) length(cell2mat(v)),Sp_eachSt);
        gamma(countgen) = numel(unique(R));
        
            
        %Sim=CalcSim(Sp_eachSt,S);
        %if show && (k==1 || mod(k,showEach)==0), %Show results          
        %  ShowResults(ri,countgen,S,n,D1,d,alpha,gamma,Sim)
        %end       
       
  end%gen
          fprintf(fid, [repmat('% 6f',1,size(alpha,2)), '\n'],alpha);fclose(fid); 
          fid = fopen('gammaA0.txt','a');fprintf(fid, [repmat('%d ',1,size(gamma,2)), '\n'],gamma);fclose(fid);  
          fid = fopen('nu.txt','a');fprintf(fid,'%f \n',v);fclose(fid);  
    
  end%rep 
end%function


%function Sim = CalcSim(Sp_eachSt,S)
%  Sim = zeros(S,S);
%  for i = 1:S-1,
%     for j = i+1:S,   
%       CantSpEnComun_ij = length(intersect(Sp_eachSt{i},Sp_eachSt{j}));
%        Sim(i,j)= CantSpEnComun_ij / (length(Sp_eachSt{i})+length(Sp_eachSt{j})-CantSpEnComun_ij);        
%     end
%  end
%  Sim = Sim + Sim' + eye(S,S);
%end

%compute alpha, beta gamma





%function ShowResults(ri,countgen,S,n,D1,d,alpha,gamma,Sim)
%          sizeFactor=10;
%          figure(ri)
%          subplot(2,3,[1 2 4 5]) %alpha  

          %hold off
          %for i=1:S,
          %  scatter(n(i,1),n(i,2),sizeFactor*alpha(i),'b','filled') %Sites
          %  hold on;
          %  hola=1;
          %  ixStConnected=find(D1(i,:));
          %  for ix=ixStConnected,
          %    line([n(i,1) n(ix,1)]',[n(i,2) n(ix,2)]','color','r') %Links
          %  end
          %end
          %xlim([0 1000])
          %ylim([0 1000])
          %text(1,1050,['Realization: ' num2str(ri) '    Gen: ' num2str(countgen)])


          %subplot(2,3,3)  %gamma
          %plot(gamma);
          %subplot(2,3,6) %Sim VS d (connected and non connected)
          %hold off
          %for i = 1:S-1,
          %   for j = i+1:S,
          %      scatter(d(i,j),Sim(i,j),5,'k')
          %      hold on              
          %   end
          %end        
          %pause(0.001);
%end


