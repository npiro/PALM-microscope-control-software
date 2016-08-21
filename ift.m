% Transformée de Fourier inverse avec rotation pour centrer la fréquence nulle
function result = ift(data)
result = fftshift(ifft(fftshift(data)));