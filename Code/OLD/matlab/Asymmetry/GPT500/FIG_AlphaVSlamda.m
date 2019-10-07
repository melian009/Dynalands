function FIG_AlphaVSlamda()
    meanORmax = 'max'; %puede ser 'mean' o 'max'
    switch meanORmax,
        case 'mean'
            fname = 'meanAlpha.fig';
        case 'max'
            fname = 'maxAlpha.fig';
    end
    
    %below percolation...
    h11 = openfig(['GPT1/Stat_A0.075_' fname],'reuse'); % open figure
    ax11 = gca; % get handle to axes of figure
    h21 = openfig(['GPT1/Stat_A0.1_' fname],'reuse'); % open figure
    ax21 = gca; % get handle to axes of figure
    
    h12 = openfig(['Dat/Dyn_A0.075_' fname],'reuse'); % open figure
    ax12 = gca; % get handle to axes of figure
    h22 = openfig(['Dat/Dyn_A0.1_' fname],'reuse'); % open figure
    ax22 = gca; % get handle to axes of figure
    
    
    
    hNewFig = figure; %create new figure
    ax11_copy = copyobj(ax11,hNewFig);
    ax12_copy = copyobj(ax12,hNewFig);
    ax21_copy = copyobj(ax21,hNewFig);
    ax22_copy = copyobj(ax22,hNewFig);
    
    s11 = subplot(2,2,1,ax11_copy); %create and get handle to the subplot axes
    s12 = subplot(2,2,2,ax12_copy);
    s21 = subplot(2,2,3,ax21_copy);
    s22 = subplot(2,2,4,ax22_copy);
    
    close(h11)
    close(h12)
    close(h21)
    close(h22)
    
    fname=['FIG_' meanORmax 'AlphaVSlamda_belowP.fig'];
    if exist(fname,'file'),
        disp(['EL ARCHIVO: ' fname 'YA EXISTE! ---> ABORTO!'])
        exit
    end
    savefig(hNewFig,['FIG_' meanORmax 'AlphaVSlamda_belowP.fig'])
    close(hNewFig)
    
    %above percolation...
    h11 = openfig(['GPT1/Stat_A0.4_' fname],'reuse'); % open figure
    ax11 = gca; % get handle to axes of figure
    h21 = openfig(['GPT1/Stat_A0.6_' fname],'reuse'); % open figure
    ax21 = gca; % get handle to axes of figure
    
    h12 = openfig(['Dat/Dyn_A0.4_' fname],'reuse'); % open figure
    ax12 = gca; % get handle to axes of figure
    h22 = openfig(['Dat/Dyn_A0.6_' fname],'reuse'); % open figure
    ax22 = gca; % get handle to axes of figure
    
    
    
    hNewFig = figure; %create new figure
    ax11_copy = copyobj(ax11,hNewFig);
    ax12_copy = copyobj(ax12,hNewFig);
    ax21_copy = copyobj(ax21,hNewFig);
    ax22_copy = copyobj(ax22,hNewFig);
    
    s11 = subplot(2,2,1,ax11_copy); %create and get handle to the subplot axes
    s12 = subplot(2,2,2,ax12_copy);
    s21 = subplot(2,2,3,ax21_copy);
    s22 = subplot(2,2,4,ax22_copy);
    
    close(h11)
    close(h12)
    close(h21)
    close(h22)
    
    savefig(hNewFig,['FIG_' meanORmax 'VSlamda_aboveP.fig'])
    close(hNewFig)    
end