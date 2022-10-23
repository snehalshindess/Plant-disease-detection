close all;
clear all;
clc
%pick an image
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
I = imread([pathname,filename]);
I = imresize(I,[256,256]);

% Conversion to grayscale
I_RGB = rgb2gray(I);
%figure, imshow(I_RGB);title('Grayscale');

%Histogram Equalization
j=histeq(I_RGB);
imhist(j);

%figure(2),imhist(I);title('Histogram'); % display the Histogram
n=imhist(I); % Compute the histogram
N=sum(n); % sum the values of all the histogram values
max=0; %initialize maximum to zero

for i=1:256
    P(i)=n(i)/N; %Computing the probability of each intensity level
end

for T=2:255      % step through all thresholds from 2 to 255
    w0=sum(P(1:T)); % Probability of class 1 (separated by threshold)
    w1=sum(P(T+1:256)); %probability of class2 (separated by threshold)
    u0=dot([0:T-1],P(1:T))/w0; % class mean u0
    u1=dot([T:255],P(T+1:256))/w1; % class mean u1
    sigma=w0*w1*((u1-u0)^2); % compute sigma i.e variance(between class)
    if sigma>max % compare sigma with maximum 
        max=sigma; % update the value of max i.e max=sigma
        threshold=T-1; % desired threshold corresponds to maximum variance of between class
    end
end

bw=im2bw(I,threshold/255); % Convert to Binary Image
%figure(3),imshow(bw);title('Black and white image'); % Display the Binary Image /black and white image

% Conversion to HSI
I_HIS = rgb2hsi(I);
%figure, imshow(I);title('HSI');

% Enhance Contrast
I_con = imadjust(I,stretchlim(I));
%figure,
%subplot(2, 3, 5);imshow(I);title('Contrast Enhanced');

figure,
subplot(2, 3, 1);imshow(I);title('Original image');
subplot(2, 3, 2);imhist(I);title('Histogram');
subplot(2, 3, 3);imshow(bw);title('Black and white image');
subplot(2, 3, 4);imshow(I_HIS);title('HSI');
subplot(2, 3, 5);imshow(I_con);title('Contrast Enhanced');
subplot(2, 3, 6);imshow(I_RGB);title('Grayscale');
subplot(2, 3, 7);imshow(j);title('histogram equalization');



