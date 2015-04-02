function [min_i,min_p,min_theta,min_err_curr]=learnAlgo(data,D)

    m=size(data,1);
    d=size(data,2)-1;
    min_i=0;
    min_p=0;
    min_theta=0;
    min_err_curr=m+1;
    
    for p=-1:2:1
       for i=1:d
           for theta=-6:0.01:6
               err=findError(data,i,p,theta,D);
               if(err<min_err_curr)
                   min_err_curr=err;
                   min_i=i;
                   min_p=p;
                   min_theta=theta;
               end
           end
       end
    end
   
end