clear all;
close all;

%% INPUT IMAGE
input_image = imread('aadhar.jpg');
[r_i, c_i p_i]=size(input_image);
if (p_i==3)
    input_image = rgb2gray(input_image);
else
    input_image = input_image 

end

% Extracting and Displaying Bit-planes
[plane_1,plane_2,plane_3,plane_4,plane_5,plane_6,plane_7,plane_8] = bitplane_matrix(input_image);

    figure, imshow(plane_1);
    title('1st plane');
    figure, imshow(plane_2);
    title('2nd plane');
    figure,imshow(plane_3);
    title('3rd plane');
    figure, imshow(plane_4);
    title('4th plane');
    figure, imshow(plane_5);
    title('5th plane');
    figure, imshow(plane_6);
    title('6th plane');
    figure, imshow(plane_7);
    title('7th plane');
    figure,imshow(plane_8);
    title('8th plane');
  
  % Displaying result
    resultant = (plane_4*8 + plane_5*16 + plane_6*32 + plane_7*64 + plane_8*128)/256;
    figure,imshow(resultant);
    title('Recombined Result');
    figure,imshow(input_image);
    title('Input Image');

%% WATERMARK IMAGE
input_watermark = imread('fp1.jpg');
[r_w, c_w p_w]=size(input_watermark);
if (p_w==3)
    input_watermark = rgb2gray(input_watermark);
else
    input_watermark = input_watermark 

end

 % Scaling for proper superposition
 
 [image_rows, image_columns] = size(input_image);
 
 scaled_watermark = imresize(input_watermark,[image_rows image_columns]);
 figure, imshow(scaled_watermark);
 title('Scaled Watermark');
 
 % Extracting and Displaying Bit-planes
[plane_1w,plane_2w,plane_3w,plane_4w,plane_5w,plane_6w,plane_7w,plane_8w] = bitplane_matrix(scaled_watermark);

    figure, imshow(plane_1w);
    title('1st Watermark plane');
    figure, imshow(plane_2w);
    title('2nd Watermark plane');
    figure,imshow(plane_3w);
    title('3rd Watermark plane');
    figure, imshow(plane_4w);
    title('4th Watermark plane');
    figure, imshow(plane_5w);
    title('5th Watermark plane');
    figure, imshow(plane_6w);
    title('6th Watermark plane');
    figure, imshow(plane_7w);
    title('7th Watermark plane');
    figure,imshow(plane_8w);
    title('8th Watermark plane');
  
  % Displaying result
    resultant_w = (plane_6w*32 + plane_7w*64 + plane_8w*128)/256;
    figure,imshow(resultant_w);
    title('Recombined Input Watermark');
    figure,imshow(input_watermark);
    title('Input Watermark');    

 %% WATERMARKING

  % Displaying result
    watermarked_image = (plane_6w*1 + plane_7w*2 + plane_8w*4 + plane_4*8 + plane_5*16 + plane_6*32 + plane_7*64 + plane_8*128);
    watermarked_image_for_display = (plane_6w*1 + plane_7w*2 + plane_8w*4 + plane_4*8 + plane_5*16 + plane_6*32 + plane_7*64 + plane_8*128)/256;
    figure,imshow(watermarked_image_for_display);
    title('Watermarked Image');
    
    
%% WATERMARK AND IMAGE SEPARATION AND BIT-PLANE DISPLAY
[plane_1e,plane_2e,plane_3e,plane_4e,plane_5e,plane_6e,plane_7e,plane_8e] = bitplane_matrix(watermarked_image);

    figure, imshow(plane_1e);
    title('1st extracted plane');
    figure, imshow(plane_2e);
    title('2nd extracted plane');
    figure,imshow(plane_3e);
    title('3rd extracted plane');
    figure, imshow(plane_4e);
    title('4th extracted plane');
    figure, imshow(plane_5e);
    title('5th extracted plane');
    figure, imshow(plane_6e);
    title('6th extracted plane');
    figure, imshow(plane_7e);
    title('7th extracted plane');
    figure,imshow(plane_8e);
    title('8th extracted plane');

 extracted_watermark_1 = (plane_1e*32 + plane_2e*64 + plane_3e*128)/256;
 extracted_watermark = adapthisteq(extracted_watermark_1,'NumTiles',[8 6],'Cliplimit',0.125); 
                    % This toolbox function performs so-called contrast-limited  
                    % adaptive histogram equalization (CLAHE). 'NumTiles' 
                    % divides the given image into 8x6 tile(section) image. 
                    % 'Cliplimit' keeps the contrast limited from 0 to 1.  
 figure, imshow(extracted_watermark);
 title('Extracted Watermark');
 
 extracted_aadhar = (plane_4e*8 + plane_5e*16 + plane_6e*32 + plane_7e*64 + plane_8e*128)/256;
 figure, imshow(extracted_aadhar);
 title('Extracted Aadhar');
 
 %% ERROR ANALYSIS
 
 outside_watermark = imread('fp2.jpg');
 [ew_rows, ew_columns] = size(extracted_watermark);
 
 external_watermark = imresize(outside_watermark,[ew_rows ew_columns]);

error = MSE (extracted_watermark, external_watermark)
 



    