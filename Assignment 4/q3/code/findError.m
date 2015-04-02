% function err=findError(data,i,p,theta,D)
%     err=0;
%     for count=1:size(data,1)
%         if(giveLabel(data(count,:),i,p,theta)~=data(count,end))
%             err=err+D(count);
%         end
%             
%     end
% end

function err=findError(data,i,p,theta,D)
    res=giveLabel(data,i,p,theta);
    res=res.*data(:,end);
    res=res.*(res==-1);
    res=-1*res.*D;
    err=sum(res);
end