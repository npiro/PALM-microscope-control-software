% Transform�e de Fourier avec rotation pour centrer la fr�quence nulle
function result = ft(data)
result = fftshift(fft(fftshift(data)));