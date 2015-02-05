function q6(part)

    filename=strcat('../data/Features2D_dataset1.mat');
    load(filename,'f2D');
    
    
    filename=strcat('../data/Features3D_dataset1.mat');
    load(filename,'f3D');
    
    N=size(f2D,2);
    P=zeros(2*N,12);
    
    if part==2
       coordMax=max(abs(f3D(:)));
       f2D(1:2,:) = f2D(1:2,:)+randn(size(f2D(1:2,:),1),size(f2D(1:2,:),2))*0.05*coordMax; 
       f3D(1:3,:) = f3D(1:3,:)+randn(size(f3D(1:3,:),1),size(f3D(1:3,:),2))*0.05*coordMax; 
      
    end
    
%     f2D
%     f3D
    
   
    
    i=1;
    while i<=2*N

       j=(i+1)/2;
       P(i,1:4)=-f3D(:,j);
       P(i,9:12)=f2D(1,j)*f3D(:,j);
       
       P(i+1,5:8)=-f3D(:,j);
       P(i+1,9:12)=f2D(2,j)*f3D(:,j);
       i=i+2;
        
    end
    
    
    [~,~,V] = svd(P);
    c=reshape(V(:,end)',1,12);
    M=reshape(c,4,3)';
       M
    
    Mans=M*f3D;
    Mans(1,:)=Mans(1,:)./Mans(3,:);
    Mans(2,:)=Mans(2,:)./Mans(3,:);
    Mans(3,:)=Mans(3,:)./Mans(3,:);
   
%       Mans
%      f2D
    norm(Mans-f2D,'fro')
    
   
    
    


end