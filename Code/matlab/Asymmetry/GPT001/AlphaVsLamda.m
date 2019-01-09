function AlphaVsLamda()
    meanORmax = 'max'; %puese ser 'mean' o 'max'
    S = 100;
    L = 1000;
    As = [0.075 0.1 0.4 0.6];
    GPTs = [1]; % GPT=1 is Static
    MaxRep = 10;
    %t = 1000;
    %figure;
    %hold on;
    ts=[50:50:1000];
    alphaVSlamda_t=zeros(1000,100);
    alphaVSlamda_t_count=zeros(1000,100);
    for GPT = GPTs,
        f = 1 / GPT;
        for A = As,
            fnam = sprintf('ASymD_A%0.4f_GPT%04d',A,GPT);
            A = A*L;
            for rep = 1:MaxRep,                
                fnam_Compositions=['Comp/' fnam '_r' num2str(rep) '_comp.dat'];                
                load(fnam_Compositions,'R_t','-mat');
                
                fnam_positions=['Pos/' fnam '_r' num2str(rep) '_pos.dat'];
                load(fnam_positions, 'n', '-mat');
                %cla
                for t=ts,%[50:50:1000],%[250],
                    disp([rep t])
                    %Calculo alpha en cada sitio @ time = t                    
                    R=R_t{t};
                    Sp_eachSt=arrayfun(@(ix) unique(R(ix,:)), [1:size(R,1)],'uniformoutput',false);
                    %alpha(g)%Num of species at each site for present generation
                    alpha = arrayfun(@(v) length(cell2mat(v)),Sp_eachSt);


                    %Calculo lamda de cada sitio @ time = t
                    r = A/2*(1+sin(2*pi*f*t)); % critical radiu
                    D = zeros(S,S);
                    for i = 1:S-1,
                        %scatter(n(i,1),n(i,2),4,'k','filled')
                        for j = i+1:S,
                          dx2 = (n(i,1) - n(j,1))^2;%Euclidean distance
                          dy2 = (n(i,2) - n(j,2))^2;
                          d(i,j) = sqrt(dx2 + dy2);                      
                          if d(i,j) < r;%threshold
                             D(i,j) = 1;
                             %line([n(i,1) n(j,1)],[n(i,2) n(j,2)])
                          else
                             D(i,j) = 0;
                          end
                        end
                    end
                    D1=D+D';
                    lamdas=sum(D1,1);                         
                    %cantConectados=numel(find(lamdas>0));
                    %scatter(t,cantConectados)
                    %disp([t cantConectados])
                    %scatter(lamdas,alpha,4,'k','filled')
                    [U,ilam,iU] = unique(lamdas); %El primer lamda puede ser 0 o mayor...
                    Ugt0 = U(find(U>0)); %No trato lamda=0                    
                    Alpha4lamda=[];%zeros(1,numel(Ugt0));                    
                    
                    
                    if numel(Ugt0) == numel(U)
                        ini_ix = 1;
                    else
                        ini_ix = 2;
                    end
                    for ix=ini_ix:numel(U),
                        ix_lamIguales=find(iU==ix); 
                        switch meanORmax
                            case 'mean'
                                Alpha4lamda(end+1)=mean(alpha(ix_lamIguales));
                            case 'max'
                                Alpha4lamda(end+1)=max(alpha(ix_lamIguales));
                        end
                    end
                    %plot(U,meanAlpha4lamda,'-*k')
                    
                    alphaVSlamda_t(t,Ugt0) = alphaVSlamda_t(t,Ugt0) + Alpha4lamda;                      
                    alphaVSlamda_t_count(t,Ugt0) = alphaVSlamda_t_count(t,Ugt0) + repmat(1,1,numel(Ugt0));
                    
%                     xlim([0 50])
%                     ylim([0 20])
%                     pause(1)
%                     xlabel('\lambda')
%                     ylabel('\alpha')
                    hola = 1;
                    
                end %t
                hola=1;  
%                 pause(1)
            end %rep
            l=[1:50]; 
            fh=figure;
            hold on
            leyenda={};
            for t = ts,
                plot(l,alphaVSlamda_t(t,l)./alphaVSlamda_t_count(t,l),'-*k')
                leyenda{end+1} = ['t=' num2str(t)]; 
%                 xlabel('\lambda')
%                 ylabel('\alpha')
%                 title(['t= ' num2str(t)])
%                 xlim([0 50])
%                 ylim([0 30])
                %pause(1)
            end
            xlabel('\lambda')
            ylabel('\alpha')
            title(['Static A = ' num2str(A/L)])
            xlim([0 50])
            ylim([0 30])
            legend(leyenda);
            savefig(fh,['Stat_A' num2str(A/L) '_' meanORmax 'Alpha.fig']);
            close(fh);
            hola = 1;
        end %A
    end %GPT
    hola=1;
end