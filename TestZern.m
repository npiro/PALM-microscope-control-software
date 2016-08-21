       % Display the first 10 Zernike functions
       x = -1:0.01:1;
       [X,Y] = meshgrid(x,x);
       [theta,r] = cart2pol(X,Y);
       idx = r<=1;
       z = nan(size(X));
       n = [0  1  1  2  2  2  3  3  3  3];
       m = [0 -1  1 -2  0  2 -3 -1  1  3];
       Nplot = [4 10 12 16 18 20 22 24 26 28];
       y = zernfun(n,m,r(idx),theta(idx));
       figure('Units','normalized')
       for k = 1:10
           z(idx) = y(:,k);
           subplot(4,7,Nplot(k));
           pcolor(x,x,z), shading interp
           set(gca,'XTick',[],'YTick',[])
           axis square
           title(['Z_{' num2str(n(k)) '}^{' num2str(m(k)) '}'])
       end