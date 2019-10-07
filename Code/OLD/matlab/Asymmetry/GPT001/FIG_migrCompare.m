function DynaLandAnalysis()
    

    As = [0.075, 0.1, 0.4, 0.6];
    r = 1;
%     fMigName = ['Dat/Pos/AsymD_A' num2str(A,'%1.4f') '_GPT0500_r' num2str(r) '_pos.dat'];
%     load('-mat', fMigName)
%     n_Dyn = n;
%     
%     fMigName = ['GPT1/Pos/AsymD_A' num2str(A,'%1.4f') '_GPT0001_r' num2str(r) '_pos.dat'];
%     load('-mat', fMigName)
%     n_Stat = n;
%     n_Dyn es identico a n_Stat ya que tienen el mismo seed...
    inGoing_Stat=zeros(100,1); 
    outGoing_Stat=zeros(100,1);
    inGoing_Dyn=zeros(100,1);
    outGoing_Dyn=zeros(100,1);
    subplotIX=0;
    figure;
    for A=As,
        %figure;
        %set(gcf,'name',['A=' num2str(A)])
        subplotIX=subplotIX+1;
        subplot(1,4,subplotIX)
        
        
        %pause(0.1)
        EvImmPerSiteDyn=[];        
        for r=1:10,
            %r
            fMigName = ['GPT500_Dat/Mig/AsymD_A' num2str(A,'%1.4f') '_GPT0500_r' num2str(r) '_migr.dat'];
            load('-mat', fMigName)
            Pairs_Dyn = Pairs;

            fMigName = ['Mig/AsymD_A' num2str(A,'%1.4f') '_GPT0001_r' num2str(r) '_migr.dat'];
            load('-mat', fMigName)
            Pairs_Stat = Pairs;

            clear Pairs;
            
%             %outgoing emigration
%             uniqueP = unique(Pairs_Dyn(:,2));
%             outGoing_Dyn(uniqueP) = outGoing_Dyn(uniqueP) + histc(Pairs_Dyn(:,2), uniqueP);
%             uniqueP = unique(Pairs_Stat(:,2));
%             outGoing_Stat(uniqueP) = outGoing_Stat(uniqueP) + histc(Pairs_Dyn(:,2), uniqueP);
%             
%             %ingoing immigration
%             uniqueP = unique(Pairs_Dyn(:,1));
%             inGoing_Dyn(uniqueP) = inGoing_Dyn(uniqueP) + histc(Pairs_Dyn(:,1), uniqueP);
%             uniqueP = unique(Pairs_Stat(:,1));
%             inGoing_Stat(uniqueP) = inGoing_Stat(uniqueP) + histc(Pairs_Dyn(:,1), uniqueP);
            
            %Plot immigration events for each site
            %subplot(2,1,1)
            %title('immigration')
            Sinks = unique(Pairs_Dyn(:,1));   %sitios que recibieron migraciones
            imm2Sinks =histc(Pairs_Dyn(:,1), Sinks);  %Eventos de immigracion para cada sitio
            plot(Sinks,imm2Sinks,'.') %Dynamic
            EvImmPerSiteDyn(end+1:end+numel(Sinks))=imm2Sinks;
            hold on
            uniqueP = unique(Pairs_Stat(:,1));
            plot(uniqueP,histc(Pairs_Stat(:,1), uniqueP),'.') %Static

%             %Plot emigration events for each site
%             subplot(2,1,2)
%             title('emigration')
%             uniqueP = unique(Pairs_Dyn(:,2));
%             plot(uniqueP,histc(Pairs_Dyn(:,2), uniqueP),'.') %Dynamic
%             hold on
%             uniqueP = unique(Pairs_Stat(:,2));
%             plot(uniqueP,histc(Pairs_Stat(:,2), uniqueP),'.') %Stat
%             %pause
        end
        averImmEventsDyn=mean(imm2Sinks);
        disp(['A=' num2str(A) ' averImmEvents=' num2str(averImmEventsDyn)])
        plot([1 100], averImmEventsDyn*[1 1],'-k')
        ylim([0 35000])
        title(['A=' num2str(A)])
        if subplotIX==1,
            ylabel('Immigrations')
        end
        xlabel('site index')
%         figure;
%         subplot(2,1,1)
%         plot(outGoing_Dyn/100)
%         hold on
%         plot(outGoing_Stat/100)
%         
%         subplot(2,1,2)
%         plot(inGoing_Dyn/100)
%         hold on
%         plot(inGoing_Stat/100)
        
    end
    
    

        
end