% Create a function to plot the data
x = [T{:,3}];
y = [T{:,4}];

plot(x,y,'.','Markersize',24,'Color',[0.85 0.5 0.5])
%plot(x,y,'rx','MarkerSize',8);

m = length(x);
% Add a column of all ones (intercept term) to x
X = [ones(m, 1) x];
theta = (pinv(X'*X))*X'*y

% Plot the fitted equation we got from the regression
hold on; % this keeps our previous plot of the training data visible
plot(X(:,2), X*theta, '-')
legend('Empirical data', 'Linear regression')
hold off % Don't put any more plots on this figure
