function output = defocusSimu(limitWidth_m,aberration,angle_deg,force)

nmToPixel = 1/5.0;
range = 1000*nmToPixel;
x = 1:range;
limitWidth = limitWidth_m*nmToPixel;

dlResponse = generateGaussianPSF(range,[range/2 range/2],[limitWidth limitWidth]);

% adding a wanted phase mask and computing the result on the image
ray = 400/1000;
phaseMask = getZernMask(aberration,range,ray,angle_deg,force,'quiet');

phaseFactor = exp(1i.*phaseMask);

dlResponse_FT = ft2(dlResponse);
aberratedResponse_FT = dlResponse_FT.*phaseFactor;

defocusRange = -20:19;
for i=1:40;
   defocusMask = getZernMask('tilt',range,ray,angle_deg,10*defocusRange(i),'quiet');
   defocusFactor = exp(1i.*defocusMask);
   defocusedResponse_FT = aberratedResponse_FT.*defocusFactor;
   defocusedResponse = ift2(defocusedResponse_FT);
   figure(404)
   axes1 = axes('position',[0.01 0.01 0.99 0.99]);
   imshow(defocusedResponse.*conj(defocusedResponse),'Parent',axes1), grid on;
end

end