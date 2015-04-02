function q3()

    size1=2000;
    train1=1000;
    
    dataset1=zeros(size1,3);
    dataset1(:,1)=rand(size1,1);
    dataset1(:,2)=rand(size1,1);
    dataset1 = datasample(dataset1,size(dataset1,1),1,'Replace',false);
    
    for i=1:size1 
       x=dataset1(i,1);
       y=dataset1(i,2);
       
       if(x>=0.3 && x<=0.7 && y>=0.3 && y<=0.7)
           dataset1(i,3)=1;
       else
           dataset1(i,3)=-1;
       end
    end
    
    [H,train_err,test_err]=adaboost(dataset1(1:train1,:),dataset1(train1+1:end,:),30);
    close all
    temp=linspace(1,30,30);
    figure
    plot(temp,train_err,temp,test_err);
    title('Training Set and Testing Set v/s the number of rounds');
    ylabel('Error');
    xlabel('Number of Rounds');
    legend('Error on Training Set','Error on testing Set');
    pause

    
    [total_err1]=testing(dataset1(train1+1:end,:),H,1);
    'Dataset 1'
    total_err1
    %----------------------------------------
    
    dataset2=zeros(size1,3);
    dataset2(:,1)=rand(size1,1);
    dataset2(:,2)=rand(size1,1);
    dataset2 = datasample(dataset2,size(dataset2,1),1,'Replace',false);
    
    for i=1:size1 
       x=dataset2(i,1);
       y=dataset2(i,2);
       
       if(x>=0.3 && x<=0.7 && y>=0.3 && y<=0.7)
           dataset2(i,3)=1;
       elseif((x>=0.15 && x<=0.25) || (x>=0.75 && x<=0.85))
           dataset2(i,3)=1;
       elseif((y>=0.15 && y<=0.25) || (y>=0.75 && y<=0.85))
           dataset2(i,3)=1;
       else
           dataset2(i,3)=-1;
       end
    end
    
    [H,train_err,test_err]=adaboost(dataset2(1:train1,:),dataset2(train1+1:end,:),30);

    close all
    temp=linspace(1,30,30);
    figure
    plot(temp,train_err,temp,test_err);
    title('Training Set and Testing Set v/s the number of rounds');
    ylabel('Error');
    xlabel('Number of Rounds');
    legend('Error on Training Set','Error on testing Set');
    pause
    
    [total_err1]=testing(dataset2(train1+1:end,:),H,1);
    'Dataset 2'
    total_err1
    %----------------------------------------
    
    dataset3=zeros(size1,3);
    dataset3(:,1)=randn(size1,1)*2;
    dataset3(:,2)=randn(size1,1)*2;
    dataset3 = datasample(dataset3,size(dataset3,1),1,'Replace',false);
    
    for i=1:size1
       
       if(norm(dataset3(i,1:2))<2)
           dataset3(i,3)=1;
       else
           dataset3(i,3)=-1;
       end
    end
    
    [H,train_err,test_err]=adaboost(dataset3(1:train1,:),dataset3(train1+1:end,:),30);

    close all
    temp=linspace(1,30,30);
    figure
    plot(temp,train_err,temp,test_err);
    title('Training Set and Testing Set v/s the number of rounds');
    ylabel('Error');
    xlabel('Number of Rounds');
    legend('Error on Training Set','Error on testing Set');
    pause
    
    [total_err1]=testing(dataset3(train1+1:end,:),H,1);
    'Dataset 3'
    total_err1
    %----------------------------------------
    
    dataset4=zeros(size1,3);
    dataset4(:,1)=randn(size1,1)*2;
    dataset4(:,2)=randn(size1,1)*2;
    dataset4 = datasample(dataset4,size(dataset4,1),1,'Replace',false);
    
    for i=1:size1
       
       if((norm(dataset4(i,1:2))<2) || (norm(dataset4(i,1:2))>=2.5 && norm(dataset4(i,1:2))<=3))
           dataset4(i,3)=1;
       else
           dataset4(i,3)=-1;
       end
    end
    
    [H,train_err,test_err]=adaboost(dataset4(1:train1,:),dataset4(train1+1:end,:),30);
%     train_err
%     test_err
%     pause
    
    close all
    temp=linspace(1,30,30);
    figure
    plot(temp,train_err,temp,test_err);
    title('Training Set and Testing Set v/s the number of rounds');
    ylabel('Error');
    xlabel('Number of Rounds');
    legend('Error on Training Set','Error on testing Set');
    pause
    
    [total_err1]=testing(dataset4(train1+1:end,:),H,1);
    'Dataset 4'
    total_err1
    %----------------------------------------
    
    A=dlmread('../data/images_training.txt');
    B=dlmread('../data/labels_training.txt');
    size4=1000;
    dataset5=-1*ones(size4,170);
    
    for i=1:size4
       temp=A(:,(i-1)*13+1:13*i);
       dataset5(i,1:end-1)=temp(:);
       if(B(i)==3)
           dataset5(i,end)=1;
       end
       
    end
    
    A=dlmread('../data/images_testing.txt');
    B=dlmread('../data/labels_testing.txt');
    test_dataset5=-1*ones(size4,170);
    
    for i=1:size4
       temp=A(:,(i-1)*13+1:13*i);
       test_dataset5(i,1:end-1)=temp(:);
       if(B(i)==3)
           test_dataset5(i,end)=1;
       end
       
    end
    
  
    [H,train_err,test_err]=adaboost(dataset5,test_dataset5,30);

    
    close all
    temp=linspace(1,30,30);
    figure
    plot(temp,train_err,temp,test_err);
    title('Training Set and Testing Set v/s the number of rounds');
    ylabel('Error');
    xlabel('Number of Rounds');
    legend('Error on Training Set','Error on testing Set');
    pause
    
    
    
    [total_err1]=testing(test_dataset5,H,0);
    'Dataset 5'
    total_err1
    
    %--------------------------------------

end


