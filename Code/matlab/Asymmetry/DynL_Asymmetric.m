%----------------------------------------------------------------------
%Alex Rozenfeld Dic 2017 - Salvador/Brazil
%----------------------------------------------------------------------
function DynL_Asymmetric()
  
  show=true;
  %showEach = 1;
  
  MaxGenerations = 1000;
  MaxRep = 10; %1000;
  L=1000;
  %m = unifrnd(0.001,0.1,1);  %migraion from the blocks
  m=0.3;
  %v = unifrnd(0.0001,0.01,1);%regional migration?
  v=0.001;
  A = 2/5*L;  %amplitude, is the peak deviation: 350 to match simulations in random landscapes
  GensPerT=200;
  
  %-----------------
  
  f = 1/GensPerT;  %ordinary frequency, number of cycles that occur each second of time
  
  
  
  l=1-(m+v);
  S = 100; J = 100;%S sites and J inds. per site
  
  fileName = ['S' num2str(S) '_J' num2str(J) '_m' num2str(m) '_v' num2str(v) '_A' num2str(A) '_GT' num2str(GensPerT) '.mat'];
  
  
  theta=(J-1)*v/(1-v);
  Sm=sum(arrayfun(@(i) 1/(1+i/theta),[1:J]));
  Sm=Sm*S; %Alex!!! That is true only for the case of m=0;
  GammaAcum=zeros(1,MaxGenerations);
  Gamma2Acum=zeros(1,MaxGenerations);
  tic;
  for ri = 1:MaxRep,    
    %S = 1;J = 100;%S sites and J inds. per site
    
    %1. Implement a general case with zero-sum dynamics 
    %combining static-dynamic vs. symmetric-asymmetric scenarios (non-stationary Gillespie later)
    %Be sure that the mij + lambda + nu == 1
    %----------------------------------------------------------- 
    n = unifrnd(0,L,S,2); %positions of sites!
    %R = ones(S,J);  %una Specie inical para todo el sistema...
    R=repmat([1:S]',1,J);  %una Species inicial por site...
    countgen = 0;
    Pairs = zeros(1,2);cevents = 0;
    newSp = 100;
    gamma=[];
    
    for k = 1:MaxGenerations,  %Generations...        
        %A = L/5;%200;%amplitude, is the peak deviation: 
        %350 to match simulations in random landscapes
        %f = 0.1;%ordinary frequency, number of 
        %cycles that occur each second of time
        sig = 0;%the phase
        countgen = countgen + 1;
        %r = A*sin(2*pi*f*countgen + sig) + A;%starting point with r approx.
        r = A/2*(sin(2*pi*f*countgen + sig)+1);
        
        %2. Check sinusoidal with boundary conditions considering continuous A and f
        %Check r_min == 0 and r_max == max distance ij
               
        D = zeros(S,S);%theshold matrix
        Di = zeros(S,S);%distance matrix
        %mu = S*(exp((-pi * (r/L)^2 * S)));%site connectivity
        

        for i = 1:S-1,
            for j = i+1:S,
                A = (n(i,1) - n(j,1))^2;%Euclidean distance
                B = (n(i,2) - n(j,2))^2;
                d(i,j) = sqrt(A + B);
                Di(i,j) = 1/d(i,j);   
                
                %3. This is the simplest kernel
                %Explore the asymmetry under 1/d(i,j)
                %Do we need to implement more asymmetric situations, like 1/(d(i,j)^x) with x > 1;
                
                if d(i,j) < r;%threshold
                   D(i,j) = 1;
                else
                   D(i,j) = 0;
                end
           end
        end
        %DI=Di+Di';Dc=cumsum(DI,2);D1=D+D';
        %ALEX:  we are now working ONLY with symmetric landscapes!!!!
        DI=Di+Di';
        D1=D+D';
        DI=DI.*D1;  %<========ALEX
        
        Dc=cumsum(DI,2);
        
        % For Asymmetric migration (asymmetry comes from network
        % topology)...
        for j = 1:J*S,  %MonteCarlo Time
            KillHab = unidrnd(S);
            KillInd = unidrnd(J);
            ep=unifrnd(0,1,1);  %event probability
            if ep < m,  %Migration
              MigrantHabProb = unifrnd(0,max(Dc(KillHab,:)));
              MigrantHab = find(Dc(KillHab,:) >= MigrantHabProb);
            %pause
              if D1(KillHab,MigrantHab(1,1)) == 1;  %<---- Si el sitio elegido para migrar 
                                           % no está conectado entonces se
                                           % pierde la oportunidad de
                                           % procesar!!!! Ya no es mas
                                           % tiempo MC. Con el arregle en
                                           % DI, el sitio elegido estará
                                           % siempre conectado. Comprobar!
               
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
        end
%         
%         % For Symmetric migration probability:
%         % Pmig(a,b)=Pmig(b,a)=1/d(a,b)...
%         
%         for j = 1:floor(J*S*(1-m)),  %MonteCarlo Time ---> non-migration events
%             KillHab = unidrnd(S);
%             KillInd = unidrnd(J);
%             ep=unifrnd(0,1,1);  %event probability
%             
%             if ep <= v,  %mutation
%                newSp = newSp +1;
%                R(KillHab,KillInd) = newSp;
%             else               %birth
%                BirthLocalInd = unidrnd(J);
%                while BirthLocalInd == KillInd,
%                  BirthLocalInd = unidrnd(J);
%                end
%                R(KillHab,KillInd) = R(KillHab,BirthLocalInd);
%             end
%         end
%         
%         %In order to get symmetric probabilities for migration....
%         effMigEvs = 0;
%         while (effMigEvs <= floor(J*S*m)),  %MonteCarlo Time ---> non-migration events
%                 KillHab = unidrnd(S);
%                 KillInd = unidrnd(J);
%             
% %                 MigrantHabProb = unifrnd(0,max(Dc(KillHab,:)));
%                 MigrantHabProb = unifrnd(0,1); % to make it symmetric..                
%                 MigrantHab = find(Dc(KillHab,:) >= MigrantHabProb);
%                 
%               %pause
%                 if numel(MigrantHab)>0 &&  D1(KillHab,MigrantHab(1,1)) == 1;  %<---- Si el sitio elegido para migrar 
%                                              % no está conectado entonces se
%                                              % pierde la oportunidad de
%                                              % procesar!!!! Ya no es mas
%                                              % tiempo MC. Con el arregle en
%                                              % DI, el sitio elegido estará
%                                              % siempre conectado. Comprobar!
% 
%                  %4. Implement local birth dynamics and speciation dynamics
% 
%                  MigrantInd = unidrnd(J);  
%                  cevents = cevents + 1;
%                  Pairs(cevents,1) = KillHab;
%                  Pairs(cevents,2) = MigrantHab(1,1); 
% 
%                  R(KillHab,KillInd)=R(MigrantHab(1,1),MigrantInd);
%                  effMigEvs = effMigEvs +1;
%                 end
%            
%         end
        
        
        %Species at each site:
        
        %Sp_eachSt=arrayfun(@(ix) unique(R(ix,:)), [1:size(R,1)],'uniformoutput',false);
        %alpha(g) Num of species at each site for present generation
        %alpha = arrayfun(@(v) length(cell2mat(v)),Sp_eachSt);
        gamma(countgen) = numel(unique(R));
        
        %plot(gamma);
        %pause(0.001);
        
        %Sim=CalcSim(Sp_eachSt,S);
        Sim=0;
        
        
%         if show && (k==1 || mod(k,showEach)==0), %Show results          
%           ShowResults(ri,countgen,S,n,D1,d,alpha,gamma,Sim)
% 
%         end
        if show && mod(k,20)==0,
          disp(['Rep: ' num2str(ri) ' / ' num2str(MaxRep) ' -- Generation: ' num2str(k) ' / ' num2str(MaxGenerations)]);
        end
    end
    GammaAcum=GammaAcum+gamma;
    Gamma2Acum=Gamma2Acum+gamma.^2;
    sigma=sqrt(Gamma2Acum/ri-(GammaAcum/ri).^2);
    tiempo=toc;
    
%     %plot de la serie...
%     errorbar(GammaAcum/ri,sigma,'-s','MarkerSize',5,...
%     'MarkerEdgeColor','red','MarkerFaceColor','red');    
%     title(['Aver. over ' num2str(ri) ' realizations in ' num2str(floor(tiempo)) ' sec. PRE Result Sm=' num2str(Sm)])
%     pause(0.001);
    GammaAver=GammaAcum/ri;
    
    save(fileName,'ri','GammaAver','sigma','-mat','-v7.3');
    
    %Alex: to show results load resulting file and then do:
    %errorbar(GammaAver,sigma,'-s','MarkerSize',5,'MarkerEdgeColor','red','MarkerFaceColor','red');
  end           

end

function Sim = CalcSim(Sp_eachSt,S)
  Sim = zeros(S,S);
  for i = 1:S-1,
     for j = i+1:S,
        %CantSpEnComun_ij = #(Sp_i n Sp_j)
        %Similaridad_ij= CantSpEnComun_ij / (#Sp_i + #Sp_j - CantSpEnComun_ij)
        CantSpEnComun_ij = length(intersect(Sp_eachSt{i},Sp_eachSt{j}));
        Sim(i,j)= CantSpEnComun_ij / (length(Sp_eachSt{i})+length(Sp_eachSt{j})-CantSpEnComun_ij);        
     end
  end
  Sim = Sim + Sim' + eye(S,S);
end

function ShowResults(ri,countgen,S,n,D1,d,alpha,gamma,Sim)
          sizeFactor=10;
          figure(ri)
          subplot(2,3,[1 2 4 5]) %alpha  

          hold off
          for i=1:S,
            scatter(n(i,1),n(i,2),sizeFactor*alpha(i),'b','filled') %Sites
            hold on;
            hola=1;
            ixStConnected=find(D1(i,:));
            for ix=ixStConnected,
              line([n(i,1) n(ix,1)]',[n(i,2) n(ix,2)]','color','r') %Links
            end
          end
          xlim([0 1000])
          ylim([0 1000])
          text(1,1050,['Realization: ' num2str(ri) '    Gen: ' num2str(countgen)])


          subplot(2,3,3)  %gamma
          plot(gamma);
          %hold on
          %scatter(countgen,gamma(countgen),5,'k')

          subplot(2,3,6) %Sim VS d (connected and non connected)
          hold off
          for i = 1:S-1,
             for j = i+1:S,
                scatter(d(i,j),Sim(i,j),5,'k')
                hold on              
             end
          end        
          pause(0.001);
end


