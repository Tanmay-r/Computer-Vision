function [H, train_err, test_err]=adaboost(data,testData,T)
    % datapoints are in different rows %
    m=size(data,1);
    D_curr=ones(m,1);
    D_curr=D_curr/m;
    H=zeros(T,4);
    train_err=zeros(T,1);
    test_err=zeros(T,1);
    
    
    
    for i=1:T
        [h_i,h_p,h_theta,err_curr]=learnAlgo(data,D_curr);
%         err_curr=findError(data,h_i,h_p,h_theta,D_curr);
        if(err_curr>0.5)
            break
        end
        curr_alpha=0.5*log((1-err_curr)/err_curr);
        H(i,1)=double(curr_alpha);
        H(i,2)=h_i;
        H(i,3)=h_p;
        H(i,4)=h_theta;
        
        
        %Processing after each round%
        
        train_err(i)=testing(data,H(1:i,:),0);
        test_err(i)=testing(testData,H(1:i,:),0);
        
        
        
        %------------------------------%
        D_curr=D_curr.*exp(-curr_alpha*data(:,end).*giveLabel(data,h_i,h_p,h_theta));
        z=sum(D_curr);
        D_curr=D_curr/z;
        
    end

end






