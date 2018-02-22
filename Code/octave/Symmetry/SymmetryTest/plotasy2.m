load('Sym_A0.1000_GPT0001.txtmigsym.dat');
B = unique(Pairs(:,1:2),'rows');
count = 0;
for i = 1:length(B);
    if B(i,1) ~= B(i,2);
       wij = find(B(:,1) == B(i,1) & B(:,2) == B(i,2));
       wji = find(B(:,1) == B(i,2) & B(:,2) == B(i,1));
       %B(wij,:)
       %B(wji,:)

       Wij = find(Pairs(:,1) == B(wij,1) & Pairs(:,2) == B(wij,2));
       %Pij = Trios(Wij(1,1),3);
       
       Wji = find(Pairs(:,1) == B(wji,1) & Pairs(:,2) == B(wji,2));
       %Pji = Trios(Wji(1,1),3); 
       count = count + 1;
       ASY(count,1) = abs(length(Wij) - length(Wji));
       %pause
    end
end
Q = sort(ASY,'descend');
V = 1:length(Q);
plot(V,Q)


%https://stackoverflow.com/questions/42885892/find-a-pair-of-numbers-in-a-matrix-in-matlab
%Assuming, you want to find the rows of A which contain the exact pairs given in b,
%this is how you can do it without a loop:

% Create a matrix of pairs in A
%pairs = cat(3, Trios(:, 1:end-1), Trios(:, 2:end));

% Reshape b to use bsxfun
%B = reshape(B', [1 1 size(B')]);

%indices =  all( bsxfun(@eq, pairs, B), 3) | all( bsxfun(@eq, pairs, flip(B,3)), 3);

%row_indices = find(squeeze(any(any(indices,4),2)));