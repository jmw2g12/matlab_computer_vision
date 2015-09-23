function GetTiles( path )
    mkdir('neg_tiles');
    files = dir(path);
    for file = files'
        [pathname,filename,extension] = fileparts(file.name);
        if (strcmp(extension,'.png'))
            img=imread(strcat(path,'/',file.name));
            img11=imcrop(img,[0 0 284 160]);
            img12=imcrop(img,[284 0 284 160]);
            img13=imcrop(img,[568 0 284 160]);
            img21=imcrop(img,[0 160 284 160]);
            img22=imcrop(img,[284 160 284 160]);
            img23=imcrop(img,[568 160 284 160]);
            img31=imcrop(img,[0 320 284 160]);
            img32=imcrop(img,[284 320 284 160]);
            img33=imcrop(img,[568 320 284 160]);
            imwrite(img11,strcat('neg_tiles','/',file.name,'_11.png'));
            imwrite(img12,strcat('neg_tiles','/',file.name,'_12.png'));
            imwrite(img13,strcat('neg_tiles','/',file.name,'_13.png'));
            imwrite(img21,strcat('neg_tiles','/',file.name,'_21.png'));
            imwrite(img22,strcat('neg_tiles','/',file.name,'_22.png'));
            imwrite(img23,strcat('neg_tiles','/',file.name,'_23.png'));
            imwrite(img31,strcat('neg_tiles','/',file.name,'_31.png'));
            imwrite(img32,strcat('neg_tiles','/',file.name,'_32.png'));
            imwrite(img33,strcat('neg_tiles','/',file.name,'_33.png'));
        end
       
    end
end

