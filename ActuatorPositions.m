load influence_matrix.mat;

for i=1:32
    infmat = reshape(influence_matrix(:,i),120,120);
    [maxRow rowInd] = max(infmat); % Get maximum intensity;
    [~, colInd] = max(maxRow);
    X(i) = colInd;
    Y(i) = rowInd(colInd);
end
save ActuatorPosition.mat X Y;
