% sparsenet.m - Olshausen & Field sparse coding algorithm
% 
% Before running you must first load the training data array IMAGES
% and basis function matrix Phi

batch_size=10;

[imsize, imsize, num_images]=size(IMAGES);
BUFF=4;

[N M]=size(Phi);
sz=sqrt(N);

% learning rate (start out large, then lower as solution converges)
eta = 0.5;

% lambda
lambda = 0.1;                   

a_var=ones(M,1);
var_eta=.1;

I=zeros(N,batch_size);

display_every=100;
display_network(Phi,a_var);

step = 8;

[rows, cols, ~] = size(IMAGES);

t=1;
while (1)
    
    % choose an image for this batch

    imi=ceil(num_images*rand);

    % extract subimages at random from this image to make data array I

    for i=1:batch_size
%        r=BUFF+ceil((imsize-sz-2*BUFF)*rand);
%        c=BUFF+ceil((imsize-sz-2*BUFF)*rand);
        for r = 1:step:rows
            for c = 1:step:cols
                fprintf('Processing row: %d, column: %d\n', r, c);
                I(:,i)=reshape(IMAGES(r:r+sz-1,c:c+sz-1,imi),N,1);
            end
        end
    end


    % calculate coefficients for these data via LCA

    ahat = sparsify(I,Phi,lambda);

    % calculate residual error

    R=I-Phi*ahat;

    % update bases

    dPhi = eta*R*ahat'/batch_size;
    Phi = Phi + dPhi;
    Phi=Phi*diag(1./sqrt(sum(Phi.*Phi))); % normalize bases

    % accumulate activity statistics
    
    a_var=(1-var_eta)*a_var + var_eta*mean(ahat.^2,2);

    % display

    if (mod(t,display_every)==0)
        display_network(Phi,a_var);
    end
    
    fprintf('trial %d\r',t);
    t=t+1;

end
