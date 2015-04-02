function label=giveLabel(data,i,p,theta)
%     label=sign(p*(data(i)-theta));

    
    m=size(data,1);
    label=sign(p*(data(:,i)-theta*ones(m,1)));
    if(p==-1) %label is 1 
        label=label-ones(m,1);
        label=label.*(label~=-1);
        label=label+ones(m,1);
    else
        label=label+ones(m,1);
        label=label.*(label~=1);
        label=label-ones(m,1);
    end
%     if(label==0)
%         if(p==-1)
%             label=1;
%         else
%             label=-1;
%         end
%     end
end

% 
% function label=giveLabel(data,i,p,theta)
%     m=size(data,1);
%     label=sign(p*(data(:,i)-theta(ones(m,1),1)));
% %     if(p==-1)
% %         temp=1;
% %     else
% %         temp=-1;
% %     end
% %     zeroInd=find(label==0);
% %     label(zeroInd)=temp(ones(size(zeroInd)),1);
% end