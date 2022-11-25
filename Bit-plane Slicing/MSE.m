%% MEAN SQUARE ERROR FUNCTION

function err = MSE (pic1, pic2)
e=0;
[m,n]=size(pic1);
for i=1:m
for j=1:n
e = e + double((pic1(i,j)-pic2(i,j))^2);
end
end
err = e / (m*n);
end