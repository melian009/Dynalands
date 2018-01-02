%----------------------------------------------------------
%Neutral metacommunities on ice landscape dynamics 
%Input ice cover (P/A matrices)
%Charles N. de Santana & Carlos J. Melian, EAWAG Sept 2013
%----------------------------------------------------------
rand('seed',sum(100*clock));

%Landscape
%files = dir('*.mat15');%input file P-A matrix
%for i=1:length(files)
%eval(['load ' files(i).name ' -ascii'])
%end 
%W = load(files(i).name);
n=5000;W=eye(n);rix=randperm(n);W=W(rix,:);

%Components
%[blocks,dag] = components(W);%number components is a function of ice threshold
%AT = sort(blocks);
%extantblocks = [ find(AT(1:end-1) ~= AT(2:end)) length(AT) ];
%NB = AT(extantblocks);%number of blocks
%abup = diff([0 extantblocks]);abup = sort(abup,'descend');%abundance of each block

%Initial conditions
nruns = 10000;%number runs
%How to set-calculate distance between each pair of blocks? Here
%distance matrix D = cumsum(D,2);
J = round(100*abup);%Number individuals per block function of block size (K)?

%Metacommunity dynamics; Birth-death randomly selected block
for rr = 1:nruns;G = round(unifrnd(30,100,1,1));%number generations per run
    newspecies = 1;R = ones(length(NB),J(1,1));%number individuals per block
    m = unifrnd(0.001,0.1,1);%migraion from the blocks
    v = unifrnd(0.0001,0.01,1);%regional migration?
    for i = 1:G;
        for j = 1:sum(J);
            KillHab = unidrnd(S);KillInd = unidrnd(J);
            mvb = unifrnd(0,1);
            if mvb <= mr;MigrantHab = unifrnd(0,max(D(KillHab,:)));
               for k = 1:S;
                   if D(KillHab,k) >= MigrantHab;MigrantInd = unidrnd(J);
                      R(KillHab,KillInd) = R(k,MigrantInd);
                   end
                   break
               end
            elseif mvb > mr & mvb <= mr+vr;newspeciesR = newspeciesR + 1;
               R(KillHab,KillInd) = newspeciesR;                                       
            else
               BirthLocal = unidrnd(J);
               if BirthLocal ~= KillInd;
                  R(KillHab,KillInd) = R(KillHab,BirthLocal);
               end
            end
        end%SJ
   end%G
  
%Outputs: Check matrix R for each replicate. How many species per block (alpha
%richness) and per metacommunity (gamma richness)? Store these two
%outputs and parameter combination run

%Geographic distance matrix
%here output for matrix
%Parameter combination per run
%fid = fopen('ParameterOutputs.txt','a');
%fprintf(fid,'%3f %3f %3f %3f %3f %3f\n',m,v,length(NB),G,GammaRichness...);fclose(fid);
end

