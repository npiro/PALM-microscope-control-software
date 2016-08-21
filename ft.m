% Transformée de Fourier avec rotation pour centrer la fréquence nulle
function result = ft(data)
result = fftshift(fft(fftshift(data)));