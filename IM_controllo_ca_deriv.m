function [fi u] = IM_controllo_ca_deriv(A,Y,sc,voltage_max)
% function [fi u] = controllo_ca_deriv(A,Y,sc,voltage_max)

size_A = size(A);
n_ch = size_A(2);
size_Y = size(Y);
z = reshape(Y,sqrt(size_Y(1)),sqrt(size_Y(1)));
size_z = size(z);

Y_zer = Y;
Y_nan = Y;
A_zer = A;
A_nan = A;

Y_nan(Y_nan==0)=NaN;
A_nan(A_nan==0)=NaN;

%sottocampiono la superficie da riprodurre
if sc==1
    [x,y] = meshgrid(1:1:size_z(1));
    [xi,yi] = meshgrid(2:13:size_z(1));
    zi = interp2(x,y,reshape(Y,size_z(1),size_z(1)),xi,yi);
    %figure('Name', ['Superficie sottocampionata'], 'Tag','sottocampiono', 'NumberTitle', 'off');
    %hhh = surf(xi,yi,zi);
    size_z_sc = size(zi);
    Y_sc = reshape(zi,size_z_sc(1)*size_z_sc(2),1);
    for i=1:n_ch
        A_fig = reshape(A(:,i),size_z(1),size_z(1));
        A_fig_sc = interp2(x,y,A_fig,xi,yi);
        A_sc(:,i) = reshape(A_fig_sc,size_z_sc(1)*size_z_sc(2),1);
    end
    Y_sc_zer = Y_sc;
    Y_sc_nan = Y_sc;
    A_sc_zer = A_sc;
    A_sc_nan = A_sc;
    
else
        
    Y_sc_zer = Y;
    Y_sc_nan = Y;
    A_sc_zer = A;
    A_sc_nan = A;    
    size_z_sc = size_z;
end

% Costruisco la superficie e la matrice di interazione eliminando gli zeri
% e mettendo Nan in quanto considerando gli zeri ho delle discontinuità
% fuori dalla pupilla e quindi un gradiente elevato!
Y_sc_nan(Y_sc_nan==0)=NaN;
A_sc_nan(A_sc_nan==0)=NaN;

% Calcolo del gradiente per la matrice di interazione e per la superficie
% da riprodurre --> Y = A*u --> dY = dA*u
[dY_x,dY_y] = gradient(reshape(Y_sc_nan,size_z_sc(1),size_z_sc(1)),1);
dY_nan = [reshape(dY_x,size_z_sc(1)*size_z_sc(2),1);reshape(dY_y,size_z_sc(1)*size_z_sc(2),1)];
for i=1:n_ch
    A_nan_superficie(:,:,i) = reshape(A_sc_nan(:,i),size_z_sc(1),size_z_sc(1));
    [dA_x(:,:,i), dA_y(:,:,i)] = gradient(A_nan_superficie(:,:,i));
    dA_nan(:,i) = [reshape(dA_x(:,:,i),size_z_sc(1)*size_z_sc(2),1); reshape(dA_y(:,:,i),size_z_sc(1)*size_z_sc(2),1)];
end

dY_zer = dY_nan;
dA_zer = dA_nan;

dY_zer(isnan(dY_zer))=0;
dA_zer(isnan(dA_zer))=0;

if 0
    for i=1:n_ch
        i 
        figure(3001),subplot(8,8,i), pcolor(reshape(A_nan(:,i),size_z_sc(1),size_z_sc(1)));shading interp, axis off
        figure(3002),subplot(8,8,i), pcolor(reshape(dA_nan(1:size_z_sc(1)*size_z_sc(2),i),size_z_sc(1),size_z_sc(1)));shading interp, axis off
        figure(3003),subplot(8,8,i), pcolor(reshape(dA_nan(11450:22898,i),size_z_sc(1),size_z_sc(1)));shading interp, axis off
    end
end

opts = optimset('Display','final','TolFun',1e-50,'Jacobian','on','LargeScale','on','Diagnostics','on');
[u,resnorm,residual,exitflag,output,lambda] = lsqlin(dA_zer,dY_zer,[ ],[ ],[ ],[ ],0*ones(n_ch,1),5*ones(n_ch,1),[],opts);
exitflag
fi = A_zer*u;

%[dfi_x,dfi_y] = gradient(reshape(fi,size_z(1),size_z(1)),1);
%dfi_nan = [reshape(dfi_x,size_z(1)*size_z(2),1);reshape(dfi_y,size_z(1)*size_z(2),1)];

end