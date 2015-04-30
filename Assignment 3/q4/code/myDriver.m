
 %generate unstable videos
generate_shaky_video_Rigid
generate_shaky_video_Affine
generate_shaky_video_TranslationOnly



rng(0);
%Least Squares
run_stablization(1,1,'../data/shaky/translation_cars.avi','../data/translation_cars_stable.avi');
pause;
run_stablization(2,1,'../data/shaky/rigid_cars.avi','../data/rigid_cars_stable.avi');
pause;
run_stablization(2,1,'../data/shaky/affine_cars.avi','../data/affine_cars_stable.avi');
pause;

%Ransac
run_stablization(1,0,'../data/shaky/translation_cars.avi','../data/translation_cars_ransac_stable.avi');
pause;
run_stablization(2,0,'../data/shaky/rigid_cars.avi','../data/rigid_cars_ransac_stable.avi');
pause;
%run_stablization(2,0,'../data/shaky/affine_cars.avi','../data/affine_cars_ransac_stable.avi');
%pause;