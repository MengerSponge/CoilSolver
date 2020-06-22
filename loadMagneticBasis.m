fid=fopen('MagneticBasis.txt');
tline = fgetl(fid);
basisl = cell(0,1);
while ischar(tline)
    basisl{end+1,1} = tline;
    tline = fgetl(fid);
end
fclose(fid);

basis = cell(0,1);

maxl = length(basisl);

for l = 1:maxl
    basis{l,1} = split(basisl{l}(2:end-1),', ');
end
