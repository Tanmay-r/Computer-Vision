function [dictionaryPic]=display_dictionary(D,p,numDisplay)

    D=mat2gray(D);
    dictsize=size(D,2);

    dictionaryPic=zeros(p*floor(dictsize/numDisplay),numDisplay*p,3);
    for i=1:dictsize,
        dictionaryPic(floor((i-1)/numDisplay)*p+1:floor((i-1)/numDisplay)*p+p,floor(mod(i-1,numDisplay))*p+1:floor(mod(i-1,numDisplay))*p+p,:)=reshape(D(:,i),p,p,3);
    end
    imagesc (dictionaryPic); axis equal tight;
    %pause
    
    %filename=strcat('./output/D_',int2str(numatoms),'.png');
    %save_image(h, filename, 0);
    
    %dictsize

end