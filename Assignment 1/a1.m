% CPS 843 Assignment 1
% Udbhav Prasad - 500909034

% -----------------------Part 1 - Problem 1-----------------------

img_color = imresize(imread('./images/eldenring.jpg'), 0.25);

img_grayscale = rgb2gray(img_color);
imwrite(img_grayscale, './outputs/eldenring_grayscale.jpg');

% Log Transformation

a = double(img_grayscale)/255;
c = 2;
img_log = c * log(1 + (a));
imwrite(img_log, './outputs/eldenring_log_transform.jpg');

% Inverse Log Transformation

a = double(img_grayscale)/255;
c = 2;
img_inverse_log = (exp(a) .^ (1/c)) - 1;
imwrite(img_inverse_log, './outputs/eldenring_inverse_log_transform.jpg');

% Power Law Transformation

a = double(img_grayscale)/255;
gamma = 0.3;
c = 1;
img_power_law_1 = c * (a .^ gamma);
gamma = 3.0;
img_power_law_2 = c * (a .^ gamma);
imwrite(img_power_law_1, './outputs/eldenring_power_law_whiten.jpg');
imwrite(img_power_law_2, './outputs/eldenring_power_law_blacken.jpg');

% -----------------------Part 1 - Problem 2-----------------------

b1 = double(bitget(img_grayscale, 1));
b2 = double(bitget(img_grayscale, 2));
b3 = double(bitget(img_grayscale, 3));
b4 = double(bitget(img_grayscale, 4));
b5 = double(bitget(img_grayscale, 5));
b6 = double(bitget(img_grayscale, 6));
b7 = double(bitget(img_grayscale, 7));
b8 = double(bitget(img_grayscale, 8));

imwrite(b1, './outputs/eldenring_1.jpg');
imwrite(b2, './outputs/eldenring_2.jpg');
imwrite(b3, './outputs/eldenring_3.jpg');
imwrite(b4, './outputs/eldenring_4.jpg');
imwrite(b5, './outputs/eldenring_5.jpg');
imwrite(b6, './outputs/eldenring_6.jpg');
imwrite(b7, './outputs/eldenring_7.jpg');
imwrite(b8, './outputs/eldenring_8.jpg');

imwrite(b7*(2^6)+b8*(2^7), './outputs/eldenring_78.jpg');
imwrite(b5*(2^4) + b6*(2^5) + b7*(2^6) + b8*(2^7), './outputs/eldenring_5678.jpg');

% -----------------------Part 1 - Problem 3-----------------------

g_hist = histeq(img_grayscale, 256);
power_1_hist = histeq(img_power_law_1, 256);
power_2_hist = histeq(img_power_law_2, 256);

imhist(img_grayscale, 256);saveas(gcf,sprintf('./outputs/original_pre_hist.png'));
imhist(g_hist, 256); saveas(gcf,sprintf('./outputs/original_post_hist.png'));

imhist(img_power_law_1, 256); saveas(gcf,sprintf('./outputs/power_1_pre_hist.png'));
imhist(power_1_hist, 256); saveas(gcf,sprintf('./outputs/power_1_post_hist.png'));

imhist(img_power_law_2, 256); saveas(gcf,sprintf('./outputs/power_2_pre_hist.png'));
imhist(power_2_hist); saveas(gcf,sprintf('./outputs/power_2_post_hist.png'));

% -----------------------Part 1 - Problem 4-----------------------

% No Code for this Question 

% -----------------------Part 1 - Problem 5-----------------------

before = [1 2 4 7 3 2 4 7 3 1 5 6 2 1 1 4 7 1 1 1]; 
histogram(before, 8); saveas(gcf,sprintf('./outputs/manual_pre_hist.png'));

after = [2 4 5 7 4; 4 5 7 4 2; 6 6 4 2 2; 5 7 2 2 2]; 
histogram(after, 8); saveas(gcf,sprintf('./outputs/manual_post_hist.png'));

% -----------------------Part 2 - Problem 1-----------------------

a = 0.45;
T = maketform('affine', [1 0 0; a 1 0; 0 0 1] );

A = imresize(imread('images/eldenring_part2.jpg'), [320, 256]);
h1 = figure; imshow(A); title('Original Image');

orange = [255 127 0]';

R = makeresampler({'cubic','nearest'},'fill');
B = imtransform(A,T,R,'FillValues',orange); 
h2 = figure; imshow(B);
title('Sheared Image');

[U,V] = meshgrid(0:64:320,0:64:256);
[X,Y] = tformfwd(T,U,V);
gray = 0.65 * [1 1 1];

figure(h1);
hold on;
line(U, V, 'Color',gray);
line(U',V','Color',gray);

figure(h2);
hold on;
line(X, Y, 'Color',gray);
line(X',Y','Color',gray);

gray = 0.65 * [1 1 1];
for u = 0:64:320
    for v = 0:64:256
        theta = (0 : 32)' * (2 * pi / 32);
        uc = u + 20*cos(theta);
        vc = v + 20*sin(theta);
        [xc,yc] = tformfwd(T,uc,vc);
        figure(h1); line(uc,vc,'Color',gray);
        figure(h2); line(xc,yc,'Color',gray);
    end
end

R = makeresampler({'cubic','nearest'},'fill');

Bf = imtransform(A,T,R,'XData',[-49 500],'YData',[-49 400],...
                 'FillValues',orange);

figure, imshow(Bf);
title('Pad Method = ''fill''');

R = makeresampler({'cubic','nearest'},'replicate');
Br = imtransform(A,T,R,'XData',[-49 500],'YData', [-49 400]);

figure, imshow(Br);
title('Pad Method = ''replicate''');

R = makeresampler({'cubic','nearest'}, 'bound');
Bb = imtransform(A,T,R,'XData',[-49 500],'YData',[-49 400],...
                 'FillValues',orange);
figure, imshow(Bb);
title('Pad Method = ''bound''');

R = makeresampler({'cubic','nearest'},'fill');
Cf = imtransform(A,T,R,'XData',[423 439],'YData',[245 260],...
                 'FillValues',orange);

R = makeresampler({'cubic','nearest'},'bound');
Cb = imtransform(A,T,R,'XData',[423 439],'YData',[245 260],...
                 'FillValues',orange);

Cf = imresize(Cf,12,'nearest');
Cb = imresize(Cb,12,'nearest');

figure;
subplot(1,2,1); imshow(Cf); title('Pad Method = ''fill''');
subplot(1,2,2); imshow(Cb); title('Pad Method = ''bound''');

Thalf = maketform('affine',[1 0; a 1; 0 0]/2);

R = makeresampler({'cubic','nearest'},'circular');
Bc = imtransform(A,Thalf,R,'XData',[-49 500],'YData',[-49 400],...
                 'FillValues',orange);
figure, imshow(Bc);
title('Pad Method = ''circular''');

R = makeresampler({'cubic','nearest'},'symmetric');
Bs = imtransform(A,Thalf,R,'XData',[-49 500],'YData',[-49 400],...
                 'FillValues',orange);
figure, imshow(Bs);
title('Pad Method = ''symmetric''');
