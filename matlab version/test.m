for imi=1:num_images
    
    fprintf('image %d\n',imi);
    
    r=BUFF+ceil((imsize-sz-2*BUFF)*rand(bsize,1));
    c=BUFF+ceil((imsize-sz-2*BUFF)*rand(bsize,1));

    for i=1:bsize
        batch(:,i)=reshape(IMAGES(r(i)+pind,c(i)+pind,imi),N,1);
    end
    
    X=[X batch];
    Xcoord=[Xcoord [r'; c']];
end
