% CPS 843 Assignment 2
% Udbhav Prasad - 500909034

% -----------------------Part 1 - Problem 1-----------------------

img_color = imresize(imread('./images/eldenring.jpg'), 0.5);

img_grayscale = rgb2gray(img_color);
imwrite(img_grayscale, './outputs/eldenring_grayscale.jpg');

robert_image = edge(img_grayscale, 'Roberts');
prewitt_image = edge(img_grayscale, 'Prewitt');
sobel_image = edge(img_grayscale, 'Sobel');

imwrite(robert_image, './outputs/eldenring_robert.jpg');
imwrite(prewitt_image, './outputs/eldenring_prewitt.jpg');
imwrite(sobel_image, './outputs/eldenring_sobel.jpg');

% -----------------------Part 1 - Problem 3-----------------------

h = fspecial('gaussian',5,2.5);

k = 1;
diff_img = img_grayscale - imfilter(img_grayscale, h);
highboost_img_1 = img_grayscale + k * diff_img;

k = 5;
diff_img = img_grayscale - imfilter(img_grayscale, h);
highboost_img_5 = img_grayscale + k * diff_img;

imwrite(highboost_img_1, './outputs/eldenring_sharpen_1.jpg');
imwrite(highboost_img_5, './outputs/eldenring_sharpen_5.jpg');

% -----------------------Part 1 - Problem 4-----------------------

noised_img_1 = imnoise(img_grayscale,'gaussian',0,0.005);
noised_img_2 = imnoise(img_grayscale,'gaussian',0.2,0.001);

g_img_1 = filter2(fspecial('gaussian', 10), noised_img_1) / 255;
average_img_1 = filter2(fspecial('average', 5), noised_img_1) / 255;

g_img_2 = filter2(fspecial('gaussian', 10), noised_img_1) / 255;
average_img_2 = filter2(fspecial('average', 5), noised_img_2) / 255;

imwrite(noised_img_1, './outputs/eldenring_noise_1.jpg');
imwrite(noised_img_2, './outputs/eldenring_noise_2.jpg');

imwrite(g_img_1, './outputs/eldenring_g_1.jpg');
imwrite(average_img_1, './outputs/eldenring_average_1.jpg');
imwrite(g_img_2, './outputs/eldenring_g_2.jpg');
imwrite(average_img_2, './outputs/eldenring_average_2.jpg');

% -----------------------Part 2 - Problem 1-----------------------

A = imresize(imread('./images/eldenring.jpg'), 0.5);

AInv = imcomplement(A);
imshow(AInv);

BInv = imreducehaze(AInv);
imshow(BInv);

B = imcomplement(BInv);

montage({A,B});

BInv = imreducehaze(AInv, 'Method','approx','ContrastEnhancement','boost');
BImp = imcomplement(BInv);
figure, montage({A, BImp});

A = imread('images\eldenring2.jpg');

AInv = imcomplement(A);

BInv = imreducehaze(AInv,'ContrastEnhancement','none');

B = imcomplement(BInv);

montage({A,B});

Lab = rgb2lab(A);

LInv = imcomplement(Lab(:,:,1) ./ 100);

LEnh = imcomplement(imreducehaze(LInv,'ContrastEnhancement','none'));

LabEnh(:,:,1)   = LEnh .* 100;
LabEnh(:,:,2:3) = Lab(:,:,2:3) * 2; % Increase saturation

AEnh = lab2rgb(LabEnh);
montage({A,AEnh});

B = imguidedfilter(BImp);
montage({BImp,B});

A = imread('lowlight_21.jpg');

AInv = imcomplement(A);

[BInv,TInv] = imreducehaze(AInv,'Method','approxdcp','ContrastEnhancement', 'none');

T = imcomplement(TInv);

tiledlayout(1,2)
nexttile
imshow(A)
title('Lowlight Image')
nexttile
imshow(T)
title('Illumination Map')
colormap(hot)
