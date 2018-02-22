%A = fopen('Sym_A 0.4000_GPT1000.txt_migr_events.dat');
%A = A(1,:,:)
%pause
B = unique(A,'rows');
[tf1, idx] = ismember(A,B,'rows');            
y = accumarray(idx(:),1);
%y'
count = 0;
for i = 1:length(B);
    if B(i,1) ~= B(i,2);
    i;
       wij = find(B(:,1) == B(i,1) & B(:,2) == B(i,2));
       wji = find(B(:,1) == B(i,2) & B(:,2) == B(i,1));
       B(wij,:);
       B(wji,:);
       %pause
       %y(wij,:)
       %y(wji,:)
       if ~isempty(B(wji,:)); 
       count = count + 1;
       ASY(count,1) = abs(y(wij,:) - y(wji,:));
       end
       %pause
    end
end
Q = sort(ASY,'descend');
V = 1:length(Q);
plot(V,Q)