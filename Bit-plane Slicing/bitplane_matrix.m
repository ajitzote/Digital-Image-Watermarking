%% Function of Bit-plane Slicing

function [plane_1 plane_2 plane_3 plane_4 plane_5 plane_6 plane_7 plane_8] = bitplane_matrix(input_image)

[row col]=size(input_image);
b=zeros(row,col,8);

for k=1:8
    for i=1:row
        for j=1:col
            b(i,j,k)=bitget(input_image(i,j),k);
        end
    end
end
plane_1=b(:,:,1);
plane_2=b(:,:,2);
plane_3=b(:,:,3);
plane_4=b(:,:,4);
plane_5=b(:,:,5);
plane_6=b(:,:,6);
plane_7=b(:,:,7);
plane_8=b(:,:,8);
end
