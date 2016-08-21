function transform = ft2(signal)

transform = fftshift(fft2(fftshift(signal)));