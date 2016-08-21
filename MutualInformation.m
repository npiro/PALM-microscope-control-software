function [MI] = MutualInformation(H,Hp)

H = H./sum(H(:));
Hp = Hp./sum(Hp(:));
% Intensity bins
ibins = linspace(0,max(max(H(:),max(Hp(:)))),30);

% Calculate joint probability
PHHp = histcn([H(:) Hp(:)],ibins,ibins); PHHp  = PHHp (1:29,1:29);
PH = repmat(sum(PHHp,1),size(PHHp,1),1);
PHp = repmat(sum(PHHp,2),1,size(PHHp,2));
tH=min(max(PH(:))*.5,.1);
tHp=min(max(PHp(:))*.5,.1);
tHHp=min(max(PHHp(:))*.5,.1);
sel=PH>tH & PHp>tHp & PHHp>tHHp;
MI = sum(sum(PHHp(sel) .* log(PHHp(sel)./PH(sel)./PHp(sel)), 1),2);