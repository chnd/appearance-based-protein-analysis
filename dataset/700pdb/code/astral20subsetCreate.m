% this script is to generate a matlab file format that contains the multi-level class
path = './';
datasetlist = 'astral20.txt';

f = fopen([path '\' datasetlist],'r');
C = textscan(f,'%s %s %s %s %s %s','Delimiter',';');
% C{1} = sid
% C{2} = class
% C{3} = fold
% C{4} = super family
% C{5} = family
% C{6} = domain (part of the protein)
save('astral20.mat','C');

% class composition:
[b,i,j] = unique(C{2});
bn = histc(j,1:length(b));

% fold composition (59):
foldlist = {};
for i = 1:numel(C{2})
    foldlist{i} = [C{2}{i} C{3}{i}];
end
[b,i,j] = unique(foldlist);
bn = histc(j,1:length(b));

% take only the first five classes:
clist = cell2mat(C{2});
flist = [];
for i=1:numel(C{3})
    flist(i) = str2num(C{3}{i});
end
class1to5 = (clist<'f');

[b,i,j] = unique([clist(class1to5)-'e' flist(class1to5)']) ;
bn = histc(j,1:length(b));
sum(bn>10)

%%%%%%%%%%%%%%% class level%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% 100 proteins for each class%%%%%%%%%%%%%%%%%%
N=100;
[b,i,j] = unique(C{2});
bn = histc(j,1:length(b));
randomSelected = zeros(100,numel(bn));
classList = cell2mat(C{2}) - 'a' + 1;
classLabel = cell(1,numel(bn));
for i=1:numel(bn)
    classLabel{i} = find(classList==i);
end
RandomSeed = 1;
s = RandStream('mlfg6331_64','Seed',RandomSeed);
RandStream.setGlobalStream(s);
for i=1:numel(bn)
    tmp = randperm(bn(i));
    randomSelected(:,i) = sort(tmp(1:N),'ascend');
end
subsetList = zeros(1,N*numel(bn));
subsetLabel = zeros(1,N*numel(bn));
for i=1:numel(bn)
    subsetList(((i-1)*N)+1:(i*N)) = classLabel{i}(randomSelected(:,i));
    subsetLabel(((i-1)*N)+1:(i*N)) = i;
end
subsetC = cell(1,numel(subsetList));
f = fopen('./astral20subsetClass.txt','w+t');
for i=1:numel(subsetList)
    tmp = C{1}(subsetList(i));
    subsetC{i} = tmp{1};
    fprintf(f,'%s\n',subsetC{i});
end
fclose(f);
save('astral20subset.mat','subsetC','subsetList','subsetLabel');
%%%%%%%%%%%%%%%%%%%%%% fold level %%%%%%%%%%%%%%%%%%%%%%%%%

