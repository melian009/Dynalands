As = [0.025 0.05 0.075 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1];
GPTs =[1 5 10 50 100 500 1000]; % GPT=1 is Static
L=1000; % size of the landscape
count = 0;
OUTF = zeros(1,1);

for ii = 1:length(As); % i refersw to values of amplitude
    for jj = 1:length(GPTs); % j refers to values of frequency     
         %give the parameters a specific combination of values 
         A = As(1,ii)*L;
         GPT = GPTs(1,jj); 
         f = 1/GPT;
             
         filename=sprintf('ASymD_A%0.4f_GPT%04d.txt',As(1,ii),GPTs(1,jj))
         B = importdata(filename);
         size(B)
         a = round(linspace(1,29,10));
         for q = 6:10;a(1,q) = a(1,q) - 1;end
         for q1 = 1:10;b(1,q1) = a(1,q1) + 1;end

         if ~isempty(B);
         for k = 1:10   
             OUT(k,1) = As(1,ii);
             OUT(k,2) = GPTs(1,jj);
             OUT(k,3) = f;
             
             %Estimate slope
             
             y = [B(a(1,k),:)]';%gamma
             x = [B(b(1,k),:)]';%alpha
             
             m = length(x);
             X = [ones(m, 1) x];
             theta = (pinv(X'*X))*X'*y;
             
             % plot test
             % plot(x,y,'.','Markersize',24,'Color',[0 0 1])
             
             % Plot the fitted equation we got from the regression
             % hold on; % this keeps our previous plot of the training data visible
             % plot(X(:,2), X*theta, '-')
             % axis([0 max(A(a(1,k),:)) 0 max(A(a(1,k),:))]);
             
             % legend('Empirical data', 'Linear regression')
             % hold off % Don't put any more plots on this figure
             
             OUT(k,4) = theta(2,1);
         end
         count = count + 1
         OUTF(count,1) = As(1,ii)
         OUTF(count,2) = GPT
         OUTF(count,3) = mean(OUT(:,4));
         %hold on
         %semilogy(OUTF(count,1),OUTF(count,3),'.','Markersize',((GPT)/50)+17,'Color',[0 0 1])
         %pause
         end
         
         % Add a column of all ones (intercept term) to x
         % X = [ones(m, 1) x];
         % theta = (pinv(X'*X))*X'*y;

	% Plot the fitted equation we got from the regression
	% hold on; % this keeps our previous plot of the training data visible
	% plot(X(:,2), X*theta, '-')
	% legend('Empirical data', 'Linear regression')
	% hold off % Don't put any more plots on this figure
                              
         %fid = sprintf('ASymD_A%0.4f_GPT%04d',As(1,ii),GPTs(1,jj))
         %fid = fopen([fnam '.txt'],'a');  %Save Averages...
         %fprintf(fid,'%f %f %f\n',OUT(ii,1),OUT(ii,2),OUT(ii,3))
         %fclose(fid);    
    end   
end
        
   
     
