function [M] = bitsconverter(x)
x=x.'; %take transpose
M=zeros(numel(x)/2,2); 
    for k=1:numel(x)/2
        M(k,:)=[x(2*k-1) x(2*k)];
    end
end
