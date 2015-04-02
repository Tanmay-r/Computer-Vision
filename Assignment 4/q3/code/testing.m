function total_err=testing(data,H,draw)

    m=size(data,1);
    err_sum=zeros(m,1);
    for i=1:size(H,1)
       err_sum=err_sum+giveLabel(data,H(i,2),H(i,3),H(i,4))*H(i,1);
    end
    err_sum=sign(err_sum);
    if(draw==1)
        close all
        scatter(data(:,1),data(:,2),5,err_sum,'filled')
        pause
    end
    err_sum=err_sum.*data(:,end);
    err_sum=err_sum.*(err_sum~=1);
    
    total_err=-sum(err_sum);
            
end


% for count=1:m
%         err_sum=0;
%         for i=1:size(H,1)
%            err_sum=err_sum+giveLabel(data(count,:),H(i,2),H(i,3),H(i,4))*H(i,1);
%         end
%         if(sign(err_sum)~=data(count,end))
%             total_err=total_err+1;
%         end
%     end