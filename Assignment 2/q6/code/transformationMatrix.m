function [T] = transformationMatrix(angle, translationX, translationY)

T = zeros(3, 3);
T(1,1) = cos(angle*pi/180);
T(1,2) = -sin(angle*pi/180);
T(1,3) = translationX;
T(2,1) = sin(angle*pi/180);
T(2,2) = cos(angle*pi/180);
T(2,3) = translationY;
T(3,3) = 1;