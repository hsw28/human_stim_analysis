function f = human_freq(signal)
  %makes graphs of present frequencies

Fs = 2000;
transforms = zeros(2549,1);
    data = signal';
    avg = mean(data);
    data = data - avg;
    L = 5096;
    Y = fft(data,L);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    transforms = transforms + P1;
freq = Fs*(0:(L/2))/L;
avg_transform = [freq',transforms];
plot(freq,transforms);
ylabel('Power (au)')
xlabel('Frequency')
