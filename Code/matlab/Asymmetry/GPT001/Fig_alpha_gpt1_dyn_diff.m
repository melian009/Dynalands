function Fig_Alpha_500()
    figStat=openfig('Fig_alpha_compare_gpt1mFixed_dyn.fig');
    hola=1;
    %axe=findobj(gcf,'type','axes','-and','xlim',[0 1000]);
    axes=findobj(gcf,'type','axes');
    axe=axes(2); %este es el plot de las time series...
    plots=allchild(axe);
    %get(plots,'displayname')
    %diffs Stat - Dyn:
    diff0_075=get(plots(1),'ydata')-get(plots(6),'ydata');
    diff0_1=get(plots(2),'ydata')-get(plots(7),'ydata');
    diff0_4=get(plots(3),'ydata')-get(plots(8),'ydata');
    diff0_6=get(plots(4),'ydata')-get(plots(9),'ydata');
    X=get(plots(1),'xdata');
    
    %plotsX=cell2mat(get(plots,'xdata'));
    %plotsY=cell2mat(get(plots,'ydata'));
    %colors=cell2mat(get(plots,'color'));
    colors=get(plots,'color');
    plotNames=get(plots,'displayname');
    %legends=findobj(gcf,'type','legend');
    %legenda=legends(2); %esta es la legenda de los plots de la time series...
    %legendaStr=legenda.String;
    close(figStat)
    
    %ejes=findobj(allchild(gcf),'type','Axes');
   
    figure;
    %hold(ejes(2),'on')
    %plot(ejes(2),X,diff0_075,X,diff0_1,X,diff0_4,X,diff0_6)
    [axH,p1H,p2H]=plotyy(X',[diff0_075',diff0_1',diff0_4',diff0_6'],X',[120*sin(2*pi*X'/500), repmat(0,1000,1)]);
    xlabel('t')
    
    ylabel(axH(1),'<\alpha_{stat}(t)>_r-<\alpha_{dyn}(t)>_r')
    ylabel(axH(2),'R/L')
    %legend(legendaStr{end:-1:1})
    ylim(axH(1),[-15 15])
    ylim(axH(2),[-120 120])
    set(axH(2),'ytick',[-120 0 120])
    %set(axH(2),'yticklabel',[0 0.5 1])
    set(axH(2),'yticklabel',{'0' '0.5 A/L' 'A/L' })
    legenda=cellfun(@(elem) [elem '-Dyn'],plotNames(1:4),'uniformoutput',false);
    legend(legenda)
    hola=1;
    
    
end