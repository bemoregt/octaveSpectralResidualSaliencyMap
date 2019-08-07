
clc;
clear all;
close all;

pkg load image

% Read image from file
inImg = imread('defect36.png');
figure(1); imshow(inImg)
% Resize
inImg2= conv2(inImg(:,:,2), ones(5, 5)/25.0, "same");
inImg = imresize(inImg2, [128 128]);
% Log Amplitude
myFFT = fft2(inImg);
myLogAmplitude = log(abs(fftshift(myFFT)).+1);
% Get Phase
myPhase = angle(myFFT);
% get Residual of Spectral
mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
figure(2); imshow(mySpectralResidual)

% get Saliency Map
saliencyMap = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2;
%% After Effect
saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [10, 10], 2.5)));
figure(3);imshow(saliencyMap);
