function FIG_AlphaVSlamda()
    meanORmax = 'mean'; %puede ser 'mean' o 'max'
    switch meanORmax,
        case 'mean'
            fname = 'meanAlpha.fig';
        case 'max'
            fname = 'maxAlpha.fig';
    end
    
    %Read Static Figs...
    %below percolation...
    hS1 = openfig(['Stat_A0.075_' fname],'reuse'); % open figure
    axS1 = gca; % get handle to axes of figure
    hS2 = openfig(['Stat_A0.1_' fname],'reuse'); % open figure
    axS2 = gca; % get handle to axes of figure
    
    %above percolation...
    hS3 = openfig(['Stat_A0.4_' fname],'reuse'); % open figure
    axS3 = gca; % get handle to axes of figure
    hS4 = openfig(['Stat_A0.6_' fname],'reuse'); % open figure
    axS4 = gca; % get handle to axes of figure
    
    
    %Read Dynamic Figs...
    %below percolation...
    hD1 = openfig(['GPT500_Dat/Dyn_A0.075_' fname],'reuse'); % open figure
    axD1 = gca; % get handle to axes of figure
    hD2 = openfig(['GPT500_Dat/Dyn_A0.1_' fname],'reuse'); % open figure
    axD2 = gca; % get handle to axes of figure
    
    %above percolation...
    hD3 = openfig(['GPT500_Dat/Dyn_A0.4_' fname],'reuse'); % open figure
    axD3 = gca; % get handle to axes of figure
    hD4 = openfig(['GPT500_Dat/Dyn_A0.6_' fname],'reuse'); % open figure
    axD4 = gca; % get handle to axes of figure
    
    
    
    %---------------------------------
    %create new figure
    
    hNewFig = figure; 
    sub1 = subplot(2,2,1);
    title('Static @ t = 750')
    %xlabel('\lambda')
    ylabel(['<\alpha>_{' meanORmax '}'])
    ylim([0 20])
    ax=gca; ax.YGrid = 'on';
    %legend({'0.075'  '0.1' '0.4' '0.6' })
    
    sub2 = subplot(2,2,2);
    title('Dynamic @ t = 750')
    %xlabel('\lambda')
    ylim([0 20])
    ax=gca; ax.YGrid = 'on';
    
    sub3 = subplot(2,2,3);
    title('Static @ t = 1000')
    ylabel(['<\alpha>_{' meanORmax '}'])
    xlabel('\lambda')
    ylim([0 20])
    ax=gca; ax.YGrid = 'on';
    
    sub4 = subplot(2,2,4);
    title('Dynamic @ t = 1000')
    xlabel('\lambda')
    ylim([0 20])
    ax=gca; ax.YGrid = 'on';
    %Plots estáticos en subplot 1
    
    pS1_1000 = findobj(axS1,'displayname','t=1000');        
    pS2_1000 = findobj(axS2,'displayname','t=1000');        
    pS3_1000 = findobj(axS3,'displayname','t=1000');        
    pS4_1000 = findobj(axS4,'displayname','t=1000');
    
    pS1_750 = findobj(axS1,'displayname','t=750');        
    pS2_750 = findobj(axS2,'displayname','t=750');        
    pS3_750 = findobj(axS3,'displayname','t=750');        
    pS4_750 = findobj(axS4,'displayname','t=750');
            
    pS1_1000.Marker='+';    
    pS2_1000.Marker='o';    
    pS3_1000.Marker='x';    
    pS4_1000.Marker='square';
    
    pS1_750.Marker='+';    
    pS2_750.Marker='o';    
    pS3_750.Marker='x';    
    pS4_750.Marker='square';
            
    pS1_1000.LineStyle='none';       
    pS2_1000.LineStyle='none';    
    pS3_1000.LineStyle='none';    
    pS4_1000.LineStyle='none';
    
    pS1_750.LineStyle='none';       
    pS2_750.LineStyle='none';    
    pS3_750.LineStyle='none';    
    pS4_750.LineStyle='none';
        
    pS1_1000.Color=[0 0 0];    
    pS2_1000.Color=[1 0 0];    
    pS3_1000.Color=[0 1 0];    
    pS4_1000.Color=[0 0 1];
    
    pS1_750.Color=[0 0 0];    
    pS2_750.Color=[1 0 0];    
    pS3_750.Color=[0 1 0];    
    pS4_750.Color=[0 0 1];
    
    
    copyobj(pS1_750,sub1);        
    copyobj(pS2_750,sub1);        
    copyobj(pS3_750,sub1);       
    copyobj(pS4_750,sub1); 
    
    copyobj(pS1_1000,sub2);        
    copyobj(pS2_1000,sub2);        
    copyobj(pS3_1000,sub2);       
    copyobj(pS4_1000,sub2); 
    
    %Plots dinámicos en subplot 2
    
    pD1_750  = findobj(axD1,'displayname','t=750');
    pD1_1000 = findobj(axD1,'displayname','t=1000');
    
    pD2_750  = findobj(axD2,'displayname','t=750');
    pD2_1000 = findobj(axD2,'displayname','t=1000');
    
    pD3_750  = findobj(axD3,'displayname','t=750');
    pD3_1000 = findobj(axD3,'displayname','t=1000');
    
    pD4_750  = findobj(axD4,'displayname','t=750');
    pD4_1000 = findobj(axD4,'displayname','t=1000');
    
    
    pD1_750.Marker ='+';
    pD1_1000.Marker='+';
    pD2_750.Marker ='o';
    pD2_1000.Marker='o';
    pD3_750.Marker ='x';
    pD3_1000.Marker='x';
    pD4_750.Marker ='square';
    pD4_1000.Marker='square';
    
    pD1_750.LineStyle='none';
    pD1_1000.LineStyle='none';
    pD2_750.LineStyle='none';
    pD2_1000.LineStyle='none';
    pD3_750.LineStyle='none';
    pD3_1000.LineStyle='none';
    pD4_750.LineStyle='none';
    pD4_1000.LineStyle='none';
    
    pD1_750.Color =[0 0 0];
    pD1_1000.Color=[0 0 0];
    pD2_750.Color =[1 0 0];
    pD2_1000.Color=[1 0 0];
    pD3_750.Color =[0 1 0];
    pD3_1000.Color=[0 1 0];
    pD4_750.Color =[0 0 1];
    pD4_1000.Color=[0 0 1];
    
    
    copyobj(pD1_750,sub3);
    copyobj(pD1_1000,sub4);
    
    copyobj(pD2_750,sub3);
    copyobj(pD2_1000,sub4);
    
    copyobj(pD3_750,sub3);
    copyobj(pD3_1000,sub4);
    
    copyobj(pD4_750,sub3);
    copyobj(pD4_1000,sub4);
    
    %legend({'0.075' '0.075' '0.1' '0.1' '0.4' '0.4' '0.6' '0.6'})
    legend({'0.075'  '0.1' '0.4' '0.6' })
    
    close([hS1, hS2, hS3, hS4, hD1, hD2, hD3, hD4])
        
end