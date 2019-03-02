% Middle East Technical University EE430 Project 
% Enes Berk Karahançer 

recObj = audiorecorder(44100,16,1); %audiorecording
a = 6; %parameter that change the duration
duration = 7*a+1;
recordblocking(recObj, duration); %after 'duration' stop recording
disp('End of recording.');

X = getaudiodata(recObj); %signal that received

sampling_frequency=44100;
L=numel(X); %length of the signal
f = sampling_frequency*(0:(L/2))/L;

[s,fk,t,ps]=spectrogram(X,hamming(2^13),2^10,f,sampling_frequency,'yaxis');

s_magnitude=abs(s);
f_matrix = zeros(1,duration-1);
fk_matrix= zeros(1,duration-1);
code_frequency = zeros(1,duration-1);

for k=1 : duration-1
    s_max = s_magnitude(:,6*k);
    f_number = find(s_max==max(s_max));
    f_matrix(k) =round( f(f_number) , -1);
    fk_matrix(k) = round (fk(f_number), -1);
    code_frequency(k) = (fk_matrix(k)==F1_f0)*f0 + (fk_matrix(k)==F1_f1)*f1 + (fk_matrix(k)==F1_f2)*f2 + (fk_matrix(k)==F1_f3)*f3 + (fk_matrix(k)==F2_f0)*f0 + (fk_matrix(k)==F2_f1)*f1 + (fk_matrix(k)==F2_f2)*f2 + (fk_matrix(k)==F2_f3)*f3 + (fk_matrix(k)==F3_f0)*f0 + (fk_matrix(k)==F3_f1)*f1 + (fk_matrix(k)==F3_f2)*f2 + (fk_matrix(k)==F3_f3)*f3;
    x = (code_frequency(k)==f0)*[0 0] + (code_frequency(k)==f1)*[0 1] + (code_frequency(k)==f2)*[1 0]+ (code_frequency(k)==f3)*[1 1] ;
    if k==1
        code = x;
    else
        code=horzcat(code,x);
    end
end

sentence =vec2mat(code, 7) ;

sentence_update = fliplr(sentence);
binary_sentence = bi2de(sentence_update);
char_sentence = char(binary_sentence);




