% Transform�e de Fourier inverse avec rotation pour centrer la fr�quence nulle
function result = ift(data)
result = fftshift(ifft(fftshift(data)));