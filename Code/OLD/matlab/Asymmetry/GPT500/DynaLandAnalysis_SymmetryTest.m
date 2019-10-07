function DynaLandAnalysis()
    symType=2;   %1: Symmetry;  2: Asymmetry Distance  3: Asymmetry Distance and Centrality
    Afilter='A*'; %'A0.6*';
    GPTfilter='GPT*';        
    selG=1000;
    
    switch symType
      case 1 %Symmetry
        symFilter='Sym*';
        fig_name='Symmetric';
        resultsFileName='Sym';
      case 2 %Asymmetry Distance
        symFilter='ASymD*';
        fig_name='Asymmetric Distance';
        resultsFileName='SymD';
      case 3 %Asymmetry Distance and Centrality
        symFilter='AsymDC*';
        fig_name='Asymmetric Distance and Centrality';
        resultsFileName='SymDC';
    end
    
    files=dir([symFilter Afilter GPTfilter '*.dat']); %symmetry
    
    
    
       
    AyGPT=[];
    for ixf=1:numel(files),
        partes=regexp(files(ixf).name,'_','split');
        A=str2num(partes{2}(2:end));
        GPT=str2num(partes{3}(4:end));
        AyGPT(end+1,:)=[A GPT];
    end
    
    [AyGPTsorted,sortInd]=sortrows(AyGPT);
    
    As=unique(AyGPT(:,1));
    cantAs=numel(As);
    GPTs=unique(AyGPT(:,2));
    cantGPTs=numel(GPTs);
    
    A_ant=AyGPTsorted(1,1);
    GPT_ant=AyGPTsorted(1,2);
    migEvents=zeros(100,100);
    fileName_ant=files(sortInd(1)).name;

    for ixFile=1:numel(files),    
            
            fileName=files(sortInd(ixFile)).name
            
            
            A=AyGPTsorted(ixFile,1);
            GPT=AyGPTsorted(ixFile,2);
            
            if A~=A_ant || GPT~=GPT_ant,
%                 figure('Name',fileName_ant)
                figName=[fig_name ' A' num2str(A_ant) '_GPT' num2str(GPT_ant)];                
                figure('Name',figName)
                deltaMig=abs(migEvents-migEvents');
                deltaMig_triangSup=triu(deltaMig,1);
                histogram(deltaMig_triangSup(:),[0:50:10000],'normalization','probability');
                set(gca,'xscale','log','yscale','log')
                pause(0.1)                
                migEvents=zeros(100,100);
                A_ant=A;
                GPT_ant=GPT;
                fileName_ant=fileName;
            end
            
                 
            %data=dlmread(fileName);
            load('-mat',fileName)
            % disp(['A:' num2str(A) 'GPT:' num2str(GPT)])
            % lee pairs Pairs
            %Pairs
            %hola=1;
            for i=1:size(Pairs,1),
                orig=Pairs(i,1);
                dest=Pairs(i,2);
                if orig~=0 && dest~=0,
                    migEvents(orig,dest)=migEvents(orig,dest)+1;
                end
            end
%             figure('Name',fileName)
%             deltaMig=abs(migEvents-migEvents');
%             deltaMig_triangSup=triu(deltaMig,1);
%             histogram(deltaMig_triangSup(:),100);
    end        
    
%     figure('Name',fileName)
    figName=[fig_name ' A' num2str(A) '_GPT' num2str(GPT)];                
    figure('Name',figName)
    deltaMig=abs(migEvents-migEvents');
    deltaMig_triangSup=triu(deltaMig,1);
    %histogram(deltaMig_triangSup(:),100);
    histogram(deltaMig_triangSup(:),[0:50:10000],'normalization','probability');
    set(gca,'xscale','log','yscale','log')
    
%     figure
%     deltaMig=abs(migEvents-migEvents');
%     surface([1:10],[1:10],deltaMig);
%     figure
%     deltaMig_triangSup=triu(deltaMig,1);
%     hist(deltaMig_triangSup(:),100)
    
end