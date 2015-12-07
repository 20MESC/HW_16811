
%// Your example
X = {-2, 3', 3};
Y = {2, 4, -1};
Z = [1 2 3];

%// Call unique and get the unique entries
chars = unique([X Y], 'stable')

%// Create containers.Map
map = containers.Map(chars, 1:numel(chars));

%// Find the IDs for each of X and Y
idX = cell2mat(values(map, X)).';
idY = cell2mat(values(map, Y)).';

%// Create sparse matrix
A = sparse([idX; idY], [idY; idX], [Z; Z]);

