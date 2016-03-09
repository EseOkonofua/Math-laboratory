%Name: Ese Okonofua   SN:10107285      Date:3.3.2016
%In analysis of Biomedical data in order to find out which group is the one
%with arthritis vs the control group. We will use PCA to find the group
%with more covariance. The group with more covariance will be assumed to be
%the group with arthritis given that the control group would be assumed to
%be least varied. 


%Load Biomedical data
load z1.dat;
load z2.dat;

%Run preliminiary PCA calculations to find Eigenvalues, Eigenvectors and
%Mean Vectors of the loaded data.
[EVALVECZ1, MEANVECZ1, EVECMATZ1] = pcaprelim(z1);
[EVALVECZ2, MEANVECZ2, EVECMATZ2] = pcaprelim(z2);

%start at 1 for k values
k1 = 1;
k2 = 1;

%calculate coverage for first data set
tZ1k = @(k) sum(EVALVECZ1(1:k,1));
tZ1m = sum(EVALVECZ1);

pZ1= tZ1k(k1)/tZ1m;

%calculate coverage for second data set
tZ2k = @(k) sum(EVALVECZ2(1:k,1));
tZ2m = sum(EVALVECZ2);

pZ2= tZ2k(k2)/tZ2m;

%Find valid K1 value for the first data set z1
while pZ1 < 0.93 
    k1= k1+1;
    pZ1= tZ1k(k1)/tZ1m;
end
if pZ1 > 0.93 %if proportion of coverage gets higher than 93% then go back one k value
    k1 = k1-1;
end

%Find valid K2 value for the second data set z2
while pZ2 < 0.93
    k2= k2+1;
    pZ2= tZ2k(k2)/tZ2m;
end
if pZ2 > 0.93 %if proportion of coverage gets higher than 93% then go back one k value
   k2 = k2-1; 
end


figure %Create progression figure showing change when adding eigenvectors for z1
subplot(2,2,1)
plot(1:101,z1(:,3),'r')
title('Original z1 col3 signal')
xlabel('Samples')
ylabel('Knee motion angles')
for i=1:k1 %Loop through all k additions and plot the approximate derived vector
    [APPROXCOMPZ1, APPROXVECZ1]= pcaapprox(z1(:,3),i,MEANVECZ1,EVECMATZ1);
    subplot(2,2,i+1)
    plot(1:101,APPROXVECZ1,'b')
    title(strcat('z1 col3 Reconstructed signal with k = ',int2str(i)))
    xlabel('Samples')
    ylabel('Knee motion angles')
end


figure %Create progression figure showing change when adding eigenvectors for z2
subplot(2,2,1)
plot(1:101,z2(:,3),'r')
title('Original z2 col3 signal')
xlabel('Samples')
ylabel('Knee motion angles')
for i=1:k2 %Loop through all k additions and plot the approximate derived vector
    [APPROXCOMPZ2, APPROXVECZ2]= pcaapprox(z2(:,3),i,MEANVECZ2,EVECMATZ2);
    subplot(2,2,i+1)
    plot(1:101,APPROXVECZ2,'b')
    title(strcat('z2 col3 Reconstructed signal with k = ',int2str(i)))
    xlabel('Samples')
    ylabel('Knee motion angles')
   
end

%In analysis of figure 1 and figure 2 I make an observation that z2
%requires at least k = 2 to become very identitical to the original signal
%point contrary to z1 data which approximately has the same shape with k=1
%through k = 3. This leads me to conclude that z2 has more variance within
%the data set. In order to conclude this more I will find the average 
%of reconstruction errors in the data, plot and make a conclusion:


% Initialize empty variables to hold reconstructed signal values 
z1_diff =[] ;
z2_diff = [];



for i=1:30 %loop through each signal getting their reconstructions and then finding the reconstruction error from the original signal
    [APPROXCOMPZ1, APPROXVECZ1]= pcaapprox(z1(:,i),k1,MEANVECZ1,EVECMATZ1);
    z1_diff = [z1_diff (abs(z1(:,i) - APPROXVECZ1))]; 

    [APPROXCOMPZ2, APPROXVECZ2]= pcaapprox(z2(:,i),k2,MEANVECZ2,EVECMATZ2);
    z2_diff = [z2_diff (abs(z2(:,i) - APPROXVECZ2))]; 
end

figure % Create figure comparing the difference in the reconstruction of z1 and z2
plot(1:30,sum(z1_diff),'r',1:30,sum(z2_diff),'b')
title('Sum of z1 reconstruction errors compared to Sum of z2 reconstruction errors')
legend('z1 recon. errors','z2 recon. errors')
xlabel('Signals')
ylabel('Value of reconstruction error')


%Get averages from derived difference matrices
z1_diff_avg = mean(z1_diff,2);
z2_diff_avg = mean(z2_diff,2);

%Then calculate the sum to see the difference in the reconstruction errors
z1_diff_avg_sum = sum(z1_diff_avg);
z2_diff_avg_sum = sum(z2_diff_avg);



