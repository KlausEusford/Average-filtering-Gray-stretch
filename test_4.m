[filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '请选择图片');                                                                 %打开选择图片的对话框，返回所选图片的文件名以及路径
name=[pathname,filename];                                                         %图片完整路径
try
    img=imread(name);
    [height,width,layer]=size(img); 
    imgNoise=imnoise(img,'salt & pepper',0.02);                                    %加入椒盐躁声

    %若图片为彩色图片
    if(layer==3)    
        r=imgNoise(:,:,1);
        g=imgNoise(:,:,2);
        b=imgNoise(:,:,3);
        r1=medfilt2(r,[3 3]);                                                     %对椒盐噪声进行中值滤波
        g1=medfilt2(g,[3 3]);
        b1=medfilt2(b,[3 3]);
        imgMed = cat(3,r1,g1,b1);

        r2=filter2(fspecial('average',3),r)/255;                                  %对椒盐噪声进行均值滤波
        g2=filter2(fspecial('average',3),g)/255; 
        b2=filter2(fspecial('average',3),b)/255; 
        imgAri=cat(3,r2,g2,b2);
        disp('color');
    %若图片为灰度图片
    else
        imgMed=medfilt2(imgNoise);                                                %对椒盐躁声进行中值滤波
        imgAri=filter2(fspecial('average',3),imgNoise)/255;                       %对椒盐噪声进行均值滤波
        disp('grey');
    end

    figure,
    subplot(1,3,1),imshow(imgNoise);title('椒盐噪声');                             %显示加入椒盐噪声后的图片效果
    subplot(1,3,2),imshow(imgAri);title('均值滤波');                               %显示均值滤波后的图片效果
    subplot(1,3,3),imshow(imgMed);title('中值滤波');                               %显示中值滤波后的图片效果
    imwrite(imgNoise,strrep(name,'.','_Noise.'));                                 %保存各种操作后的图片
    imwrite(imgAri,strrep(name,'.','_Ari.'));    
    imwrite(imgMed,strrep(name,'.','_Med.'));    
catch                                                                             %异常处理
    if name==0
        disp('未选择文件');
    else
        disp('程序出错');
    end
end