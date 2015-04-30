function Output=generateMosiacData(Image,filter)
    close all
    rng (0);
    
    height=size(Image,1);
    width=size(Image,2);
    
    Filter = zeros(height,width,3);
    
    if(filter==1)
        
        Filter(:,:,1) =repmat([0 0;0 1], height/2,floor(width/2));
        Filter(:,:,3) =repmat([1 0;0 0], height/2,floor(width/2));
        Filter(:,:,2) =repmat([0 1;1 0], height/2,floor(width/2));
        
    elseif(filter==2)
        for i=1:size(Filter,1)
            for j=1:size(Filter,2)
                Filter(i,j,randi(3))=1;
            end
        end 
    end
    
    Output =double(Image).*double(Filter);
end