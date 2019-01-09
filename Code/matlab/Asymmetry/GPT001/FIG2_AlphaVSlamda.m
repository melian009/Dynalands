function FIG_AlphaVSlamda()
    meanORmax = 'max'; %puede ser 'mean' o 'max'
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
    sub1 = subplot(1,2,1);
    title('Static @ t = 600')
    xlabel('\lambda')
    ylabel('<\alpha>_{max}')
    ylim([0 18])
    sub2 = subplot(1,2,2);
    title('Dynamic @ t = 600')
    xlabel('\lambda')
    ylim([0 18])
    
    %Plots estáticos en subplot 1
    
    pS1_900 = findobj(axS1,'displayname','t=900');
    pS1_600 = findobj(axS1,'displayname','t=600');
    
    pS2_900 = findobj(axS2,'displayname','t=900');
    pS2_600 = findobj(axS2,'displayname','t=600');
    
    pS3_900 = findobj(axS3,'displayname','t=900');
    pS3_600 = findobj(axS3,'displayname','t=600');
    
    pS4_900 = findobj(axS4,'displayname','t=900');
    pS4_600 = findobj(axS4,'displayname','t=600');
    
    
    pS1_600.Marker='+';
    pS1_900.Marker='none';
    pS2_600.Marker='o';
    pS2_900.Marker='none';
    pS3_600.Marker='x';
    pS3_900.Marker='none';
    pS4_600.Marker='square';
    pS4_900.Marker='none';
    
    pS1_600.LineStyle='none';
    pS1_900.LineStyle='none';
    pS2_600.LineStyle='none';
    pS2_900.LineStyle='none';
    pS3_600.LineStyle='none';
    pS3_900.LineStyle='none';
    pS4_600.LineStyle='none';
    pS4_900.LineStyle='none';
    
    pS1_600.Color=[0 0 0];
    pS1_900.Color=[0 0 0];
    pS2_600.Color=[1 0 0];
    pS2_900.Color=[1 0 0];
    pS3_600.Color=[0 1 0];
    pS3_900.Color=[0 1 0];
    pS4_600.Color=[0 0 1];
    pS4_900.Color=[0 0 1];
    
    
    copyobj(pS1_600,sub1);
    %copyobj(pS1_900,sub1);
    
    copyobj(pS2_600,sub1);
    %copyobj(pS2_900,sub1);
    
    copyobj(pS3_600,sub1);
    %copyobj(pS3_900,sub1);
    
    copyobj(pS4_600,sub1);
    %copyobj(pS4_900,sub1);
    
    
    %Plots dinámicos en subplot 2
    
    pD1_900 = findobj(axD1,'displayname','t=900');
    pD1_600 = findobj(axD1,'displayname','t=600');
    
    pD2_900 = findobj(axD2,'displayname','t=900');
    pD2_600 = findobj(axD2,'displayname','t=600');
    
    pD3_900 = findobj(axD3,'displayname','t=900');
    pD3_600 = findobj(axD3,'displayname','t=600');
    
    pD4_900 = findobj(axD4,'displayname','t=900');
    pD4_600 = findobj(axD4,'displayname','t=600');
    
    
    pD1_600.Marker='+';
    pD1_900.Marker='none';
    pD2_600.Marker='o';
    pD2_900.Marker='none';
    pD3_600.Marker='x';
    pD3_900.Marker='none';
    pD4_600.Marker='square';
    pD4_900.Marker='none';
    
    pD1_600.LineStyle='none';
    pD1_900.LineStyle='none';
    pD2_600.LineStyle='none';
    pD2_900.LineStyle='none';
    pD3_600.LineStyle='none';
    pD3_900.LineStyle='none';
    pD4_600.LineStyle='none';
    pD4_900.LineStyle='none';
    
    pD1_600.Color=[0 0 0];
    pD1_900.Color=[0 0 0];
    pD2_600.Color=[1 0 0];
    pD2_900.Color=[1 0 0];
    pD3_600.Color=[0 1 0];
    pD3_900.Color=[0 1 0];
    pD4_600.Color=[0 0 1];
    pD4_900.Color=[0 0 1];
    
    
    copyobj(pD1_600,sub2);
    %copyobj(pD1_900,sub2);
    
    copyobj(pD2_600,sub2);
    %copyobj(pD2_900,sub2);
    
    copyobj(pD3_600,sub2);
    %copyobj(pD3_900,sub2);
    
    copyobj(pD4_600,sub2);
    %copyobj(pD4_900,sub2);
    
    legend({'0.075' '0.1' '0.4' '0.6'})
    
    close([hS1, hS2, hS3, hS4, hD1, hD2, hD3, hD4])
        
end