
function a=sparsecode(D,data,targetSparsity,p,sc_a)

%inverse thing changed to pinv
    
    m = size(data,2); %m is the no. of training examples
    n = size(D,1); %n is the dimension of the vector space
    k = size(D,2); %k is the no. of atoms in the dictionary
    a = zeros(k,m);
    Id = eye(n,n);
    K = zeros(n,n);
    K(1:p*p,1:p*p)=ones(p*p,p*p);
    K(p*p+1:2*p*p,p*p+1:2*p*p)=ones(p*p,p*p);
    K(2*p*p+1:end,2*p*p+1:end)=ones(p*p,p*p);
    temp_mat=(Id+(sc_a/n*K));
    D=temp_mat*D;
    data=temp_mat*data;
    
    for i=1:m,
        X=data(:,i);
        R=data(:,i);
        phi = zeros(n,k);
        count = 1;
        flag = zeros(1,k,'uint8');
        gamma=zeros(k,1);
        I=zeros(1,k);

        %while(count<=min(k/3,15))
        while(count<=min(targetSparsity,k))

%        while(count<=k && norm(R)>200)
            temp=linspace(1,k,k);
            temp=temp(~logical(flag));
            Dunused = D (:,~logical(flag));
            [ ~, maxDotAtom ] = max (abs (Dunused' * R));
%             [ ~, maxDotAtom ] = max (abs (Dunused'*(Id+(sc_gamma/(p*p))*K) * R));
            maxDotAtom = temp(maxDotAtom);

            I(1,count)=maxDotAtom;
            flag(1,maxDotAtom)=1;
            phi(:,count)=D(:,maxDotAtom);
            phi_current=phi(:,1:count);
            intermMatrix=phi_current'*phi_current;
            gamma(I(1,1:count),1)=(intermMatrix \ phi_current')*X;
            P=phi_current*gamma(I(1,1:count),1);
            count=count+1;
            R=X-P;
       end
%        count
       a(:,i)=gamma;
    end
end
