function [T] = estimateMotionTwoFrames(Img1,Img2,fn)
    [num matchedPoints] = match(Img1,Img2);
    x1 = matchedPoints(:,1:2)';
    x2 = matchedPoints(:,3:4)';
    %T = ransacfithomography(x1,x2,0.0001);
    %T = ransacfitRotTrans(x1,x2,10);
    T = fn(x1,x2,20);
end