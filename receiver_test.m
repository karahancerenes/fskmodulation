% Middle East Technical University EE430 Project 
% Enes Berk Karahançer 

recObj = audiorecorder(44100,16,1);
duration = 20;
recordblocking(recObj, duration);
disp('End of recording.');

X = getaudiodata(recObj);

sampling_frequency=44100;
L=numel(X);
f = sampling_frequency*(0:(L/2))/L;

[s,fk,t,ps]=spectrogram(X,hamming(2^13),2^10,f,sampling_frequency,'yaxis');
 
s_magnitude=abs(s);
f_matrix = zeros(1,duration);
fk_matrix= zeros(1,duration); % frequency matrix

for k=1 : duration-1
    s_max = s_magnitude(:,6*k);
    f_number = find(s_max==max(s_max));
    f_matrix(k) =round( f(f_number) , -1);
    fk_matrix(k) = round (fk(f_number), -1);
    
end

A = [1 0 0 1 0 0 0 ; 1 0 0 0 1 0 0;1 0 0 0 0 1 0; 1 0 0 0 0 0 1;
     0 1 0 0 1 0 0; 0 1 0 0 0 1 0; 0 0 1 0 0 1 0; 0 0 1 0 0 0 1 ];

B = horzcat(fk_matrix(1:4), fk_matrix(6:7), fk_matrix(11:12)) ;
B_new = B.';

Frequencies = round(linsolve(A,B_new)); % frequency equations solver
F1 = Frequencies(1);
F2 = Frequencies(2);
F3 = Frequencies(3);
f0 = Frequencies(4);
f1 = Frequencies(5);
f2 = Frequencies(6);
f3 = Frequencies(7);


F1_f0=F1+f0;
F1_f1=F1+f1;
F1_f2=F1+f2;
F1_f3=F1+f3;
F2_f0=F2+f0;
F2_f1=F2+f1;
F2_f2=F2+f2;
F2_f3=F2+f3;
F3_f0=F3+f0;
F3_f1=F3+f1;
F3_f2=F3+f2;
F3_f3=F3+f3;
