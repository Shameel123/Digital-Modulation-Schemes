% <<<<<<<<<<<<<<<<<<<< Modulation and Demodulation >>>>>>>>>>>>>>>>>>>>
clc, clear all, close all;
% ******************* Digital/Binary input information ********************
x = input('Enter Digital Input Information = ');   % Binary information as stream of bits (binary signal 0 or 1)
N = length(x);
Tb = 0.0001;   %Data rate = 1MHz i.e., bit period (second)
nb = 100;   % Digital signal per bit
t1 = Tb/nb:Tb/nb:Tb*N;   % Time period
t2 = Tb/nb:Tb/nb:Tb;   % Signal time   
% ************* Represent input information as digital signal *************

digit = []; 
for n = 1:1:N
    if x(n) == 1;
       sig = ones(1,nb);
    else x(n) == 0;
        sig = zeros(1,nb);
    end
     digit = [digit sig];
end

figure('Name','Modulation and Demodulation','NumberTitle','off');
subplot(3,1,1);
plot(t1,digit,'LineWidth',2.5);
grid on;
axis([0 Tb*N -0.5 1.5]);
xlabel('Time(Sec)');
ylabel('Amplitude(Volts)');
title('Digital Input Signal');
% **************************** Modulation *****************************
br = 1/Tb;       % Bit rate
Fc1 = br*10;     % Carrier frequency for binary input '1'
Fc2 = br*5;      % Carrier frequency for binary input '0'
c1 = cos(2*pi*Fc1*t2);      % carrier signal for binary value '1'
c2 = cos(2*pi*Fc2*t2);      % carrier siignal for binary value '0'
mod = [];
for (i = 1:1:N)
    if (x(i) == 0)
        y = c1   % Modulation signal with carrier signal 1
    else
        y = c2   % Modulation signal with carrier signal 2
    end
    mod = [mod y];
end

subplot(3,1,2);
plot(t1,mod);
xlabel('Time(Sec)');
ylabel('Amplitude(Volts)');
title('Modulated Signal');
% ********************* Transmitted signal x ******************************
x = mod;
% ********************* Received signal y *********************************
y = x  % Assuming No Channel Impairments, Recieved Signal = Transmitted Signal
% *************************** Demodulation ****************************
s = length(t2);
demod = [];
for n = s:s:length(y)
  if(y(n-1) == c1(nb-1))
      a = 0
  else
      a = 1
  end
  demod = [demod a]
end
disp('Demodulated Binary Information at Receiver: ');
disp(demod);
% ********** Represent demodulated information as digital signal **********
digit = [];
for n = 1:length(demod);
    if demod(n) == 1;
       sig = ones(1,nb);
    else demod(n) == 0;
        sig = zeros(1,nb);
    end
     digit = [digit sig];
end
subplot(3,1,3)
plot(t1,digit,'LineWidth',2.5);grid on;
axis([0 Tb*length(demod) -0.5 1.5]);
xlabel('Time(Sec)');
ylabel('Amplitude(Volts)');
title('Demodulated Signal');
% ************************** End of the program ***************************

