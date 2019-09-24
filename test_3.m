l=-1;
while(l~=1)                                                                             %选择一张灰度图片。若为非灰度图片，重新选择。
    if(l~=-1)
        fprintf('非灰度图片，请重新选择。\n');
    end
    [filename, pathname] = uigetfile( ...
    {'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },...
    '请选择灰度图片');                                                                    %打开选择图片的对话框，返回所选图片的文件名以及路径
    name=[pathname,filename];                                                            %图片完整路径
    try
        img = imread(name);
        [h,w,l]=size(img); 
    catch
        disp('未选择文件');
        return;
    end
end

try
    img_double = im2double(img);
    sp=img_double(:,:,1);
    maxDN=max(max(sp));
    minDN=min(min(sp));

    if(maxDN-minDN==1)
        minDN=0.2;
        maxDN=0.6;
    end
    imgStretch=imadjust(img,[minDN maxDN], []);                                         %进行灰度拉伸

    nameStretch=strrep(name,'.','_灰度拉伸.');  
    imwrite(imgStretch,nameStretch);                                                    %将灰度拉伸结果保存在imgStretch中

    %直方图均衡化  

    imgHisteq=histeq(img);
    nameHisteq=strrep(name,'.','_直方图均衡化.');  
    imwrite(imgHisteq,nameHisteq);                                                      %将直方图均衡化结果保存在imgHisteq中

    figure,                                                                             %显示原图、灰度拉伸以及直方图均衡化后的图片。效果对比。
    subplot(3,1,1),imshow(img);title('原图'); 
    subplot(3,1,2),imshow(imgStretch);title('灰度拉伸');
    subplot(3,1,3),imshow(imgHisteq);title('直方图均衡化');

    figure,                                                                             %显示各种操作后的灰度值分布直方图。对比。
    subplot(3,1,1),imhist(img);title('原图'); 
    subplot(3,1,2),imhist(imgStretch);title('灰度拉伸');
    subplot(3,1,3),imhist(imgHisteq);title('直方图均衡化');
catch                                                                                   %异常处理
    if name~=0
        disp('程序出错');
    end
end
