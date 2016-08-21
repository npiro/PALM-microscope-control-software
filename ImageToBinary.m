function [BImage] = ImageToBinary(filename)

im=double(imread(filename));
MaxI = double(max(im(:)));
MinI = double(min(im(:)));
threshold=0.5*(MaxI+MinI)/MaxI
BImage = im2bw(double(im)/MaxI,threshold);
subplot(2,1,1);
image(im);
axis image;
subplot(2,1,2);
imshow(BImage);
axis image;
colormap jet