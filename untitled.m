clear all
clc
%% Generating DTMF Tones signal
Fs = 8000; % sampling Frequency
N = 800; % Tones of 100 ms
% time vector
t = (0:N-1)/Fs;
% enter the DTMF Character
val = input('Insert the DTMF character \n','s');
% select frequency
if(val == '1')
    f1 = 697;
    f2 = 1209;
elseif(val == '4')
    f1 = 770;
    f2 = 1209;
elseif(val == '7')
    f1 = 852;
    f2 = 1209;
elseif(val == '2')
    f1 = 697;
    f2 = 1336;
elseif(val == '5')
    f1 = 770;
    f2 = 1336;
elseif(val == '8')
    f1 = 852;
    f2 = 1336;
elseif(val == '0')
    f1 = 941;
    f2 = 1336;
elseif(val == '3')
    f1 = 697;
    f2 = 1477;
elseif(val == '6')
    f1 = 770;
    f2 = 1477;
elseif(val == '9')
    f1 = 852;
    f2 = 1477;
elseif(val == '#')
    f1 = 941;
    f2 = 1477;
else
    f1 = 941;
    f2 = 1209;
end
% generate the tone
tone_1 = sin(2*pi*f1*t) + sin(2*pi*f2*t);
% plot the signal in discrete time domain
figure;
subplot 211
stem(t,tone_1)
xlabel('n')
ylabel('Amplitude')
% plot the signal in Frequency domain
dF = Fs/N;
f = -Fs/2:dF:Fs/2-dF;
fy = fftshift(fft(tone_1)); % compute FFT
subplot 212
plot(f,abs(fy)/N)
grid
xlabel('f')
ylabel('|Y(w)|')
%% save the data in a text file
dlmwrite('Tones.txt',tone_1)
%% write in audiofile
filename = 'Tones.wav';
audiowrite(filename,tone_1,Fs)
The output is shown below
Insert the DTMF character
6

clear all
clc
%% Read the audiofile
[y,fs] = audioread('Tones.wav');
% compute Fourier Trnasform
N = 800;
% compute frequeny spectrum
dF = fs/N;
f = -fs/2:dF:fs/2-dF;
fy = fftshift(fft(y)); % compute FFT
% detect peak
[pks,locs] = findpeaks(abs(fy(end/2:end)),'SortStr','descend','NPeaks',2);
% find the frequency value
fre = f(locs+length(f)/2-1);
% detect the DTMF character
if(fre(1,1) == 697)
    if(fre(1,2) >= 1200 && fre(1,2) <= 1230)
        data = '1';
    elseif(fre(1,2) >= 1300 && fre(1,2) <= 1380)
        data = '2';
    elseif(fre(1,2) >= 1450 && fre(1,2) <= 1500)
        data = '3';
    end
elseif(fre(1,1) == 770)
    if(fre(1,2) >= 1200 && fre(1,2) <= 1230)
        data = '4';
    elseif(fre(1,2) >= 1300 && fre(1,2) <= 1380)
        data = '5';
    elseif(fre(1,2) >= 1450 && fre(1,2) <= 1500)
        data = '6';
    end  
elseif(fre(1,1) == 852)
    if(fre(1,2) >= 1200 && fre(1,2) <= 1230)
        data = '7';
    elseif(fre(1,2) >= 1300 && fre(1,2) <= 1380)
        data = '8';
    elseif(fre(1,2) >= 1450 && fre(1,2) <= 1500)
        data = '9';
    end
else
    if(fre(1,2) >= 1200 && fre(1,2) <= 1230)
        data = '*';
    elseif(fre(1,2) >= 1300 && fre(1,2) <= 1380)
        data = '0';
    elseif(fre(1,2) >= 1450 && fre(1,2) <= 1500)
        data = '#';
    end
end
% display the output
disp('The inserted DTMF character is \n')
disp(data)

The output is
The inserted DTMF character is \n
6