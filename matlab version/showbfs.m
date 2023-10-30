% showbfs.m - function to show basis functions
%
% function showbfs(A,clim,dims)
%
% A     bf matrix
% clim  clipping limits [min max]
% dims  dimensions of display array [rows cols]

function array = showbfs(A,clim,dims)

[L M]=size(A);

if ~exist('clim','var')
    rescale=1;
    clim=[-1 1];
elseif isempty(clim)
    rescale=1;
    clim=[-1 1];
else
    rescale=0;
end

if ~exist('dims','var')
    n=floor(sqrt(M));
    m=ceil(M/n);
else
    n=dims(1);
    m=dims(2);
end

sz=sqrt(L);

buf=1;

array=clim(2)*ones(buf+n*(sz+buf),buf+m*(sz+buf));

for k=1:M
    
    j=mod(k-1,m)+1;
    i=floor((k-1)/m)+1;

    if rescale==1
        maxA=max(abs(A(:,k)));
        bfim=reshape(A(:,k),sz,sz)/maxA;
    else
        bfim=reshape(A(:,k),sz,sz);
    end
    
    array(buf+(i-1)*(sz+buf)+[1:sz],buf+(j-1)*(sz+buf)+[1:sz])=bfim;

end

colormap gray

imagesc(array,clim), axis image off

