 %Create matrices using euclidean distance and connectivity threshold
 S = 100;
 L = 1000;
 n = unifrnd(0,L,S,2); %positions of sites
 Di = zeros(S,S);           
 
              for i = 1:S-1,
                for j = i+1:S,
                  A = (n(i,1) - n(j,1))^2;%Euclidean distance
                  B = (n(i,2) - n(j,2))^2;
                  d(i,j) = sqrt(A + B);
                  Di(i,j) = 1/d(i,j);     
 %                 if d(i,j) < r;%threshold
 %                    D(i,j) = 1;
 %                 else
 %                    D(i,j) = 0;
 %                 end
                end
              end
              
              A = Di+Di';
              Af = sinkhornKnopp(A)
