I = (imread('D:\imagepro\samp.jpeg'));
I=rgb2gray(I);
I=double(I);
I=I/255;
originalimage=I;
I=imresize(I,[716/2,1028/2]); 
%figure,imshow(I);


W = (imread('D:\imagepro\thumb.jpeg'));
W=rgb2gray(W);
W=double(W);
W=W/255;
watermark=W;
W=imresize(W,[716/2,1026/2]);
figure()%,imshow(W);
 subplot(2,2,1),imshow(I);title('original asset image');
 subplot(2,2,2),imshow(W);title('original watermark image');

% figure,imshow(T);
% I=[1,3,5;2,4,6;7,8,9;10,12,11];
[r,c]=size(I); %size of image
[r1,c1]=size(W); %size of watermark
wmsz=r1*c1; %watermark size in a vector

D=dct2(I);%get DCT of the Asset image
figure,imshow(D) %showing DCT of the image
title('DCT of original asset image ');
D_vec=reshape(I,1,r*c); %putting all DCT values in a vector
[D_vec_srt,Idx]=sort(abs(D_vec),'descend');%re-ordering all the absolute values
%where D_vec_srt shows the decreasing order of the D_vec and Idx shows the
% position number the corresponding D_vec_srt was in D_vec


W_vec=reshape(W,1,r1*c1);%putting all watermark values in a vector
Idx2=Idx(2:wmsz+1);%choosing r1*c1 biggest values other than the DC value 
%we are excluding the DC value 1 and starting from 2 because of that
%finding associated row-column of the DCT image order for vector values
IND=zeros(wmsz,2);%this is matrix which will store the corresponding destination of the vector which was in decreasing order

for k=1:1:wmsz
 m=mod(Idx2(k),r);
 if (m==0)
     x=floor(Idx2(k)/r);%associated culomn in the image
 else
     x=floor(Idx2(k)/r)+1;%associated culomn in the image
 end
 
 modrow=mod(Idx2(k),r);
 if(modrow==0)
     modrow=r;
 end
 
 y=modrow;%associated row in the image
 IND(k,1)=y;
 IND(k,2)=x;
end
D_w=D;
for k=1:wmsz
 %insert the WM signal into the DCT values
D_w(IND(k,1),IND(k,2))=D_w(IND(k,1),IND(k,2))+.1*D_w(IND(k,1),IND(k,2)).*W(k);
end 

I2=idct2(D_w);%inverse DCT to produce the watermarked asset 

figure()
subplot(2,2,1),imshow(I2);title('image after adding waterwark ');
subplot(2,2,2),imshow(I);title('image original image ');

%%now the procedure to extract the watermark and getting the image after
%%removing watermark


W2=[];%will contain watermark signal extracted from the image
for k=1:1:wmsz
 W2(k)=(((D_w(IND(k,1),IND(k,2))-D(IND(k,1),IND(k,2)))*10)/D(IND(k,1),IND(k,2)));%watermark extraction
end

yo = vec2mat(W2,r1); %converting the watermak wector W2 in a matrix 
watermark=transpose(yo); %and transposing it to get the watermark
 

figure()
subplot(2,2,1),imshow(watermark);title('the retrieved watermark')%this is the retrieved watermark
subplot(2,2,2),imshow(W);title('original watermark')

%now checking the image which was retrieved after removing waterwark
Watermarkvec=reshape(watermark,1,r1*c1);%putting all watermark images spacial values in a vector

%taking the dct of the I2 which is the watermarked image
DW1=dct2(I2);
for k=1:wmsz
 %remove the WM signal from the DCT values
DW1(IND(k,1),IND(k,2))=DW1(IND(k,1),IND(k,2))-.1*DW1(IND(k,1),IND(k,2)).*Watermarkvec(k);
end 
image_after_removing_watermark=idct2(DW1);
figure()
subplot(2,2,1),imshow(image_after_removing_watermark);title('image_after_removing_watermark');
subplot(2,2,2),imshow(I);title('original image');


error_originalAsset_and_asset_after_adding_watermark=MSE(I2,I);
error_originalAsset_and_asset_after_removing_watermark=MSE(image_after_removing_watermark,I);
error_originalWatermark_and_watermarkRetrieved=MSE(watermark,W);
error_originalImage_and_watermarkRetrieved=MSE(watermark,I);




