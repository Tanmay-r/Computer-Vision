function plot_motion_sequence(T)
    angle = asin(T(2,1,:));
    angle = angle(:);
    tx = T(1,3,:);
    tx = tx(:);
    ty = T(2,3,:);
    ty = ty(:);
    plot3(angle,tx,ty,'r-');
end