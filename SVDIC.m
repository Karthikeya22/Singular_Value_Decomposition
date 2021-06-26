close all
clear all
clc
image = imread('plane.jpg');
grayimage = rgb2gray(image);
imageD=double(grayimage);
%The above steps are used to read an image and to convert the image to gray scale and to store the converted image inta a class double.
%now lets decompose the image matrix by using singular value decomposition
[U,S,V] = svd(imageD);
%now lets use different singular values and reconstruct our image
DisplayError = [];
NoOfSingularValues = [];
for N = 10:30:100
  %now lets store the in an another variable temporarly
  C = S;
  %now let us eliminate the singular values which are not required for the compression
C(N+1:end,:)=0;
C(:,N+1:end)=0;
% Now let us construct the image using the reduced singular values
M = U*C*V';
% now lets display the computed error
figure;
out = sprintf('Image output using %d singular values', N)
imshow(uint8(M));
title(out);
error=sum(sum((imageD-M).^2));
%now let us store the values to displayend
DisplayError = [DisplayError; error];
NoOfSingularValues = [NoOfSingularValues; N];
end
