
im_path = imageDatastore('F:\Sagar\Docs\College\UB\Fall 2021\DIP\DIP_HW3\camera_man.tiff');
img = read(im_path);

dimg = im2double(img);
[m,n] = size(dimg);
disp([m,n]);
p = 2 * m;
q = 2 * n;

disp('Padding Sizes P & Q');
disp([p,q]);

%STEP 2

pad_img  = padarray(dimg, [p/2, q/2], 0, 'post');
figure;imshow(pad_img);title('Padded Image')
imsave()

%STEP 3

cen = zeros(p,q);
for i = 1:p
    for j = 1:q
        cen(i,j) = pad_img(i,j).*(-1).^(i + j);
    end
end

figure;imshow(cen);title('Centered Image')
imsave()

%STEP 4

dft = fft2(cen);
figure;imshow(dft);title('DFT Spectrum')
imsave()

%STEP 5

[x,y] = freqspace(p,'meshgrid');
H=zeros(p,q);
a= p/2;
b= q/2;
sigma= 0.1;
for i=1:p
    for j=1:q
        H(i,j)=exp(-((i-a).^2 + (j-b).^2)/ 2*sigma ^2);
    end
end

figure;imshow(H);title('LPF')
imsave()

%STEP 6

g= zeros(p,q);
g= dft.*H;

figure;imshow(g);title('Spectrum of product of H and F')
imsave()

%STEP 7

i_dft = ifft2(g);

inverse_img = zeros(p,q);
for i = 1:p
    for j = 1:q
        inverse_img(i,j) = i_dft(i,j).*(-1).^(i + j);
    end
end

figure;imshow(inverse_img);title('Inverse Image')
imsave()

%STEP 8

depadded_img = zeros(m,n);
for i = 1:m
    for j = 1:n
        depadded_img(i,j) = inverse_img(i,j);
    end
end

figure;imshow(depadded_img);title('Depadded')
imsave()
