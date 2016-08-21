function transform = ift2(signal)

transform = fftshift(ifft2(fftshift(signal)));
