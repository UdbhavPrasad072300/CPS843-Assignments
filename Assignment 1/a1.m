% CPS 843 Assignment 1
% Udbhav Prasad - 500909034

% -----------------------Question 1-----------------------

img_color = imread('./images/eldenring.jpg');

img_grayscale = rgb2gray(img_color);
imwrite(img_grayscale, './outputs/eldenring_grayscale.jpg');

% Log Transformation

a = double(img_grayscale)/255;
c = 1;
img_log = c * log(1 + (a));
imwrite(img_log, './outputs/eldenring_log_transform.jpg');

% Inverse Log Transformation

a = double(img_grayscale);
c = 1;
img_inverse_log = c * 1./log(a);
imwrite(img_inverse_log, './outputs/eldenring_inverse_log_transform.jpg');

% Power Law Transformation

a = double(img_grayscale)/255;
gamma = 0.3;
c = 1;
img_power_law_1 = c * (a .^ gamma);
gamma = 3.0;
img_power_law_2 = c * (a .^ gamma);
imwrite(img_power_law_1, './outputs/eldenring_power_law_1.jpg');
imwrite(img_power_law_2, './outputs/eldenring_power_law_2.jpg');

% -----------------------Question 2-----------------------

b1 = double(bitget(img_grayscale, 1));
b2 = double(bitget(img_grayscale, 2));
b3 = double(bitget(img_grayscale, 3));
b4 = double(bitget(img_grayscale, 4));
b5 = double(bitget(img_grayscale, 5));
b6 = double(bitget(img_grayscale, 6));
b7 = double(bitget(img_grayscale, 7));
b8 = double(bitget(img_grayscale, 8));

%{
img = zeros(size(img_grayscale));
img = bitset(img, 5, b5);
img = bitset(img, 6, b6);
img = bitset(img, 7, b7);
img = bitset(img, 8, b8);
imshow(img);
%}

imwrite(b7+b8, './outputs/eldenring_78.jpg');
imwrite(b5+b6+b7+b8*255, './outputs/eldenring_5678.jpg');

% -----------------------Question 3-----------------------

g_hist = histeq(img_grayscale);
log_hist = histeq(img_log);
inverse_hist = histeq(img_inverse_log);
%imshow(g_hist);

figure
imhist(img_grayscale, 64)
%imhist(g_hist, 64)

% -----------------------Question 4-----------------------



% -----------------------Question 5-----------------------


