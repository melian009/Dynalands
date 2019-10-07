function Fig_Alpha_500()
    figStat=openfig('ASymD_gamma_GPT0001_mFixed.fig');
    hola=1;
    %axe=findobj(gcf,'type','axes','-and','xlim',[0 1000]);
    axes=findobj(gcf,'type','axes');
    axe=axes(2); %este es el plot de las time series...
    plots=allchild(axe);
    %plotsX=cell2mat(get(plots(8),'xdata'));
    %plotsY=cell2mat(get(plots(8),'ydata'));
    
    x_gpt1=get(plots,'xdata');
    y_gpt1=get(plots,'ydata');
    
    %colors=cell2mat(get(plots,'color'));
    %colors=get(plots([8,9,11,12]),'color');
    legenda=findobj(gcf,'type','legend');
%    legenda=legends(2); %esta es la legenda de los plots de la time series...
    legendaStr=legenda(2).String;
    %legendaStr=legendaStr([3,4,7,8]);
    close(figStat)
    
    figCompare=openfig('Fig_gamma_t_dyn.fig')
    chs=get(gcf,'children');
    hold(chs(4,1),'on');
    legendsCompare=findobj(gcf,'type','legend');
    legendStrsCompare=legendsCompare.String;
    plotsDyn=allchild(chs(4));
    colors=get(plotsDyn(2:end),'color');
    for i=1:4,
        %plot(chs(4,1),plotsX(i,:),plotsY(i,:),':','color',colors{5-i})
        plot(chs(4,1),x_gpt1{i,:}, y_gpt1{i,:},':','color',colors{5-i})
        legendStrsCompare{end+1}=legendaStr{5-i};
    end
    legend(chs(4,1),legendStrsCompare)
    %plot(chs(4,1),plotsX',plotsY')
    
    
end