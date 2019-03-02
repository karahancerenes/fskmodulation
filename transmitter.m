% Middle East Technical University EE430 Project 
% Enes Berk Karahançer 

clc
clear all
close all
fprintf('Test signal is being sent \n');

sampling_frequency=44100;
len=0.8;
t  = linspace(0, len, sampling_frequency*len); 
f0=0;
f1=200;
f2=400;
f3=600;
F1=1000;
F2=1800;
F3=2600;

test_signal=20*horzcat(sin(2*pi*(F1+f0)*t),zeros(1,numel(t)/4),sin(2*pi*(F1+f1)*t),zeros(1,numel(t)/4),sin(2*pi*(F1+f2)*t),zeros(1,numel(t)/4),sin(2*pi*(F1+f3)*t),zeros(1,numel(t)/4),sin(2*pi*(F2+f0)*t),zeros(1,numel(t)/4),sin(2*pi*(F2+f1)*t),zeros(1,numel(t)/4),sin(2*pi*(F2+f2)*t),zeros(1,numel(t)/4),sin(2*pi*(F2+f3)*t),zeros(1,numel(t)/4),sin(2*pi*(F3+f0)*t),zeros(1,numel(t)/4),sin(2*pi*(F3+f1)*t),zeros(1,numel(t)/4),sin(2*pi*(F3+f2)*t),zeros(1,numel(t)/4),sin(2*pi*(F3+f3)*t), zeros(1,numel(t)/4));
sound(test_signal,44100); %firstly, test signal is transmitted in order to introduce carrier frequencies to receiver side 

while (true)
    tText=input('Type the text to be transmitted: ', 's');
    if strcmp(tText,'break')
        break
    end
    
    if mod(numel(tText),2)
        tText=strcat(tText, '.');
    end
    
    tTextBinary=dec2bin(tText);
    twoBits=bitsconverter(tTextBinary);
    
    for k=1:numel(twoBits)
        if twoBits(k)>45
            twoBits(k)=twoBits(k)-48;
        end
    end
    
    for k=1:numel(twoBits)/2
        symbol=twoBits(k,:);
    
        Frekans=1000+(randi(3)-1)*800;
  
        t  = linspace(0, len, sampling_frequency*len);  
        signalPartA = isequal(symbol,[0 0])*sin(2*pi*(Frekans+f0)*t)+isequal(symbol,[0 1])*sin(2*pi*(Frekans+f1)*t)+isequal(symbol,[1 0])*sin(2*pi*(Frekans+f2)*t)+isequal(symbol,[1 1])*sin(2*pi*(Frekans+f3)*t);
        signalPart=horzcat(signalPartA,zeros(1,numel(t)/4)); %binary to data frequency 
   
        if k==1
            signal=signalPart; 
        else
            signal = horzcat(signal, signalPart);
        end
    end
        
    x=20*signal;
    sound(x,44100);
    
end
