% gen_patches.m
%
% creates an array of image patches randomly drawn from all images
% assumes IMAGES defined

BUFF=4;

% patch size
sz=8;

% total number of patches
num_patches=10000;

[imsize imsize num_images]=size(IMAGES);

pind=0:sz-1;
N=sz*sz;

bsize=floor(num_patches/num_images);
batch=zeros(N,bsize);

X=[];
Xcoord=[];

step = 8;

[rows, cols] = size(IMAGES);

for imi=1:num_images
    
    fprintf('image %d\n',imi);
    
    for r = 1:step:rows
        for c = 1:step:cols
 %   r=BUFF+ceil((imsize-sz-2*BUFF)*rand(bsize,1));
 %   c=BUFF+ceil((imsize-sz-2*BUFF)*rand(bsize,1));
            fprintf('Processing row: %d, column: %d\n', r, c);
            for i=1:bsize
                batch(:,i)=reshape(IMAGES(r(i)+pind,c(i)+pind,imi),N,1);
            end
        end
    end
    
    X=[X batch];
    Xcoord=[Xcoord [r'; c']];
end
