function [params,Toeplitz_matrix]=Toeplitz_matrix(centroids,X, params,R,S) 
% R and S repreesent the maximum left and right shifts
% The value of R and S correspond to the r,s in the equation (5) (6)in the paper
% centroids repreesent Cluster center points
% The value of Toeplitz_matrix is equal to toeplitz matrix W in the equation(4) in the paper
% X is spike segment to be classified after peak detection
dic_sublen=params.dic_sublen;
dic_addlen=params.dic_addlen;
for i=1:size(centroids,2)
    figure(i);
    plot(centroids(:,i));
end

%% Neruon 1 
sTmp=centroids(:,1)';
figure(1);
plot(sTmp);
s=[zeros(1,length(sTmp)) sTmp zeros(1,length(sTmp))];

figure(2);
plot(s);

N=length(sTmp); 
    for i=1:N
        S1(i,:)=s(2*N+i-dic_sublen:-1:i+1+dic_addlen);
    end
template1=S1;


%% Neruon 2 
J=j;
sTmp=centroids(:,2)';
figure(2+J+1);
plot(sTmp);
s=[zeros(1,length(sTmp)) sTmp zeros(1,length(sTmp))];

figure(2+J+2);
plot(s);

N=length(sTmp);
    for i=1:N
        S2(i,:)=s(2*N+i-dic_sublen:-1:i+1+dic_addlen);
    end
template2=S2;


%% Neruon 3 
sTmp=centroids(:,3)';

figure(2+J+1);
plot(sTmp);
s=[zeros(1,length(sTmp)) sTmp zeros(1,length(sTmp))];

N=length(sTmp);
    for i=1:N
        S3(i,:)=s(2*N+i-dic_sublen:-1:i+1+dic_addlen);
    end

template3=S3;
centroids_len=length(centroids);

%% Construction process of toeplitz matrix, corresponding to equation (4) to (6) in the paper
Toeplitz_matrix=[template1 template2 template3];
template1=Toeplitz_matrix(:,(((centroids_len+1)-R(1,1)):((centroids_len+1)+S(1,1)-1)));
template2=Toeplitz_matrix(:,(((3*centroids_len+1)-R(1,2)):((3*centroids_len+1)+S(1,2)-1)));
template3=Toeplitz_matrix(:,(((5*centroids_len+1)-R(1,3)):((5*centroids_len+1)+S(1,3)-1)));
Toeplitz_matrix=[Toeplitz_matrix(:,(((centroids_len+1)-R(1,1)):((centroids_len+1)+S(1,1)-1)))...
Toeplitz_matrix(:,(((3*centroids_len+1)-R(1,2)):((3*centroids_len+1)+S(1,2)-1)))...
Toeplitz_matrix(:,(((5*centroids_len+1)-R(1,3)):((5*centroids_len+1)+S(1,3)-1)))];
    
params.template1=template1;
params.template2=template2;
params.template3=template3;   
params.X=X;





