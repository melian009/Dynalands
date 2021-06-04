x = [0.001 0.01 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4];
y = [0.34 0.34 0.34 0.34 0.34 0.34 0.34 0.34 0.34 0.34];%mean 10 regionalisations (Fig SI3)
plot(x,y,'b-')

hold on
%CI
x = [0.001 0.01 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4];
y = [0.28 0.28 0.28 0.28 0.28 0.28 0.28 0.28 0.28 0.28]
plot(x,y,'b--')

hold on
%CI
x = [0.001 0.01 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4];
y = [0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.4]
plot(x,y,'b--')

set(gca, "linewidth", 2, "fontsize", 26)
ylabel('\alpha-to-\gamma slope',"fontsize",24)
xlabel('Landscape Connectivity (A)',"fontsize",24)




