function [rmse_image_arr,D_new,coeff,X,Y,X_old]=ksvd_coloured(param,dictsize,maxIter,numDisplay,p,targetSparsity,sc_a,noiseLevel)

    close all
    rng (0);
    addpath('./common/export_fig/')
    addpath('./common/')
  
    if(param==1)
        numImages=24;
        numData=15000;
        height=512;
        width=768;
        row_lim=height-p+1;
        col_lim=width-p+1;

        A=randperm(row_lim*col_lim*numImages,numData);
        A=sort(A);
        data=zeros(p*p*3,numData);
        j=1;
        for i=1:numImages
            if i<10
                filename=strcat('./down_kodak/IMG000',int2str(i),'.bmp');
            else
                filename=strcat('./down_kodak/IMG00',int2str(i),'.bmp');
            end
            X=imread(filename);


            count=1;
            for ii=1:row_lim,
                for jj=1:col_lim,

                   if(A(j)==((i-1)*row_lim*col_lim)+count)
                        window = X(ii:ii+p-1,jj:jj+p-1,:);
                        temp=window(:);
                        data(:,j)= temp;
                        j=j+1;
                        if(j==numData+1)
                           break
                        end
                   end
                   count=count+1;
                   if(j==numData+1)
                       break
                   end
                end
            end
            i
        end



        mean_data=mean(data);
        mean_data=repmat(mean_data,size(data,1),1);
    %     data_later=data;
        data=data-mean_data;
        var_data=var(data);
        var_data=var_data.*(var_data>0.2); %based on data

        dataSelected = data(:,logical(var_data));
        dataSelected = datasample(dataSelected,10000,2,'Replace',false);
    end
    
    filename=strcat('./down_kodak/test1.jpg');
    X=imread(filename);
    X=X(1:2:end,1:2:end,:);
    X=X(:,1:end-1,:);
    
    
%     X=X(1:200,1:200,:);
    row_lim=size(X,1)-p+1;
    col_lim=size(X,2)-p+1;
    X_old=X;
    X=double(X);
%     X=double(X)+double(noiseLevel*randn(size(X)));
    X = generateMosiacData(X,2);
    filename=strcat('./output_images/noisyimage_',int2str(dictsize),'.png');
        imwrite(mat2gray(X),filename);
%     Y = sum(X,3);
%     Juint8 = uint8(Y);
%     J = demosaic(Juint8,'bggr');
    
    rmse_image_arr=[];
    for dotflag=1:1

        if(param==1 || param==3) 
        [D]=my_ksvd (param,dataSelected,dictsize,maxIter,p,numDisplay,targetSparsity,sc_a*dotflag); %Threshold not clear take a clear patch
        filename=strcat('./output/D_',int2str(dictsize),'_',int2str(1),'.mat');
        save(filename,'D');
        D_new=ones(size(D,1),size(D,2)+1);
        D_new=D_new/p;
        D_new(:,2:end)=D;

        'matrix saved'

        elseif(param==2)
        filename=strcat('./output/D_',int2str(dictsize),'_',int2str(1),'.mat');
        load(filename,'D');
        D_new=ones(size(D,1),size(D,2)+1);
        D_new=D_new/p;
        D_new(:,2:end)=D;

        'matrix loaded'
        end

        count=1;
        for ii=1:row_lim,
            for jj=1:col_lim,
               window = X(ii:ii+p-1,jj:jj+p-1,:);
               temp=window(:);
               data(:,count)= temp;
               count=count+1;
            end
        end


        coeff=sparsecode(D_new,data,targetSparsity,p,sc_a*dotflag);
        filename=strcat('./output/coeff_',int2str(dictsize),'_',int2str(dotflag),'.mat');
        save(filename,'coeff');

        Y_new=D_new*coeff;   
%         Y=zeros(size(X,1),size(X,2),size(X,3));
        Y_sum=zeros(size(X,1),size(X,2),size(X,3));
        count_sum=zeros(size(X,1),size(X,2),size(X,3));
        temp=ones(p,p,3);
        count=1;
        for i=1:row_lim,
            for j=1:col_lim,
               pCrosspMat=reshape(Y_new(:,count),p,p,3);
               Y_sum(i:i+p-1,j:j+p-1,:)=Y_sum(i:i+p-1,j:j+p-1,:)+pCrosspMat;
               count_sum(i:i+p-1,j:j+p-1,:)=count_sum(i:i+p-1,j:j+p-1,:)+temp;
               count=count+1;
            end
        end
        Y=Y_sum./count_sum;
        filename=strcat('./output/Y_',int2str(dictsize),'_',int2str(dotflag),'.mat');
        save(filename,'Y');

%         rmse_image=(double(Y(:))-double(X_old(:))).^2;
%         rmse_image=sqrt(sum(rmse_image)/(size(Y,1)*size(Y,2)*size(Y,3)));

        
        
        filename=strcat('./output_images/outpimage_',int2str(dictsize),'_',int2str(sc_a),'.png');
        imwrite(mat2gray(Y),filename);
        filename=strcat('./output_images/origimage_',int2str(dictsize),'_',int2str(dotflag),'.png');
        imwrite(mat2gray(X_old),filename);
        
        error = double(Y(:))-double(X_old(:));
        MSE = sum(sum(error .* error)) / (size(error,1) * size(error,2));
        peaksnr = 10*log(255*255/MSE) / log(10);
        peaksnr
        rmse_image_arr=[rmse_image_arr peaksnr];

    end
    
    
   
end