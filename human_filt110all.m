function allfields = human_filt110all(data)
  %filters data from 1-10hz if data is in matrix

allfields = [];
for i=1:size(data,1)
  x = data(i,:);
  y = human_filt110(x);
  allfields = [allfields;y];
end
